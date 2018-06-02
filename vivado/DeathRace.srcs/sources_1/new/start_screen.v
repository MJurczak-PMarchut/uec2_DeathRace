`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2018 22:29:03
// Design Name: 
// Module Name: start_screen
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


module start_screen(
    input wire clk ,
    input wire [19:0] address,  // address = {addry[5:0], addrx[5:0]}
    output reg [3:0] rgb
);


reg [15:0] rom [0:120000];

initial $readmemh("image_rom.data", rom); 

always @*
    rgb <= rom[address];
//    rgb <= 0;


endmodule
