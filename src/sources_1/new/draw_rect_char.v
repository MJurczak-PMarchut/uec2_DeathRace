`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2018 10:25:52
// Design Name: 
// Module Name: draw_rect_char
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

module draw_rect_char(
    input wire pclk,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    input wire [7:0] char_pixels,
    input wire playerCount,
    output wire [7:0] char_xy,
    output wire [3:0] char_line,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
);

    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_AT_OUTPUT(vga_out)
   
reg [11:0] rgb_nxt;
reg [10:0] hcount_char, vcount_char;
reg choose = 1;

localparam HCOUNT = 100;
localparam VCOUNT = 250;
localparam color = 12'hfff;
localparam color_c = 12'h0ff;
    
 always @*
 begin
    hcount_char = hcount_in - HCOUNT;
    vcount_char = vcount_in - VCOUNT;
    
    if((hblnk_in == 0) && (vblnk_in == 0))
        if (char_pixels[7 - hcount_char[2:0]] == 1)
            if ((hcount_char[10:7] == 0) && (vcount_char[10:8] == 0)) rgb_nxt =(vcount_char[7:4] == 0)?((playerCount == 0)?12'hff0:12'hf_f_f):
            (vcount_char[7:4] == 6)?((playerCount == 1)? 12'hff0:12'hfff):rgb_in;
            else  rgb_nxt = rgb_in;
        else rgb_nxt = rgb_in;
    else rgb_nxt = rgb_in;
 
 
 end   
  
 always @(posedge pclk)
 begin
    hcount_out <= hcount_in;
     hsync_out <= hsync_in;
     hblnk_out <= hblnk_in;
     vcount_out <= vcount_in;
     vsync_out <= vsync_in;
     vblnk_out <= vblnk_in;
     rgb_out <= rgb_nxt;
 end    
    
   
   assign char_xy = {vcount_char[7:4],hcount_char[6:3]};
   assign char_line = vcount_char[3:0];
    
endmodule
