`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2018 13:18:42
// Design Name: 
// Module Name: cardata
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


module cardata(

    input wire [3:0] direction,
    input wire [4:0] xpos,
    input wire [4:0] ypos,  // address = {addry[5:0], addrx[5:0]}
    output wire [11:0] rgb
);

localparam UP = 2'b00;
localparam leftsdeg = 2'b01;
localparam leftdeg = 2'b10;
localparam lefthdeg = 2'b11;
localparam subs = 5'b11111;


reg [3:0] rom [0:4095];
reg [3:0] rgb_out;

initial $readmemh("./datacar.data", rom); 
      
                
    assign rgb = 12'h111*((direction == 0)?rom[{UP,{ypos,xpos}}]:
    (direction == 1)? rom[{leftsdeg,{ypos,xpos}}]:
    (direction == 2)? rom[{leftdeg,{ypos,xpos}}]:
    (direction == 3)? rom[{lefthdeg,{ypos,xpos}}]:
    (direction == 4)? rom[{UP,{subs-xpos,ypos}}]:
    (direction == 5)? rom[{lefthdeg,{subs-ypos,xpos}}]:
    (direction == 6)? rom[{leftdeg,{subs-ypos,xpos}}]:
    (direction == 7)? rom[{leftsdeg,{subs-ypos,xpos}}]:
    (direction == 8)? rom[{UP,{subs-ypos,xpos}}]:
    (direction == 9)? rom[{leftsdeg,{subs-ypos,subs-xpos}}]:
    (direction == 10)? rom[{leftdeg,{subs-ypos,subs-xpos}}]:
    (direction == 11)? rom[{lefthdeg,{subs-ypos,subs-xpos}}]:
    (direction == 12)? rom[{UP,{xpos,subs-ypos}}]:
    (direction == 13)? rom[{lefthdeg,{ypos,subs-xpos}}]:
    (direction == 14)? rom[{leftdeg,{ypos,subs-xpos}}]:
    (direction == 15)? rom[{leftsdeg,{ypos,subs-xpos}}]:0);

endmodule


