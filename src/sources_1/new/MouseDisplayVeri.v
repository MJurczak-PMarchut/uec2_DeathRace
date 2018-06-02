`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2018 22:02:29
// Design Name: 
// Module Name: MouseDisplayVeri
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

module MouseDisplayVeri(
    input [`MOUSE_BUS_SIZE-1:0] mouse_in,
    input wire pclk,
    input [`VGA_BUS_SIZE-1:0] vga_in,
    output [`VGA_BUS_SIZE-1:0] vga_out
    );
    
    `MOUSE_SPLIT_INPUT(mouse_in)
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_WIRE
    `VGA_MERGE_AT_OUTPUT(vga_out)
    
     MouseDisplay myCoursor(
       .xpos(xpos_in),
       .ypos(ypos_in),
       .hblank(hblnk_in),
       .vblank(vblnk_in),
       .red_in(rgb_in[3:0]),
       .green_in(rgb_in[7:4]),
       .blue_in(rgb_in[11:8]),
       .red_out(rgb_out[3:0]),
       .green_out(rgb_out[7:4]),
       .blue_out(rgb_out[11:8]),
       .pixel_clk(pclk),
       .hcount(hcount_in),
       .vcount(vcount_in),
       .vsync_out(vsync_out),
       .hsync_out(hsync_out),
       .hsync_in(hsync_in),
       .vsync_in(vsync_in)
     );
    
    
    
endmodule
