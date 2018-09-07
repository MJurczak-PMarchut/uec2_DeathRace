`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.07.2018 21:07:56
// Design Name: 
// Module Name: Title_Screen
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

module Title_Screen(
    input wire pclk,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    input wire playerCount

    );
    
    wire [`VGA_BUS_SIZE - 1 : 0] vga_bus [1:0];
      wire [18:0] address;
      wire [3:0] rgb_back;
      
      wire [6:0] char_code;
      wire [7:0] char_line_pixels;  
      wire [7:0] char_xy;
      wire [3:0] char_line;
    
  draw_background my_background(
        .vga_in(vga_in[37:0]),
        .vga_out(vga_bus[0]),
        .address(address),
        .rgb(rgb_back)
        );
    
          draw_rect_char rect_char(
            .pclk(pclk),
            .vga_in(vga_bus[0]),
            .char_pixels(char_line_pixels),
            .char_xy(char_xy),
            .char_line(char_line),
            .vga_out(vga_out),
            .playerCount(playerCount)
        );
        
        font_rom  font_rom(
            .addr({char_code,char_line}),
            .data(char_line_pixels)
        );
        
        char_rom_16x16 char_rom(
            .char_xy(char_xy),
            .code(char_code)
        );
      
      start_screen screen(
        .address(address),
        .rgb(rgb_back)
      );

    
endmodule
