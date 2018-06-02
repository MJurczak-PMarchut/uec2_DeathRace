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
reg [3:0] mask_counter = 1; 
wire c_clk,READY,gen;
reg [32:0] counter =0 ; 
reg ack = 1;
wire err_f;
reg [1:0] delay = 0;

psx_controller_clk_gen myPsx
(
    .clk(clk),
    .gen(gen),
    .rst(!gen),
    .BytesExpected(BytesExpected),
    .c_clk(c_clk),
    .c_counter(c_counter),
    .READY(READY),
    .ack(ack),
    .err_f(err_f)
);

  always
  begin
    
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
    counter  = counter +1;
    
  end
  
  always @clk
    if(c_counter == mask_counter)
        begin
            if(mask_counter < 9)
                ack = 0;
            mask_counter  = mask_counter +1;
        end
    else if (ack == 0 )
        if(delay == 3)
            begin
                ack =1;
                delay = 0;
            end
        else
            delay = delay +1;
  
assign gen = (counter > 25)? 1 :0;
assign BytesExpected = (c_counter >= 2)? 9  : 5;



endmodule
