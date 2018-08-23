`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.08.2018 12:55:57
// Design Name: 
// Module Name: Car_display
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

module Car_display(

    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    input wire clk,
    input wire [3:0] direction,
    output reg [10:0] xpos,ypos,
    input wire enable,
    input wire go,
    input wire rst
    );
    
    parameter X = 300;
    parameter Y = 500;
    parameter Color = 3'b111;
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_WIRE
    `VGA_MERGE_AT_OUTPUT(vga_out)
    
    wire [4:0] Car_xpixel,Car_ypixel;
    wire [11:0] rgb;
    
     cardata mycar(
         .direction(direction),
         .xpos(Car_xpixel),
         .ypos(Car_ypixel),  
         .rgb(rgb)
     );
    
    reg en,st;
    initial 
        fork
            xpos = X;
            ypos = Y;
        join
    
    reg frame_count = 0;
    
        always @(posedge clk)
        begin
            if ((vsync_in == 1) && (en == 1) )
                begin             
                    en <= 0;
                    st <= 1; 
                end
            else if ((vsync_in == 1) && (en == 0) && (st == 0))
                en <= 1;
            else if (vsync_in == 0)
                begin
                    en <= 0;
                    st <= 0;
                end        
        end 
    
    
    always @(posedge clk or negedge rst)
        if(!rst)
            fork
                xpos = X;
                ypos = Y;
                frame_count = 0;
             join
        else
            if(en && go)
                begin
                    xpos = 
                        (direction == 0)? xpos :
                        (direction == 1)? ((frame_count == 1)?xpos + 2 : xpos):
                        (direction == 2)? ((frame_count == 1)?xpos + 3 : xpos):
                        (direction == 3)? xpos + 2:
                        (direction == 4)? xpos + 3:
                        (direction == 5)? xpos + 2:
                        (direction == 6)? ((frame_count == 1)?xpos + 3 : xpos):
                        (direction == 7)? ((frame_count == 1)?xpos + 2 : xpos):
                        (direction == 8)? xpos:
                        (direction == 9)? ((frame_count == 1)?xpos - 2 : xpos):
                        (direction == 10)?((frame_count == 1)?xpos - 3 : xpos): 
                        (direction == 11)? xpos - 2:
                        (direction == 12)? xpos - 3:
                        (direction == 13)? xpos - 2:
                        (direction == 14)? ((frame_count == 1)?xpos - 3 : xpos):
                        (direction == 15)? ((frame_count == 1)?xpos - 2 : xpos):
                        xpos;
                    
                    
                    ypos = 
                        (direction == 0)? ypos - 3:
                        (direction == 1)? ypos - 2:
                        (direction == 2)? ((frame_count == 1)?ypos - 3 : ypos):
                        (direction == 3)? ((frame_count == 1)?ypos - 2 : ypos):
                        (direction == 4)? ypos:
                        (direction == 5)? ((frame_count == 1)?ypos + 2 : ypos):
                        (direction == 6)? ((frame_count == 1)?ypos + 3 : ypos):
                        (direction == 7)? ypos + 2:
                        (direction == 8)? ypos + 3:
                        (direction == 9)? ypos + 2:
                        (direction == 10)? ((frame_count == 1)?ypos + 3 : ypos): 
                        (direction == 11)? ((frame_count == 1)?ypos + 2 : ypos):
                        (direction == 12)? ypos:
                        (direction == 13)? ((frame_count == 1)?ypos - 2 : ypos):
                        (direction == 14)? ((frame_count == 1)?ypos - 3 : ypos):
                        (direction == 15)? ypos - 2:
                        ypos;
                        
                        xpos = (xpos >= 704)? 704 :
                        (xpos <= 65)? 65: xpos;
                        ypos = (ypos >= 569)? 569 :
                        (ypos <= 105)? 105: ypos;              
                        frame_count =  frame_count + 1;
                end
        
    
    assign hcount_out = hcount_in;
    assign vcount_out = vcount_in;
    assign hblnk_out = hblnk_in;
    assign vblnk_out = vblnk_in;
    assign vsync_out = vsync_in;
    assign hsync_out = hsync_in;
    
    assign Car_xpixel = ((hcount_in >= xpos) && (hcount_in - xpos <= 31))?(hcount_in - xpos):0;
    assign Car_ypixel = ((vcount_in >= ypos) && (vcount_in - ypos <= 31))?(vcount_in - ypos):0;
    assign rgb_out = 
    ((hblnk_in == 0) && (vblnk_in == 0))? 
    ((
    (hcount_in >= xpos) && (hcount_in - xpos <= 31) && 
    (vcount_in >= ypos) && (vcount_in - ypos <= 31)
    )?
    ((enable == 1)?((rgb[3:0] > 4'h8)? 
    {(rgb[11:8]&(Color[2]*4'hf)),(rgb[7:4]&(Color[1]*4'hf)),(rgb[3:0]&(Color[0]*4'hf))}:rgb_in)
    :rgb_in) : rgb_in) : 0;
    
    
    
endmodule
