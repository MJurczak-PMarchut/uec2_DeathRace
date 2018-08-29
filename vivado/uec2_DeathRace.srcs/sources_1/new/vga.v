// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 100 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.


`include "verilog_macro_bus.vh"

module vga (
//  inout wire ps2_data,
//  inout wire ps2_clk,
  input wire clk,
  input wire [15:0] sw,
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror,
  input wire rst
    );

wire [`VGA_BUS_SIZE - 1 : 0] vga_bus [3:-1];
wire [`MOUSE_BUS_SIZE - 1 : 0] mouse_bus [1:0] ;


  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.

  wire clk_in;
  wire locked;
  wire clk_fb;
  wire clk_ss;
  wire clk_out;
  wire pclk;
  wire pclk100;
  wire NoOfPlayers;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg [7:0] safe_start = 0;


clk_wiz_0 myClk(
    .clk_out1(pclk100),
    .clk_in1(clk),
    .locked(locked),
    .clk_out2(pclk),
    .reset(rst)
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

wire [21:0] address;
wire [11:0] rgb;
wire Car1Enable,Car2Enable;

wire TimeOut;  
  

  vga_timing my_timing (
    .vga_out(vga_bus[-1]),
    .pclk(pclk),
    .rst(!rst)
  );
  
 `VGA_SPLIT_INPUT(vga_bus[3])
  wire Title_Sel,Wait_for_Game,Time_out,GameOn,Highscore,dual,single;
  
  
Car_display #(.Color(3'b110),.X(500),.Y(500)) MyCar(
    .clk(pclk),
    .direction(sw[3:0]),
    .enable(Car1Enable),
    .go(sw[5]),
    .vga_in(vga_bus[-1]),
    .vga_out(vga_bus[0]),
    .rst(!rst)
);
Car_display #(.X(300),.Y(500),.Color(3'b100)) MyCar2(
    
    .clk(pclk),
    .direction(sw[9:6]),
    .enable(Car2Enable),
    .go(sw[11]),
    .vga_in(vga_bus[0]),
    .vga_out(vga_bus[1]),
    .rst(!rst)
);

     
game_bg Game_bg(
    .clk(pclk),
    .Player1Score(8'hf),
    .Player2Score({4'b0,sw[15:12]}),
    .vga_in(vga_bus[1]),
    .vga_out(vga_bus[2]),
    .rst(!rst),
    .TimeOut(TimeOut),
    .NoOfPlayers(NoOfPlayers)
    
);  

Game_over_scr_ctl GOSC(
    .TimeOut(TimeOut),
    .NoOfPlayers(NoOfPlayers),
    .Player1Score(8'hf),
    .Player2Score({4'b0,sw[15:12]}),
    .vga_in(vga_bus[2]),
    .GremlinsEnable(),
    .Car1Enable(Car1Enable),
    .Car2Enable(Car2Enable),
    .vga_out(vga_bus[3])
);

  always @(posedge pclk)
  begin
    vs <= vsync_in;
    hs <= hsync_in;
    
    {r,g,b} <= ((vblnk_in == 0) && (hblnk_in == 0))?rgb_in:12'h000;
  end


assign NoOfPlayers =  sw[4];
endmodule
