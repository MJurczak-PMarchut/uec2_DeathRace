`timescale 1ns / 1ps

module steerage(
    input wire [11:0] direction_in,
    output wire [3:0]direction_out
    );
    
reg [3:0] direction_nxt;

always @*
    direction_nxt = 
    (direction_in < 12'h072)? 4'b1000:
    (direction_in < 12'h155)? 4'b1001:
    (direction_in < 12'h238)? 4'b1010:
    (direction_in < 12'h31B)? 4'b1011:
    (direction_in < 12'h3FE)? 4'b1100:
    (direction_in < 12'h4E1)? 4'b1101:
    (direction_in < 12'h5C4)? 4'b1110:
    (direction_in < 12'h6A7)? 4'b1111:
    (direction_in < 12'h78A)? 4'b0000:
    (direction_in < 12'h86D)? 4'b0001:
    (direction_in < 12'h950)? 4'b0010:
    (direction_in < 12'hA33)? 4'b0011:
    (direction_in < 12'hB16)? 4'b0100:
    (direction_in < 12'hBF9)? 4'b0101:
    (direction_in < 12'hCDC)? 4'b0110:
    (direction_in < 12'hDBF)? 4'b0111: 4'b1000;

assign direction_out = direction_nxt;
    
endmodule
