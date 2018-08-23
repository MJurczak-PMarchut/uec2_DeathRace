`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2018 17:33:15
// Design Name: 
// Module Name: game_bg
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


module game_bg(
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    input wire NoOfPlayers,
    input wire rst,
    input wire [7:0] Player1Score,
    input wire [7:0] Player2Score,
    input wire clk,
    output wire TimeOut, 
    output wire [`VGA_BUS_SIZE-1:0] vga_out
    );
  
 
    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_WIRE
    `VGA_MERGE_AT_OUTPUT(vga_out)
    
    reg en,st;
    
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

    reg [7:0] Timer = 60;
    reg [5:0] Prescaler = 0;
    wire Player1ScorePix,Player2ScorePix,TimerPix,PixOut;
    
    drawNumber #(.xpos(0),.ypos(0))Player1ScoreDisp(
        .Number(Player1Score),
        .hcount(hcount_in),
        .vcount(vcount_in),
        .Pixel(Player1ScorePix)
    
    );
    
    drawNumber #(.xpos(336),.ypos(0))TimerDisp(
        .Number(Timer),
        .hcount(hcount_in),
        .vcount(vcount_in),
        .Pixel(TimerPix)
    
    );
    
    
    drawNumber #(.xpos(672),.ypos(0))Player2ScoreDisp(
        .Number(Player2Score),
        .hcount(hcount_in),
        .vcount(vcount_in),
        .Pixel(Player2ScorePix)

    );
    
    always @(posedge clk or negedge rst)
        if (!rst) 
            begin
                Timer = 60;
                Prescaler = 0;
            end
        else if (en) 
            begin
                Timer = (Timer != 0)?
                ((Prescaler == 60)?  Timer - 1 : Timer):
                Timer;
                Prescaler = (Prescaler <= 60)? Prescaler + 1:0;
            end
    
    
    
 assign TimeOut = (Timer == 0)? 1:0;
 
 
 

 
 assign rgb_out = ((hblnk_in == 1) || (vblnk_in == 1))?12'h0:
        (vcount_in >= 595)? 12'hfff:
        ((hcount_in >=795) && (vcount_in >= 105))?12'hfff:
        ((hcount_in <= 5) && (vcount_in >= 105))?12'hfff:
        ((vcount_in >= 100) && (vcount_in <= 105))?12'hfff:
        ((vcount_in >= 105) && (((hcount_in >= 60) && (hcount_in <= 65)) || ((hcount_in <= 740) && (hcount_in >= 735))) && vcount_in[3] == 0)? 12'hfff:
        ((vcount_in <= 100)? ((PixOut == 1)? 12'hfff :rgb_in) : rgb_in);    


    assign hcount_out = hcount_in;
    assign vcount_out = vcount_in;
    assign hblnk_out = hblnk_in;
    assign vblnk_out = vblnk_in;
    assign vsync_out = vsync_in;
    assign hsync_out = hsync_in;
    assign PixOut = (Player1ScorePix || Player2ScorePix || TimerPix);
endmodule
 