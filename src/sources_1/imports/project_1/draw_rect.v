`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2018 22:12:21
// Design Name: 
// Module Name: draw_rect
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


module draw_rect(
    input wire [11:0] xpos,
    input wire [11:0] ypos,
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    input wire vsync_in,
    input wire pclk,
    input wire left,
    input wire [11:0] rgb_in,
    output reg [10:0] hcount_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [11:0] rgb_out,
    output wire [11:0] address,
    input wire [11:0] rgb_rom
    );
    //localparam x_pos = 80;
    //localparam y_pos = 100;
    localparam width = 48;
    localparam height = 64;
    localparam color = 12'hf_0_0;
    localparam color2 = 12'h0_0_f;
    
    //wire [11:0] addres,rgb_rom;
    
    
    reg [11:0] x_pos, y_pos;
    reg [11:0] rgb_next;
    
    
    always @*
    begin
        if ((((hcount_in >= x_pos) && (hcount_in < (x_pos + width)))&& ((vcount_in >= y_pos) && (vcount_in < (y_pos + height)))) && ((hblnk_in == 0)&&(vblnk_in == 0)))
        if(left == 0) rgb_next <= rgb_rom; else rgb_next <= color2;
        else rgb_next <= rgb_in;
    end
    
    always @(posedge pclk)
    fork 
        hsync_out <= hsync_in;
        vsync_out <= vsync_in;
        hblnk_out <= hblnk_in;
        vblnk_out <= vblnk_in;
        hcount_out <= hcount_in;
        vcount_out <= vcount_in;
        rgb_out <= rgb_next;
    
    join
   
    always @(posedge pclk)
    if(vsync_in) 
        fork
         x_pos <= xpos;
         y_pos <= ypos;
        join

    assign  address[5:0] = hcount_in - x_pos;
    assign  address[11:6] = vcount_in - y_pos;    
    
endmodule
