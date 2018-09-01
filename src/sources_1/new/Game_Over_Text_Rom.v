`timescale 1ns / 1ps


module Game_Over_Text_Rom(
    input wire [7:0] char_xy,
    output reg [6:0] char_code 
    );

    always@*
            case(char_xy) 
                8'h00: char_code = 7'h47; // G
                8'h01: char_code = 7'h61; // a
                8'h02: char_code = 7'h6d; // m
                8'h03: char_code = 7'h65; // e
                8'h04: char_code = 7'h20; // 
                8'h05: char_code = 7'h4f; // O   
                8'h06: char_code = 7'h76; // v
                8'h07: char_code = 7'h65; // e
                8'h08: char_code = 7'h72; // r
                8'h10: char_code = 7'h57; // W
                8'h11: char_code = 7'h69; // i
                8'h12: char_code = 7'h6e; // n
                8'h13: char_code = 7'h6e; // n
                8'h14: char_code = 7'h65; // e
                8'h15: char_code = 7'h72; // r
                8'h16: char_code = 7'h7c; // :
                default:char_code = 7'h7f;
            endcase
    

endmodule

