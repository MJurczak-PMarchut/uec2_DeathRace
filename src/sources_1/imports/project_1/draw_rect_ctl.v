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
    input wire left_button,
    input wire [11:0] xpos,
    input wire [11:0] ypos,
    input wire vsync,
    input wire [7:0] data,
    output reg [11:0] xpos_out,
    output reg [11:0] ypos_out
    );
    
    localparam accel = 3;
    
    reg en,st,bt,start,rev;
    reg [10:0] Speed;
    //reg [10:0] accel = 8;
    reg [11:0] acceleration_ratio;
    reg [11:0] xpos_next,ypos_next,ypos_int;
    reg [24:0] point;
    reg [16:0] Time; 
    reg [10:0] acceleration = 981;
    
    
    reg [7:0] waiter;

    initial
        begin 
        ypos_out <= ypos;
        xpos_out <= xpos;
        
        end
    
    always @(posedge clk)
        begin
            if ((vsync == 1) && (en == 1) )
                begin
                
                    en <= 0;
                    st <= 1;
                    Time <= Time + 1; 
                end
            else if ((vsync == 1) && (en == 0) && (st == 0))
                en <= 1;
            else if (vsync == 0)
                begin
                    en <= 0;
                    st <= 0;
                end
        
        end 
    
   /* 
    always @(posedge left_button)
    fork
        if(bt)
            bt <= 0;
        else
            bt <= 1;
       
    join
    */
    always @(posedge en)
 
            if(waiter >= 60)
                begin 
                    waiter <= 0;
                    if (data == 8'h72) 
                        ypos_out <= ypos_out - 1;
                    else if (data == 8'h75)
                        ypos_out <= ypos_out +1;
                end
             else
                waiter <= waiter +1;



      
        /*
        if(bt)
            begin
                if(!rev)
                    begin
//                       ypos_out <= ypos_int + Speed*Time + (0.5)*acceleration ** Time;
                       
                       
                       
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
                ypos_out = ypos;
                xpos_out = xpos;
                ypos_int <= ypos;
                Speed <= 0;
                //accel <= 8;
                acceleration_ratio <= accel;
                
            end
        
*/
    
    
    
    
endmodule
