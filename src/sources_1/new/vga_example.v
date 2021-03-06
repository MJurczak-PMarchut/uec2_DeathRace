// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 100 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.


`include "verilog_macro_bus.vh"

module vga_example (
  input wire clk,
  input wire rst,
  input wire LEFT,RIGHT,START,Restart,
  input wire vauxp6,
  input wire vauxn6,
  input wire vauxp7,
  input wire vauxn7,
  input wire butt0,
  input wire butt1,
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b
    );

wire [`VGA_BUS_SIZE - 1 : 0] vga_bus [3:-2];
wire [`MOUSE_BUS_SIZE - 1 : 0] mouse_bus [1:0] ;


  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.

  wire clk_in;
  wire locked;
  wire clk_fb;
  wire clk_ss;
  wire clk_out;
  wire pclk,pclk_mirror;
  wire pclk100;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg [7:0] safe_start = 0;


clk_wiz_0 myClk(
    .clk_out1(pclk100),
    .clk_in1(clk),
    .locked(locked),
    .clk_out2(pclk),
    .reset(1'b0)
);


  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );

wire [18:0] address;
wire [3:0] rgb_back;
wire playerCount;
wire [3:0] car0_direction, car1_direction; 
 `VGA_SPLIT_INPUT(vga_bus[2])
  
  
// wire [`VGA_BUS_SIZE - 1 : 0] vga_bus [1:0];
//     wire [18:0] address;
//     wire [3:0] rgb_back;
     
 




  vga_timing my_timing (
    .vga_out(vga_bus[-1]),
    .pclk(pclk),
    .rst(!rst)
  );
  wire Title_Sel,Wait_for_Game,Time_out,GameOn,dual,single,GameScreen_sel,wait_for_start;
  
  adc my_adc(
    .clk(pclk100),
    .vauxp6(vauxp6),
    .vauxn6(vauxn6),
    .vauxp7(vauxp7),
    .vauxn7(vauxn7),
    .vga_in(vga_bus[-1]),
    .direction0_out(car0_direction),
    .direction1_out(car1_direction)
  );
  
  State_Master MasterFSM(
    .rst(!rst),
    .START(START),
    .UP(LEFT),
    .DOWN(RIGHT),
    .Timer(Time_out),
    .playerCount(playerCount),
    .title_screen(Title_Sel),
    .GameOn(GameOn),
    .restart(Restart),
    .clk(pclk),
    .wait_for_start(wait_for_start)
  );
  
  Title_Screen MyTitle(
  
    .pclk(pclk),
    .vga_in(vga_bus[-1]),
    .vga_out(vga_bus[0]),
    .playerCount(playerCount)
  
  );
  
  
  Screen_mux Screen_Mux(
    .TitleScreen(vga_bus[0]),
    .GameScreen(vga_bus[1]),
    .vga_out(vga_bus[2]),
    .TitleScreen_sel(Title_Sel),
    .GameScreen_sel(GameOn)
  
  );
  
  vga Game(
    .rst(rst || wait_for_start),
    .clk(pclk),
    .go0(butt0),
    .go1(butt1),
    .direction({car0_direction,car1_direction}),
    .vga_in(vga_bus[-1]),
    .NoOfPlayers(playerCount),
    .vga_out(vga_bus[1]),
    .TimeOut(Time_out)
  
  );
  
  
  always @(posedge pclk)
 begin
   vs <= vsync_in;
   hs <= hsync_in;
   
   {r,g,b} <= ((vblnk_in == 0) && (hblnk_in == 0))?rgb_in:12'h000;
 end


endmodule
