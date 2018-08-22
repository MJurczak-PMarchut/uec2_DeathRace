`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2018 14:10:55
// Design Name: 
// Module Name: Controller_status_decode
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


module Controller_status_decode(

    input wire pclk,
    input wire [7:0] contByte,
    input wire Read,
    input wire clr,
    output reg ready = 0,
    output reg [3:0]address,
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
    
    reg [7:0] Data [8:0];
    reg [3:0] i = 0;
    
    
        always @(posedge pclk)
            if(Read && (i<=8))    
                begin
                    address = i;
                end
            else if(i == 9)
                begin
                    ready = 1;
                end
            
            always @*
                if(clr && ready)
                    ready = 0;
         
         always @(negedge pclk)
            if(Read && (i<=8))
                begin
                    Data[i] = contByte;
                    i = i+1;
                end 
            
endmodule
