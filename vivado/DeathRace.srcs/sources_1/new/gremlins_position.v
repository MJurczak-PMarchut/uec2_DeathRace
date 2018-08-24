`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2018 21:35:54
// Design Name: 
// Module Name: gremlins_position
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

//obecnoœæ gremlina
//obrys 16na32
//pozycja piksela na ludziku
`include "verilog_macro_bus.vh"

module gremlins_position(
    input wire pclk,
    input wire [23:0] grem0_in, grem1_in,   //23 color, 22:12 xpos, 11:1 ypos, 0 aktywny/nieaktywny     
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    output reg [23:0] grem0_out, grem1_out
//    output wire [2:0] dir0, dir1
    );
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_AT_OUTPUT(vga_out)
    
localparam GREMH = 32;
localparam GREMW = 16;


//assign dir0 = 3'b000;
//assign dir1 = 3'b001;


reg [23:0] grem0, grem1;
reg [11:0] rgb_nxt;

always @(posedge pclk)
begin
    grem0[23:1] = grem0_in[23:1];
    grem1[23:1] = grem1_in[23:1];
end

always @*
if((grem0[0] & grem0[23]) || (grem1[0] & grem1[23]))
    rgb_nxt <= 12'hfff;
else 
    rgb_nxt <= rgb_in;

always @(posedge vsync_in)
    if(grem0[0] == 0) grem0[0] = ~grem0[0];
    else if (grem1[0] == 0) grem1[0] = ~grem1[0];


always @(posedge pclk)
 begin
     hcount_out = hcount_in;
     hsync_out = hsync_in;
     hblnk_out = hblnk_in;
     vcount_out = vcount_in;
     vsync_out = vsync_in;
     vblnk_out = vblnk_in;
     rgb_out = rgb_nxt;
 end  
   
always @*
begin
grem0_out = grem0;
grem1_out = grem1;
end 
    
endmodule
