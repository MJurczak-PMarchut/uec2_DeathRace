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
  inout wire ps2_data,
  inout wire ps2_clk,
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
  wire pclk;
  wire pclk100;
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
wire [23:0] gremlin0, gremlin1;
wire gremlin0_enable, gremlin1_enable;
wire [21:0] car0_address, car1_address;
wire [7:0] Player1Score, Player2Score;

wire TimeOut;  
 
//wire [23:0] grem0, grem1; 

  vga_timing my_timing (
    .vga_out(vga_bus[-2]),
    .pclk(pclk),
    .rst(!rst)
  );
  
 `VGA_SPLIT_INPUT(vga_bus[3])
  wire Title_Sel,Wait_for_Game,Time_out,GameOn,Highscore,dual,single;
  
  collision my_collisions(
    .clk(pclk),
    .rst(!rst),
    .car0_enable(!TimeOut),
    .car1_enable(!TimeOut),
    .vga_in(vga_bus[1]),
    .vga_out(vga_bus[2]),
    .grem0(gremlin0),
    .grem1(gremlin1),
    .car0(car0_address),
    .car1(car1_address),
    .grem0_out(gremlin0_enable),
    .grem1_out(gremlin1_enable),
    .points0_out(Player1Score),
    .points1_out(Player2Score)
  );

  gremlins_position my_gremlins(
    .vga_in(vga_bus[-2]),
    .vga_out(vga_bus[-1]),
    .pclk(pclk),
    .grem0_enable(gremlin0_enable),
    .grem1_enable(gremlin1_enable),
    .grem0_out(gremlin0),
    .grem1_out(gremlin1)
  );
  
  
Car_display #(.Color(3'b110),.X(500),.Y(500)) MyCar(
    .clk(pclk),
    .direction(sw[3:0]),
    .enable(!TimeOut),
    .go(sw[5]),
    .vga_in(vga_bus[-1]),
    .vga_out(vga_bus[0]),
    .rst(!rst),
    .xpos(car0_address[21:11]),
    .ypos(car0_address[10:0])
);
Car_display #(.X(300),.Y(500),.Color(3'b100)) MyCar2(
    
    .clk(pclk),
    .direction(sw[9:6]),
    .enable(!TimeOut),
    .go(sw[11]),
    .vga_in(vga_bus[0]),
    .vga_out(vga_bus[1]),
    .rst(!rst),
    .xpos(car1_address[21:11]),
    .ypos(car1_address[10:0])
);

     
game_bg Game_bg(
    .clk(pclk),
    .Player1Score(Player1Score),
    .Player2Score(Player2Score),
    .vga_in(vga_bus[2]),
    .vga_out(vga_bus[3]),
    .rst(!rst),
    .TimeOut(TimeOut)
);  

  
  always @(posedge pclk)
  begin
    vs <= vsync_in;
    hs <= hsync_in;
    
    {r,g,b} <= ((vblnk_in == 0) && (hblnk_in == 0))?rgb_in:12'h000;
  end

endmodule
