`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2018 22:53:59
// Design Name: 
// Module Name: MouseCtlVeri
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

module MouseCtlVeri(
    inout ps2_clk,
    inout ps2_data,
    output [`MOUSE_BUS_SIZE-1:0] mouse_out,
    input rst,
    input clk
    );
    
    `MOUSE_OUT_WIRE
    `MOUSE_MERGE_AT_OUTPUT(mouse_out)
    
    
      MouseCtl myMouse(
      .clk(clk),
      .ps2_clk(ps2_clk),
      .ps2_data(ps2_data),
      .xpos(xpos_out),
      .ypos(ypos_out),
      .left(left_out)
    );
    
endmodule
