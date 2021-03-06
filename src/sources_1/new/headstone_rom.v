`timescale 1ns / 1ps

module headstone_rom
    (
        input wire [4:0] addr,            // {char_code[6:0], char_line[3:0]}
        output wire  [15:0]  char_line_pixels // pixels of the character line
    );

reg [15:0] data;

assign char_line_pixels = data;

    always @*
        case (addr)
            5'b00000: data = 16'b0000001111000000; //      ****
            5'b00001: data = 16'b0000001111000000; //      ****
            5'b00010: data = 16'b0000001111000000; //      ****
            5'b00011: data = 16'b0000001111000000; //      ****
            5'b00100: data = 16'b0000001111000000; //      ****
            5'b00101: data = 16'b0000001111000000; //      ****
            5'b00110: data = 16'b1111111111111111; //****************
            5'b00111: data = 16'b1111111111111111; //****************
            5'b01000: data = 16'b1111111111111111; //****************
            5'b01001: data = 16'b1111111111111111; //****************
            5'b01010: data = 16'b0000001111000000; //      ****
            5'b01011: data = 16'b0000001111000000; //      ****
            5'b01100: data = 16'b0000001111000000; //      ****
            5'b01101: data = 16'b0000001111000000; //      ****
            5'b01110: data = 16'b0000001111000000; //      ****
            5'b01111: data = 16'b0000001111000000; //      ****
            5'b10000: data = 16'b0000001111000000; //      ****
            5'b10001: data = 16'b0000001111000000; //      ****
            5'b10010: data = 16'b0000001111000000; //      ****
            5'b10011: data = 16'b0000001111000000; //      ****
            5'b10100: data = 16'b0000001111000000; //      ****
            5'b10101: data = 16'b0000001111000000; //      ****
            5'b10110: data = 16'b0000001111000000; //      ****
            5'b10111: data = 16'b0000001111000000; //      ****
            5'b11000: data = 16'b0000001111000000; //      ****
            5'b11001: data = 16'b0000001111000000; //      ****
            5'b11010: data = 16'b0000001111000000; //      ****
            5'b11011: data = 16'b0000001111000000; //      ****
            5'b11100: data = 16'b0000001111000000; //      ****
            5'b11101: data = 16'b0000001111000000; //      ****
            5'b11110: data = 16'b1111111111111111; //****************
            5'b11111: data = 16'b1111111111111111; //****************
            
        endcase

endmodule
