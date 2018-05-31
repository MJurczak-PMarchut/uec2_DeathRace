`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2018 22:29:03
// Design Name: 
// Module Name: start_screen
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


module start_screen(
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    input wire pclk,
    output wire [`VGA_BUS_SIZE-1:0] vga_out
);

`VGA_SPLIT_INPUT(vga_in)
`VGA_OUT_REG
`VGA_MERGE_AT_OUTPUT(vga_out)

reg [3:0] rom [0:120000];

initial $readmemh("image_rom.data", rom); 

always @(posedge pclk)
begin
    if(hcount_in[10:1] < 400)
        if(vcount_in[10:1] < 300)
                rgb_out <= (rom[hcount_in[10:1]+(vcount_in[10:1]*400)]*12'h111);
            else
            rgb_out <= 0;
    hsync_out <= hsync_in;
    vsync_out <= vsync_in;
    hblnk_out <= hblnk_in;
    vblnk_out <= vblnk_in;
    hcount_out <= hcount_in;
    vcount_out <= vcount_in;
end

endmodule

