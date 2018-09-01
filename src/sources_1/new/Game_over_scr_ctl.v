`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2018 22:51:19
// Design Name: 
// Module Name: Game_over_scr_ctl
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

module Game_over_scr_ctl(
        input wire TimeOut,
        input wire NoOfPlayers,
        input wire [7:0] Player1Score,
        input wire [7:0] Player2Score,
        input wire [`VGA_BUS_SIZE-1:0] vga_in,
        
        output wire GremlinsEnable,
        output wire Car1Enable,
        output wire Car2Enable,
        output wire [`VGA_BUS_SIZE-1:0] vga_out
       
    );
    
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_WIRE
    `VGA_MERGE_AT_OUTPUT(vga_out)
    
    
    wire [3:0] x,y;
    wire [6:0] char_code;
    wire [7:0] Pixels;
    wire [3:0] Line;
    
    Game_Over_Text_Rom GOTR(
        .char_xy({y,x}),
        .char_code(char_code)
    );
    
    font_rom GOF
    (
        .addr((char_code != 7'h7f)?{char_code,Line}:11'b0),
        .data(Pixels)
        
    );

    
    wire [10:0] hcnt;
    
    assign hcnt = hcount_in - 12'd65;
    
    
    assign hcount_out = hcount_in;
    assign vcount_out = vcount_in;
    assign hblnk_out = hblnk_in;
    assign vblnk_out = vblnk_in;
    assign vsync_out = vsync_in;
    assign hsync_out = hsync_in;
    
    
    assign x = ((vcount_in >= 128) && (vcount_in <= 256) && (hcount_in <= 705) && (hcount_in >= 65))? hcnt[9:6]:
               ((vcount_in > 256) && ( vcount_in <= 384) && (hcount_in <= 513) && (hcount_in >= 65))? hcnt[9:6]:4'hf;
    assign y = ((vcount_in >= 128) && (vcount_in <= 256))? 4'b0:
               ((vcount_in > 256 )&& (vcount_in < 384))?4'b1:4'h2;
               
               
    assign Car1Enable = (TimeOut == 0)?1:
           ((Player1Score > Player2Score))? 1:0; 
    assign Car2Enable = ((TimeOut == 0) && (NoOfPlayers == 1))?1:
                      (Player2Score > Player1Score)? 1:0; 
    assign GremlinsEnable = (TimeOut == 0)? 1 :0;
    
    assign Line = vcount_in[6:3];
    
    assign rgb_out = (((vcount_in >= 128) && (vcount_in < 384) && (Pixels[3'h7-hcnt[5:3]])) && (TimeOut == 1) && (char_code != 7'h7f))?12'hfff:rgb_in;
    
    
endmodule
