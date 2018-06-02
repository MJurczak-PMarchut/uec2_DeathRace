`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2018 17:29:59
// Design Name: 
// Module Name: psx_controller_clk_gen
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


module psx_controller_clk_gen(
    input wire clk,
    input wire gen,
    input wire rst,
    input wire [3:0] BytesExpected,
    output reg c_clk,
    output wire [3:0] c_counter,
    output reg READY
    );
    parameter [11:0] upCount = 1000;
    localparam IDLE = 0;
    localparam RESET = 1;
    localparam IN_P = 2;
    localparam DELAY = 3;
    localparam STOP = 4;
    
    localparam DELAY_CLK = 4;
    localparam EDGE_COUNT = 15;
    
    
    localparam FALLING = 0;
    localparam RISING = 1;
    
    reg [3:0] DATA_EXPECTED;
    reg [3:0] state,next_state;
    reg [4:0] delay_count=0;
    reg [4:0] P_count=0;
    reg [3:0] data_count;
    reg [11:0] upCounter;
    reg [1:0] clk_edge;
    reg DELAY_ENTERED = 0;
    reg P_ENTERED = 0;

    
    
    
    always @*
        begin
            if(rst)
                next_state = RESET;
            else if (state == DELAY)
                if (delay_count < DELAY_CLK)
                    next_state = DELAY;
                else if (data_count < BytesExpected)
                    next_state = IN_P;
                else next_state = STOP;
            else if (state == IN_P)
                if(P_count <= EDGE_COUNT)
                    next_state = state;
                else 
                    next_state = DELAY;
            else if (gen)
                if((state == IDLE) || (state == RESET))
                    next_state = IN_P;
                else 
                    next_state = state;
           else 
                next_state = state;
         end
                 
                
         always @(posedge clk)
             begin
                 state = next_state; 
                 case(state)
                     IDLE : data_count = 0; 
                     RESET: 
                         begin
                             c_clk = 1;
                             delay_count = 0;
                             data_count = 0;
                             DELAY_ENTERED = 0;
                             READY = 0;
                             P_ENTERED =  0;
                         end
                     IN_P:
                         begin
                             READY = 0;
                             DELAY_ENTERED = 0;
                             if(P_ENTERED == 0)
                                begin
                                    P_count = 0;
                                    P_ENTERED =  1;
                                end
                             if(c_clk)
                                 clk_edge = FALLING;
                             else 
                                 clk_edge = RISING;
                             c_clk = ~c_clk;
                             P_count = P_count +1;
                         end                            
                      DELAY:
                         begin
                             READY = 0;
                             if(DELAY_ENTERED == 0)
                                 begin
                                     DELAY_ENTERED = 1;
                                     delay_count = 0;
                                     data_count = data_count +1;
                                     P_ENTERED =  0;
                                 end
                              else
                                 delay_count =  delay_count + 1;                                
                         end
                         STOP : READY = 1;
                         default : $display("Error in SEL");
                      endcase
                      end
 
 
    assign c_counter = data_count;
endmodule
