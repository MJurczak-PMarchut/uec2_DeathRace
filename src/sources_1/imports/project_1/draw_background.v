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
    output wire [19:0] address
    );
  
  reg  count = 0;
  reg [3:0] rgb_temp;
  reg [18:0] address_next;
  reg [11:0] rgb_merge;
  reg [11:0] rgb_next;
  reg [19:0] hc_tmp, vc_tmp;
  
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_AT_OUTPUT(vga_out)
  
  always @*
    begin
        hc_tmp = hcount_in[10:1];
        vc_tmp = vcount_in[10:1]*12'h190;    
        address_next <= hc_tmp+vc_tmp;
    end
  
  
  always @(posedge pclk)
  begin
      hsync_out <= hsync_in;
      vsync_out <= vsync_in;
      hblnk_out <= hblnk_in;
      vblnk_out <= vblnk_in;
      hcount_out <= hcount_in;
      vcount_out <= vcount_in;
      
      rgb_temp <= rgb;
      rgb_merge <= {rgb_temp,rgb_temp,rgb_temp};
      if (vcount_in  == hcount_in )
        if(vcount_in < 100)rgb_next <= 12'hfff;
        else if(vcount_in < 200)rgb_next <= 12'h00f;
        else if(vcount_in < 300)rgb_next <= 12'h0f0;
        else if(vcount_in < 400)rgb_next <= 12'hf00;
        else if(vcount_in < 500)rgb_next <= 12'hf0f;
        else rgb_next <= 12'h0ff;
      else
        rgb_next <= rgb_merge;
      rgb_out = ((hblnk_in == 0)&&(vblnk_in == 0))? rgb_next :  0;
    end
assign address = address_next;
endmodule



