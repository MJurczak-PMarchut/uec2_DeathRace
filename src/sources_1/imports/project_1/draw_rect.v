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
    input wire [`MOUSE_BUS_SIZE-1:0] mouse_in,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    input wire pclk,
    //input wire left,
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
    `MOUSE_SPLIT_INPUT(mouse_in)
    
    
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_AT_OUTPUT(vga_out)
    
    reg [11:0] x_pos, y_pos;
    reg [11:0] rgb_next;
    
    
    always @*
    begin
        if ((((hcount_in >= x_pos) && (hcount_in < (x_pos + width)))&& ((vcount_in >= y_pos) && (vcount_in < (y_pos + height)))) && ((hblnk_in == 0)&&(vblnk_in == 0)))
        if(left_in == 0) rgb_next <= rgb_rom; else rgb_next <= color2;
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
         x_pos <= xpos_in;
         y_pos <= ypos_in;
        join

    assign  address[5:0] = hcount_in - x_pos;
    assign  address[11:6] = vcount_in - y_pos;    
    
endmodule
