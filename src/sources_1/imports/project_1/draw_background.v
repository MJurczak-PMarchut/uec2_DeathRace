`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2018 20:44:18
// Design Name: 
// Module Name: draw_background
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


module draw_background(
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    input wire vsync_in,
    input wire pclk,
    output reg [10:0] hcount_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [11:0] rgb_out,
    output wire pclk_out
    );
  
  localparam x_rect = 10;
  localparam y_rect = 90;
  localparam width = 780;
  localparam height = 500;
  
  always @(posedge pclk)
  begin
      hsync_out <= hsync_in;
      vsync_out <= vsync_in;
      hblnk_out <= hblnk_in;
      vblnk_out <= vblnk_in;
      hcount_out <= hcount_in;
      vcount_out <= vcount_in;
      
      
      
     if ((hblnk_in == 1) || (vblnk_in == 1)) rgb_out <= 12'b0_0_0;
    else
        begin
            if ((((hcount_in >= x_rect) && (hcount_in < (x_rect + width)))&& ((vcount_in >= y_rect) && (vcount_in < (y_rect + height)))) && ((hblnk_in == 0)&&(vblnk_in == 0)))
                    if ((((hcount_in >= x_rect+5) && (hcount_in < (x_rect + width-5)))&& ((vcount_in >= y_rect+5) && (vcount_in < (y_rect + height-5)))) && ((hblnk_in == 0)&&(vblnk_in == 0)))
                        if(((hcount_in >= x_rect + 50) && (hcount_in < x_rect + 52)) || ((hcount_in > (x_rect + width - 52)) && (hcount_in <= (x_rect + width - 50)))) rgb_out <= 12'hf_f_f;
                        else rgb_out <= 12'b0_0_0;                
                     else rgb_out <= 12'hf_f_f;
        //        if(left == 0) rgb_next <= rgb_rom; else rgb_next <= color2;
             else rgb_out <= 12'b0_0_0;
        end
       
  end

assign pclk_out = !pclk;
endmodule




