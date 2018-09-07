`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2018 20:44:18
// Design Name: 
// Module Name: draw_background
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "verilog_macro_bus.vh"

module draw_background(
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    input [3:0] rgb,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    output wire [18:0] address
    );
  

    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_WIRE
    `VGA_MERGE_AT_OUTPUT(vga_out)
  

  

      assign hsync_out = hsync_in;
      assign vsync_out = vsync_in;
      assign hblnk_out = hblnk_in;
      assign vblnk_out = vblnk_in;
      assign hcount_out = hcount_in;
      assign vcount_out = vcount_in;
      
      assign rgb_out = ((hblnk_in == 0)&&(vblnk_in == 0))? ((rgb_in == 12'hfff)?12'hfff:({rgb,rgb,rgb})) :  0;

assign address = hcount_in[10:1] + vcount_in[10:1]*400;
endmodule



