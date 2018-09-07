`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2018 23:35:13
// Design Name: 
// Module Name: State_Master
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


module State_Master(
    input wire rst,
    input wire START,
    input wire UP,
    input wire DOWN,
    input wire Timer,
    input wire clk,
    output wire playerCount,
    output wire title_screen,
    output wire wait_for_start,
    output wire time_out,
    output wire highscore,
    output wire GameOn,
    input wire restart
    );
    
    wire [3:0] State;
    reg [3:0] State_inter = 0;
    reg [3:0] State_next = 0;
    reg NoOfPlayers = 0;
    
    localparam SinglePlayChosen = 1'b0;
    localparam DualPlayChosen = 1'b1;
    
    localparam StartGame = 4'b0011;
    localparam TitleScreen = 4'b0010;
    localparam InGame = 4'b0110;
    localparam TimeOut = 4'b0111;
    localparam Highscore = 4'b1111;
    localparam Restart = 4'b1110;
    
    always @*
        if(State == TitleScreen)
            if(NoOfPlayers == SinglePlayChosen)
                NoOfPlayers = ((DOWN) && (!UP))?DualPlayChosen:SinglePlayChosen;
            else
                NoOfPlayers = ((UP) && (!DOWN))?SinglePlayChosen:DualPlayChosen;
                
                
                
                
    always @*
        begin
            case(State)
                TitleScreen:    State_next = (START)?StartGame:TitleScreen;
                StartGame:      State_next = InGame;
                InGame:         State_next = (Timer)?TimeOut:InGame;
                TimeOut:        State_next = (restart)?StartGame:((START)?TitleScreen:TimeOut);
                Highscore:      State_next = (restart)?TitleScreen:Highscore;
                default:        State_next = TitleScreen;
            endcase
        end
      
      always @(posedge clk) 
        if(rst)
            State_inter <= State_next;
        else 
            State_inter  <= TitleScreen;

      assign State = (!rst)?TitleScreen:State_inter;    
      assign highscore = (State == Highscore)? 1 : 0;
      assign GameOn = ((State == InGame) || (State == TimeOut))? 1 : 0;
      assign title_screen = (State == TitleScreen)? 1 : 0;
      assign time_out = (State == TimeOut)? 1 : 0;  
      assign wait_for_start = (State == StartGame)? 1 : 0; 
      assign playerCount = NoOfPlayers ;

      
endmodule
