`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2018 15:18:39
// Design Name: 
// Module Name: gremlin
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

module gremlin(
    input wire clk, grem, reset,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    input wire [15:0] char_pixels,
    output wire [2:0] char_xy,
    output wire [4:0] char_line,
    output wire [10:0] xpos,
    output wire [10:0] ypos,
    output wire color, grem_out
    );
 
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
parameter I = 0;
parameter J = 0;    
parameter XPOS_INIT = 400;
parameter YPOS_INIT = 300;

reg [2:0] direction = J;
reg [10:0] xpos_nxt = XPOS_INIT;
reg [10:0] ypos_nxt = YPOS_INIT;
reg [9:0] i = 0; 
reg [2:0] j = J, char_xy_nxt;
reg [10:0] hcount_char, vcount_char, n, m;
reg color_nxt;
reg edge_f;

localparam LEFT_EDGE = 5;
localparam RIGHT_EDGE = 795 - 16;
localparam UP_EDGE = 105;
localparam DOWN_EDGE = 595 - 32;


//always @(posedge clk)
//begin
//    if(n < RIGHT_EDGE) n = n + 1;
//    else n = LEFT_EDGE;
//    if(m < DOWN_EDGE) m = m + 3;
//    else m = UP_EDGE;
//end

//always @(posedge reset)
//begin
//    xpos_nxt <= XPOS_INIT;
//    ypos_nxt <= YPOS_INIT;
//    direction <= j;
//end

//always @(posedge grem)
//begin
//    xpos_nxt <= n;
//    ypos_nxt <= m;
//    direction <= j;
//end

always @(posedge vsync_in)
begin
i = i + 1;
j = j + 1;
//if(grem == 0)
//    begin
//    xpos_nxt <= n;
//    ypos_nxt <= m;
//    direction <= j;
//    end
case (direction)
    3'b000: ypos_nxt <= ypos_nxt - 1;
    3'b001: begin
        xpos_nxt <= xpos_nxt + 1;
        ypos_nxt <= ypos_nxt - 1;
        end
    3'b010: xpos_nxt <= xpos_nxt + 1;
    3'b011: begin
        xpos_nxt <= xpos_nxt + 1;
        ypos_nxt <= ypos_nxt + 1;
        end
    3'b100: ypos_nxt <= ypos_nxt + 1;
    3'b101: begin
        xpos_nxt <= xpos_nxt - 1;
        ypos_nxt <= ypos_nxt + 1;
        end
    3'b110: xpos_nxt <= xpos_nxt - 1;
    3'b111: begin
        xpos_nxt <= xpos_nxt - 1;
        ypos_nxt <= ypos_nxt - 1;
        end
    endcase

if(j==0)char_xy_nxt[0] <= ~char_xy_nxt[0];

if((xpos_nxt <= LEFT_EDGE) && (ypos_nxt <= UP_EDGE))begin
    direction <= 3'b011;
    i = 0;
    end
else if((xpos_nxt >= RIGHT_EDGE) && (ypos_nxt <= UP_EDGE)) begin
    direction <= 3'b101;
    i = 0;
    end
else if((xpos_nxt <= LEFT_EDGE) && (ypos_nxt >= DOWN_EDGE)) begin
    direction <= 3'b001;
    i = 0;
    end
else if((xpos_nxt >= RIGHT_EDGE) && (ypos_nxt >= DOWN_EDGE)) begin
    direction <= 3'b111;
    i = 0;
    end
    
if(xpos_nxt < LEFT_EDGE-1)direction <= 3'b010;
else if(xpos_nxt > RIGHT_EDGE+1)direction <= 3'b110;
else if(ypos_nxt < UP_EDGE-1)direction <= 3'b100;
else if(ypos_nxt > DOWN_EDGE+1)direction <= 3'b000; 
    
if(((xpos_nxt <= LEFT_EDGE) || (xpos_nxt >= RIGHT_EDGE) || (ypos_nxt <= UP_EDGE) || (ypos_nxt >= DOWN_EDGE)) && (edge_f == 1'b0))
    begin
    direction <= direction + ((j%3) + 3);
    edge_f <= 1'b1;
    i = 0;
    end

if(i == I) begin
    i = 0;
    direction <= j;
    end

if((xpos_nxt > LEFT_EDGE) && (xpos_nxt < RIGHT_EDGE) && (ypos_nxt > UP_EDGE) && (ypos_nxt < DOWN_EDGE)) edge_f <= 1'b0;    

end

always @*
 begin
    vcount_char <= vcount_in - ypos_nxt;
    hcount_char <= (direction <= 3'b011)? (4'b1111 - (hcount_in - xpos_nxt)):(hcount_in - xpos_nxt); 
    
    if((hblnk_in == 0) && (vblnk_in == 0))
        if (char_pixels[15 - hcount_char[3:0]] == 1)
            if ((hcount_char[10:4] == 0) && (vcount_char[10:5] == 0)) color_nxt <= 1;
            else  color_nxt <= 0;
        else color_nxt <= 0;
    else color_nxt <= 0;
 end
    
assign xpos = xpos_nxt;
assign ypos = ypos_nxt;
assign color = color_nxt;
assign char_xy = char_xy_nxt;
assign char_line = vcount_char[4:0];
    
endmodule
