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


module Title_Screen(
    input wire pclk,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    input wire single_player,
    input wire dual_player

    );
    
      wire [21:0] address;
      wire [3:0] rgb_back;
    
      draw_background my_background(
      .vga_in(vga_in),
      .pclk(pclk),
      .vga_out(vga_out),
      .address(address),
      .rgb(rgb_back)
      );
    

    
    start_screen my_screen(
      .address(address),
      .clk(pclk),
      .rgb(rgb_back)
    );
    
endmodule
