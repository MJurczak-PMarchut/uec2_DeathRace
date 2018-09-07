`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2018 15:07:43
// Design Name: 
// Module Name: psx_controller_module
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


module psx_controller_module(
    input vsync,
    input wire ack,
    input rst,
    input clk,
    input read_burst,
    input DATA,
    input wire [3:0] ByteAddress1,
    input wire [3:0] ByteAddress2,
    output wire [7:0] ControllerByte1,
    output wire [7:0] ControllerByte2,
    output wire CMD,
    output wire [1:0] Controller_w,
    output wire c_clk,
    output wire [3:0] clk_state,
    output reg DataReady = 0,
    output wire err_f,
    output wire [2:0] state_out,
    output wire [1:0] state_clk,
    output reg gen
    );
    
    reg [1:0] Controller;
    localparam IDLE = 3'b000;
    localparam INIT = 3'b001;
    localparam Cont1 = 3'b011;
    localparam Cont2 = 3'b010;
    localparam FINISHED = 3'b110;
    localparam INIT2 = 3'b100;
    
    reg [7:0] Command_Table [8:0];
    reg [3:0] BytesExpected;
    reg CMD_reg = 1;
    
    initial
        fork
            Command_Table[0] <= 1;
            Command_Table[1] <= 8'h42;            
        join
    reg [3:0] i= 0; 
    
    initial 
        for (i = 2; i<8; i = i+1)
            Command_Table[i] <= 0;
    
    
    reg [2:0] state, state_next;
   // reg gen;
    wire READY;
    reg read_finished;
    reg [7:0] Output_Cont1 [8:0] ;
    reg [7:0] Output_Cont2 [8:0] ;
    wire [3:0] c_counter;
    psx_controller_clk_gen My_clk(
        .clk(clk),
        .gen(gen),
        .READY(READY),
        .c_counter(c_counter),
        .c_clk(c_clk),
        .err_f(err_f),
        .rst(!gen),
        .BytesExpected(BytesExpected),
        .ack(ack),
        .state_out(clk_state)
    );
    reg [3:0]bit_counter = 0;
    
    always @*
        if(!rst)
            case(state)
                IDLE: state_next = (vsync == 1)? INIT:IDLE;
                INIT: state_next = Cont1;
                Cont1: state_next = (READY == 1) ? INIT2:Cont1;
                INIT2: state_next = Cont2;
                Cont2: state_next = (READY == 1)? FINISHED : Cont2;
                FINISHED: state_next = (read_finished == 1)? IDLE:FINISHED;
                default: state_next = IDLE;
            endcase
        else
            state_next = IDLE;
        
   always @(posedge clk)
     if(!rst)
        state = state_next;
     else
        state = IDLE;
        
    always @(posedge clk)
        case(state)
            IDLE:   
                fork
                    Controller = 0;
                    gen = 0;
                    
                join
            INIT:
                fork
                    gen = 0;
                    Controller = 1;
                    BytesExpected = 5;
                join
            Cont1:
                if(err_f != 1)
                    begin
                        gen = 1;
                        if (clk_state == 2)
                            if (c_clk == 0)
                                begin                                
                                    Output_Cont1[c_counter][7 - ((bit_counter == 0)? 7 :bit_counter -1)] = DATA;
                                        if(c_counter == 2)
                                            if(Output_Cont1[1] == 8'h42)
                                                BytesExpected = 9;
                                end
                        if(c_counter == 9)
                            gen = 0;
                    end
                else
                    Output_Cont1[1] = 0;
            INIT2:
                fork
                    Controller = 2;
                    gen = 0;
                    BytesExpected = 5;
                join
            Cont2:
                if(err_f != 1)
                    begin
                        gen = 1;
                        if (clk_state == 2)
                            if (c_clk == 1)
                                begin
                                    Output_Cont2[c_counter][7 - ((bit_counter == 0)? 7 :bit_counter -1)] = DATA;
                                      if(c_counter == 2)
                                        if(Output_Cont1[1] == 8'h55)
                                            BytesExpected = 9;
                                 end
                        if(c_counter == 9)
                            gen = 0;
                    end
                  else
                    Output_Cont1[1] = 0;
                    
             FINISHED:
                    begin
                        DataReady =1 ;
                        if(read_burst)
                            begin
                                read_finished = 1;
                                DataReady = 0;
                            end
                    end
             default:gen = 0;
             endcase
    
    reg [3:0] laststate = 0;
    always @(c_clk )
            if(!c_clk)
               
                if(clk_state == 2)
                    CMD_reg = Command_Table[c_counter][((bit_counter +1) <= 7)?bit_counter : bit_counter];
                  else 
                    CMD_reg =1;
             else       
                 if(bit_counter < 7 && clk_state == 2)
                        bit_counter = bit_counter +1;
                    else
                            bit_counter = 0;
                    

        
    assign Controller_w = ~Controller;
    assign ControllerByte1 = Output_Cont1[ByteAddress1];
    assign ControllerByte2 = Output_Cont2[ByteAddress2];
    assign CMD = ((clk_state >= 2) && (clk_state <= 3) && (c_counter < BytesExpected))? CMD_reg:1;
    assign state_out = state;
    assign state_clk = clk_state;
endmodule
