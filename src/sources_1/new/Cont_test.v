`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2018 14:14:43
// Design Name: 
// Module Name: Cont_test
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


module Cont_test(
        input wire START,
        input wire ACK,
        input wire DATA,
        input wire LEFT,
        input wire rst,
        input wire clk,
        output wire [15:0] LED,
        output wire [1:0] Controller_sel,
        output wire CMD,
        output wire c_clk
        
        
    
    );
    
    reg [13:0] clk_div = 0;
    reg [10:0] clk_div2 =0; 
    reg c_bit= 0;
    
    
      wire clk_in;
    wire locked;
    wire clk_fb;
    wire clk_ss;
    wire clk_out;
    wire pclk;
    wire pclk100;
    wire pclk_mirror;
    wire clk1;
    (* KEEP = "TRUE" *) 
    (* ASYNC_REG = "TRUE" *)
    reg [7:0] safe_start = 0;
  
  
  clk_wiz_0 myClk(
      .clk_out1(pclk100),
      .clk_in1(clk),
      .locked(locked),
      .clk_out2(pclk),
      .clk_out3(clk1),
      .reset(1'b0)
  );
  
    
    ila_0 logic(
        .clk(clk1),
        .probe0(CMD),
        .probe1(DATA),
        .probe2(c_clk),
        .probe3(ACK),
        .probe4(Controller_sel),
        .probe5(LED[15])
        
        );
    
always @(posedge pclk100)
       if(clk_div <= 7143)
            clk_div = clk_div +1;
       else 
            fork
                c_bit = !c_bit;
                clk_div = 0;
            join
always @(posedge c_bit)
              clk_div2 = clk_div2 +1;    
    
            
    
    psx_controller_module(
        .vsync(START),
        .rst(rst),
        .err_f(LED[15]),
        .clk(c_bit),
        .DATA(DATA),
        .CMD(CMD),
        .ack(ACK),
        .read_burst(LEFT),
        .ByteAddress1(1),
        .ControllerByte1(LED[7:0]),
        .Controller_w(Controller_sel),
        .c_clk(c_clk),
        .state_out(LED[10:8]),
        .state_clk(LED[14:12])
        
    );
    
endmodule
