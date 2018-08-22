`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2018 22:50:11
// Design Name: 
// Module Name: draw_rect_ctl
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


module draw_rect_ctl(
    input wire clk,
    input wire rst,
    input wire [`MOUSE_BUS_SIZE-1:0] mouse_in,
    output wire [`MOUSE_BUS_SIZE-1:0] mouse_out,
    input wire vsync
    );
    
    
    `MOUSE_SPLIT_INPUT(mouse_in)
    `MOUSE_OUT_REG
    `MOUSE_MERGE_AT_OUTPUT(mouse_out)
    
    localparam accel = 2;
    
    reg en,st,bt,start,rev;
    reg [10:0] Speed;
    reg [10:0] acceleration_ratio;
    reg [5:0] modifier;
    reg [11:0] xpos_next,ypos_next,ypos_int;
    
    localparam IDLE = 0;
    localparam FALLING = 1;
    localparam BOUNCE = 2;
    
    reg [3:0] state, next_state;
/*    
    always @(posedge rst)
        begin
            Speed <= 0;
            acceleration_ratio <=0;
            xpos_next <= 0;
            ypos_next <= 0;
            en <= 0;
            st <= 0;
            bt <= 0;
            start <= 0;
            rev <= 0;
        end
  */  
    always @(posedge clk)
        begin
            if ((vsync == 1) && (en == 1) )
                begin             
                    en <= 0;
                    st <= 1; 
                end
            else if ((vsync == 1) && (en == 0) && (st == 0))
                en <= 1;
            else if (vsync == 0)
                begin
                    en <= 0;
                    st <= 0;
                end        
        end 
    
    
    always @(posedge left_in)
    fork
        if(bt)
            bt <= 0;
        else
            bt <= 1;
       
    join
    
    always @(posedge clk)
    if(en)
    
        if(bt)
            begin
                if(!rev)
                    begin
                      // ypos_out <= ypos_int + Speed*Time + (0.5)*acceleration ** Time;
                      
                       ypos_out = ((ypos_int + Speed) < 536) ? (ypos_int + Speed) : 536;
                       acceleration_ratio = (acceleration_ratio != 0) ? acceleration_ratio - 1 : accel;
                       if(ypos_out < 536)
                         Speed = (acceleration_ratio == 0) ? Speed + 1  : Speed;
                       else
                         begin
                            rev <= 1;
                            acceleration_ratio <= 1;
                         end
                             
                    end
                 else
                    begin
                    
                        acceleration_ratio = (acceleration_ratio != 0) ? acceleration_ratio - 1 : accel - 1;
                        if(Speed > 0)
                          Speed = (acceleration_ratio == 0) ? Speed - 1  : Speed;
                        else
                            begin
                                rev <= 0;
                                acceleration_ratio <= accel;
                            end
                        ypos_out = (ypos_int <= 536) ? (ypos_int - Speed) : 536;
                        
                    end
                ypos_int <= ypos_out;
            end
        else
            begin
                ypos_out = ypos_in;
                xpos_out = xpos_in;
                ypos_int <= ypos_in;
                Speed <= 0;
                //accel <= 8;
                acceleration_ratio <= accel;
                
            end
        

    
    
    
    
endmodule
