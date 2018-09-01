`timescale 1ns / 1ps
`include "verilog_macro_bus.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.07.2018 16:19:48
// Design Name: 
// Module Name: Screen_mux
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


module Screen_mux(
    input wire [`VGA_BUS_SIZE-1:0] TitleScreen,
    input wire [`VGA_BUS_SIZE-1:0] GameScreen,
    input wire [`VGA_BUS_SIZE-1:0] Highscore,
    input wire [`VGA_BUS_SIZE-1:0] Blank,
    input wire TitleScreen_sel,
    input wire GameScreen_sel,
    input wire Highscore_sel,
    input wire Wait,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
    
        assign vga_out = (TitleScreen_sel == 1)?TitleScreen:
        (GameScreen_sel == 1)?GameScreen:
        (Highscore_sel == 1)?TitleScreen:TitleScreen;
endmodule
