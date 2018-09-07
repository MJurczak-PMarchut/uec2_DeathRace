`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2018 13:21:01
// Design Name: 
// Module Name: drawNumber
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


module drawNumber(
        input wire [7:0] Number,
        input wire [10:0] hcount,vcount,
        output wire Pixel

    );
    parameter [10:0] xpos = 0;
    parameter [10:0] ypos = 0;
            wire [3:0] Addr1,Line;
            wire [7:0] Pixels;
        
        char_rom MyChar
        (
            .addr({Addr1,Line}),
            .data(Pixels)
            
        );
    

    
    reg [3:0] Setki,Dzie,Jedy;
    
    reg Conv = 0;
    integer  i;
        always @(Number)
            begin
                Setki = 4'h0;
                Dzie = 4'h0;
                Jedy = 4'h0;
                Conv = 0;
            
            for(i = 7; i >= 0; i=i-1)
                begin
                    if(Setki >= 5)
                        Setki = Setki + 3;
                    if(Dzie >= 5)
                        Dzie = Dzie +3;
                    if(Jedy >= 5)
                        Jedy = Jedy +3;
                        
                    Setki = Setki <<1;
                    Setki[0] = Dzie[3];
                    Dzie = Dzie <<1;
                    Dzie[0] = Jedy[3];
                    Jedy = Jedy << 1;
                    Jedy[0] = Number[i];
                    end
                    Conv = 1;
                 end 
                 
     wire [10:0] hcnt;
     assign hcnt = hcount - xpos;
                 
     assign Addr1 = ((hcount >= xpos) && ((hcount - xpos) <= 63))?Dzie:
     (((hcount >= xpos) && ((hcount - xpos) <= 127))?Jedy:0);
     assign Line = vcount[6:3];
     assign Pixel = ((hcount >= xpos) && ((hcount - xpos) <= 127)  && (vcount >= ypos) && (vcount - ypos <= 127))?
        Pixels[3'h7-hcnt[5:3]] : 0;
endmodule
