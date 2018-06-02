`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2018 18:36:53
// Design Name: 
// Module Name: psx_clk_test
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


module psx_clk_test;

reg clk;
wire [3:0] BytesExpected;
wire [3:0] c_counter;
wire c_clk,READY,gen,rst;
reg [32:0] counter =0 ; 
reg ack =1;
reg [3:0] mask_counter = 1;
reg[3:0] delay = 0;
wire err_f;
 

psx_controller_clk_gen myPsx
(
    .clk(clk),
    .gen(gen),
    .rst(!gen),
    .BytesExpected(BytesExpected),
    .c_clk(c_clk),
    .c_counter(c_counter),
    .READY(READY),
    .err_f(err_f),
    .ack(ack)
    
);

  always
  begin
    
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
    counter  = counter +1;
    
  end
  
  always @(posedge clk)
    if(mask_counter == c_counter)
        begin
            if(ack)
                    ack = 0;
            else if(ack == 0)
                if(delay == 3)
                    begin
                        ack = 1 ;
                        delay = 0;
                        mask_counter = mask_counter +1;
                    end
                else
                    delay = delay +1;              
        end
      else if(mask_counter == 4'ha)
        begin 
            mask_counter = 0;
            counter  = 0;
            delay = 0;
        end
        else if(mask_counter > 9)
            ack = 1;
        
  
  
  
assign gen = (counter > 25)? 1 :0;
assign BytesExpected = (c_counter >= 2)? 9  : 5;



endmodule
