`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2018 15:07:43
// Design Name: 
// Module Name: psx_controller_module
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


module psx_controller_module(
    input read_burst,
    input select_controller,
    input clk,
    output UP,
    output DOWN,
    output LEFT,
    output RIGHT,
    output [1:0] MODE,
    output START,
    output [7:0] L_JOY_Y,
    output [7:0] L_JOY_X,
    output [7:0] R_JOY_Y,
    output [7:0] R_JOY_X,
    output X,
    output O,
    output SQ,
    output CI,
    output SELECT,
    output L_JOY,
    output R_JOY
    );
endmodule
