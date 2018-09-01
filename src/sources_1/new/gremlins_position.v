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
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    output reg [23:0] grem0_out, grem1_out //23 color, 22:12 xpos, 11:1 ypos, 0 aktywny/nieaktywny
    );
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_AT_OUTPUT(vga_out)

wire [2:0] addr1, addr1_1;
wire [4:0] addr2, addr2_1;
wire [23:0] grem0_0, grem0_1, grem1_0, grem1_1;
wire [15:0] char_line_pix, char_line_pix_1; 
    
localparam GREMH = 32;
localparam GREMW = 16;

reg [23:0] grem0_nxt, grem1_nxt;
reg [11:0] rgb_nxt;

  gremlin #(.I(217),.J(0),.XPOS_INIT(200),.YPOS_INIT(300)) my_gremlin0 (
    .clk(pclk),
    .vga_in(vga_in),
    .char_pixels(char_line_pix),
    .char_xy(addr1),
    .char_line(addr2),
    .xpos(grem0_0[22:12]),
    .ypos(grem0_0[11:1]),
    .color(grem0_0[23])
  );
  
  gremlin_rom my_gremlin0_rom(
    .clk(pclk),
    .addr1(addr1),
    .addr2(addr2),
    .char_line_pixels(char_line_pix)
  );

  gremlin #(.I(263),.J(3),.XPOS_INIT(600),.YPOS_INIT(300)) my_gremlin1(
    .clk(pclk),
    .vga_in(vga_in),
    .char_pixels(char_line_pix_1),
    .char_xy(addr1_1),
    .char_line(addr2_1),
    .xpos(grem1_0[22:12]),
    .ypos(grem1_0[11:1]),
    .color(grem1_0[23])
  );
  
  gremlin_rom my_gremlin1_rom(
    .clk(pclk),
    .addr1(addr1_1),
    .addr2(addr2_1),
    .char_line_pixels(char_line_pix_1)
  );  


always @(posedge pclk)
begin
    grem0_nxt[23:1] = grem0_0[23:1];
    grem1_nxt[23:1] = grem1_0[23:1];
end

always @*
if((grem0_nxt[0] & grem0_nxt[23]) || (grem1_nxt[0] & grem1_nxt[23]))
    rgb_nxt <= 12'hfff;
else 
    rgb_nxt <= rgb_in;

always @(posedge vsync_in)
    if(grem0_nxt[0] == 0) grem0_nxt[0] = ~grem0_nxt[0];
    else if (grem1_nxt[0] == 0) grem1_nxt[0] = ~grem1_nxt[0];


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
   
//always @*
//begin
//grem0_1 = grem0_nxt;
//grem1_1 = grem1_nxt;
//end 
    
endmodule
