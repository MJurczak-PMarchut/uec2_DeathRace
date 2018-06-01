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
    input wire pclk,
    input [3:0] rgb,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    output wire [21:0] address
    );
  
  reg  count = 0;
  reg [3:0] rgb_temp;
  reg [21:0] address_next;
  reg [11:0] rgb_merge;
  
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_AT_OUTPUT(vga_out)
  
  
  always @(posedge pclk)
  begin
      hsync_out <= hsync_in;
      vsync_out <= vsync_in;
      hblnk_out <= hblnk_in;
      vblnk_out <= vblnk_in;
      hcount_out <= hcount_in;
      vcount_out <= vcount_in;
      
      rgb_temp = rgb;
      rgb_merge = {rgb_temp,rgb_temp,rgb_temp};
      if((hblnk_in == 0)&&(vblnk_in == 0))
        rgb_out = rgb_merge;
      else 
        rgb_out = 0 ;
      
    end
assign address = hcount_in[10:1]+vcount_in[10:1]*400;
endmodule



