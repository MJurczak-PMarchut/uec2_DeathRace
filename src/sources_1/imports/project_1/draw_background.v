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

`include "verilog_macro_bus.vh"

module draw_background(
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    input wire pclk,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
  
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_AT_OUTPUT(vga_out)
  
  
  
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
            if (vcount_in == 0) rgb_out <= 12'hf_f_0; 
            else if (vcount_in == 599) rgb_out <= 12'hf_0_0;
            else if (hcount_in == 0) rgb_out <= 12'h0_f_0;
            else if (hcount_in == 799) rgb_out <= 12'h0_0_f;
            //M
            else if (((hcount_in >= 50 && hcount_in <= 55) && (vcount_in >= 10 & vcount_in <= 60)) || ((hcount_in >= 95 && hcount_in <= 100) && (vcount_in >= 10 && vcount_in <= 60))) rgb_out <= 12'hf_f_0; 
            else if (((((hcount_in + vcount_in >= 105)  && ( hcount_in + vcount_in <= 110))  && (hcount_in >= 75)) || (((hcount_in - vcount_in <= 45) && ( hcount_in - vcount_in >= 40  ))) && (hcount_in <= 75) ) && (vcount_in >= 10 && vcount_in <= 35 )) rgb_out <= 12'hf_f_0;
            //J
            else if ((vcount_in >= 10 && vcount_in <= 15) && (hcount_in >= 140 && hcount_in <= 170))  rgb_out <= 12'hf_f_0;
            else if ((vcount_in >= 10 && vcount_in <= 80) && (hcount_in >= 165 && hcount_in <=170))  rgb_out <= 12'hf_f_0;
            else if ((vcount_in >= 75 && vcount_in <= 80) && (hcount_in >= 140 && hcount_in <= 170))  rgb_out <= 12'hf_f_0;
            else if ((hcount_in + vcount_in >= 215 && hcount_in + vcount_in <= 220) && (vcount_in <= 80 && hcount_in <= 185))  rgb_out <= 12'hf_f_0;
            else rgb_out <= 12'h8_8_8;
        end
  end

endmodule




