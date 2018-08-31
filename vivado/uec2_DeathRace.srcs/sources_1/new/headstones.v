`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2018 15:02:48
// Design Name: 
// Module Name: headstones
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

module headstones(
    input wire clk, reset,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    input wire f_in,
    input wire [21:0] address,
    input wire [15:0] char_pixels,
    output wire color,
    output wire [2:0] char_xy,
    output wire [4:0] char_line,
    output wire f_out
    );

    `VGA_SPLIT_INPUT(vga_in)

reg f_nxt, color0 = 0, color1 = 0, color2 = 0, color3 = 0, color4 = 0, color5 = 0, color6 = 0, color7 = 0;
reg [2:0] i = 0;
reg [21:0] addr0 = 0, addr1 = 0, addr2 = 0, addr3 = 0, addr4 = 0, addr5 = 0, addr6 = 0, addr7 = 0;
reg [10:0] hcount_char, vcount_char;

always @(posedge clk or negedge reset)
if(!reset)
        fork
          addr0 = 0;
          addr1 = 0;
          addr2 = 0;
          addr3 = 0;
          addr4 = 0;
          addr5 = 0;
          addr6 = 0;
          addr7 = 0;
        join
else
fork
    if(f_in == 1'b1) begin
        f_nxt = 1'b0;
        case(i)
            3'b000: addr0 = address;
            3'b001: addr1 = address;
            3'b010: addr2 = address;
            3'b011: addr3 = address;
            3'b100: addr4 = address;
            3'b101: addr5 = address;
            3'b110: addr6 = address;
            3'b111: addr7 = address;
            endcase
        i = i + 1'b1;
        end
    else f_nxt = f_in;
    
    if(addr0 != 0)begin
        vcount_char = vcount_in - addr0[10:0];
        hcount_char = hcount_in - addr0[21:11]; 
        if((hblnk_in == 0) && (vblnk_in == 0))
            if (char_pixels[15 - hcount_char[3:0]] == 1)
                if ((hcount_char[10:4] == 0) && (vcount_char[10:5] == 0)) color0 = 1;
                else  color0 = 0;
            else color0 = 0;
        else color0 = 0;
        end
        
    if(addr1 != 0)begin
        vcount_char = vcount_in - addr1[10:0];
        hcount_char = hcount_in - addr1[21:11]; 
        if((hblnk_in == 0) && (vblnk_in == 0))
            if (char_pixels[15 - hcount_char[3:0]] == 1)
                if ((hcount_char[10:4] == 0) && (vcount_char[10:5] == 0)) color1 = 1;
                else  color1 = 0;
            else color1 = 0;
        else color1 = 0;
        end
    if(addr2 != 0)begin
        vcount_char = vcount_in - addr2[10:0];
        hcount_char = hcount_in - addr2[21:11]; 
        if((hblnk_in == 0) && (vblnk_in == 0))
            if (char_pixels[15 - hcount_char[3:0]] == 1)
                if ((hcount_char[10:4] == 0) && (vcount_char[10:5] == 0)) color2 = 1;
                else  color2 = 0;
            else color2 = 0;
        else color2 = 0;
        end
    if(addr3 != 0)begin
        vcount_char = vcount_in - addr3[10:0];
        hcount_char = hcount_in - addr3[21:11]; 
        if((hblnk_in == 0) && (vblnk_in == 0))
            if (char_pixels[15 - hcount_char[3:0]] == 1)
                if ((hcount_char[10:4] == 0) && (vcount_char[10:5] == 0)) color3 = 1;
                else  color3 = 0;
            else color3 = 0;
        else color3 = 0;
        end
    if(addr4 != 0)begin
        vcount_char = vcount_in - addr4[10:0];
        hcount_char = hcount_in - addr4[21:11]; 
        if((hblnk_in == 0) && (vblnk_in == 0))
            if (char_pixels[15 - hcount_char[3:0]] == 1)
                if ((hcount_char[10:4] == 0) && (vcount_char[10:5] == 0)) color4 = 1;
                else  color4 = 0;
            else color4 = 0;
        else color4 = 0;
        end
    if(addr5 != 0)begin
        vcount_char = vcount_in - addr5[10:0];
        hcount_char = hcount_in - addr5[21:11]; 
        if((hblnk_in == 0) && (vblnk_in == 0))
            if (char_pixels[15 - hcount_char[3:0]] == 1)
                if ((hcount_char[10:4] == 0) && (vcount_char[10:5] == 0)) color5 = 1;
                else  color5 = 0;
            else color5 = 0;
        else color5 = 0;
        end
    if(addr6 != 0)begin
        vcount_char = vcount_in - addr6[10:0];
        hcount_char = hcount_in - addr6[21:11]; 
        if((hblnk_in == 0) && (vblnk_in == 0))
            if (char_pixels[15 - hcount_char[3:0]] == 1)
                if ((hcount_char[10:4] == 0) && (vcount_char[10:5] == 0)) color6 = 1;
                else  color6 = 0;
            else color6 = 0;
        else color6 = 0;
        end
    if(addr7 != 0)begin
        vcount_char = vcount_in - addr7[10:0];
        hcount_char = hcount_in - addr7[21:11]; 
        if((hblnk_in == 0) && (vblnk_in == 0))
            if (char_pixels[15 - hcount_char[3:0]] == 1)
                if ((hcount_char[10:4] == 0) && (vcount_char[10:5] == 0)) color7 = 1;
                else  color7 = 0;
            else color7 = 0;
        else color7 = 0;
        end
join

assign char_xy = 3'b010;
assign color = color0 | color1 | color2 | color3 | color4 | color5 | color6 | color7;
assign char_line = vcount_char[4:0];
assign f_out = f_nxt;

endmodule


