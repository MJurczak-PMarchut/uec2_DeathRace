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
  inout wire ps2_data,
  inout wire ps2_clk,
  input wire clk,
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror
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

wire [21:0] address;
wire [3:0] rgb_back; 
  
  

  vga_timing my_timing (
    .vga_out(vga_bus[-1]),
    .pclk(pclk)
  );
  
  draw_background my_background(
    .vga_in(vga_bus[-1]),
    .pclk(pclk),
    .vga_out(vga_bus[0]),
    .address(address),
    .rgb(rgb_back)
    );
  
  start_screen my_screen(
    .address(address),
    .clk(pclk),
    .rgb(rgb_back)
  );

       
 `VGA_SPLIT_INPUT(vga_bus[0])
  
  always @(posedge pclk)
  begin
    vs <= vsync_in;
    hs <= hsync_in;
    
    {r,g,b} <= rgb_in;
  end

endmodule
