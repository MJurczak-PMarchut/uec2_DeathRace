`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2018 21:51:45
// Design Name: 
// Module Name: char_rom_16x16
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


module char_rom_16x16(
    input wire clk,
    input wire [7:0] char_xy,
    output reg [6:0] code
    );
    
    

    always @*
        case (char_xy)
            //code x00
            8'h00: code = 7'h53;//S
            8'h01: code = 7'h69;//i
            8'h02: code = 7'h6E;//n
            8'h03: code = 7'h67;//g
            8'h04: code = 7'h6C;//l
            8'h05: code = 7'h65;//e
            8'h06: code = 7'h20;//
            8'h07: code = 7'h50;//P
            8'h08: code = 7'h6C;//l
            8'h09: code = 7'h61;//a
            8'h0A: code = 7'h79;//y
            8'h0B: code = 7'h65;//e
            8'h0B: code = 7'h72;//r
            8'h0C: code = 7'h20;//
            8'h0D: code = 7'h4D;//M
            8'h0E: code = 7'h75;//u
            8'h0F: code = 7'h6C;//l
            8'h10: code = 7'h74;//t
            8'h11: code = 7'h69;//i
            8'h12: code = 7'h20;//
            8'h13: code = 7'h50;//P
            8'h14: code = 7'h6C;//l
            8'h15: code = 7'h61;//a
            8'h16: code = 7'h79;//y
            8'h17: code = 7'h65;//e
            8'h18: code = 7'h72;//r            
//            default code = char_xy[6:0];

         endcase
    
endmodule
