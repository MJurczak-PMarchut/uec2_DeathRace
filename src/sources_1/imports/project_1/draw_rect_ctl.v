`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2018 16:15:08
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

`include "verilog_macro_bus.vh"

module draw_rect_ctl(
        input wire pclk,
        input wire vsync,
        input wire mouse_left,
        input wire [11:0] mouse_xpos,
        input wire [11:0] mouse_ypos,
        output wire [`MOUSE_BUS_SIZE-1:0] mouse_out
);

`MOUSE_OUT_REG
`MOUSE_MERGE_AT_OUTPUT(mouse_out)

   
  //localparam IDLE = 0;
  localparam FALL = 0;
  localparam RAISE = 1;
  
  reg [9:0] speed;
//  localparam acc = 1'b1;
    reg bt;
  
  reg [1:0] state = 2'b00;
  
  reg [4:0] acc = 5'h0;
    
    always @(posedge mouse_left) 
    if(bt)
        bt<=0;
    else 
        bt <=1;
    
    always @(posedge vsync)
    begin
    
    if(bt)
         case(state)
          //   IDLE: begin
            //        xpos <= mouse_xpos;
              //      ypos <= mouse_ypos;
                //    speed = 0;
               // end
             FALL: begin
                    if(ypos_out + speed >= 536) begin
                         state = RAISE;
                         speed = speed / 2;
                         end
                    else begin
                        acc = acc + 1;
                        if(acc == 3) begin 
                            speed = speed + 1;
                            acc = 0;
                            end
                        ypos_out <= ypos_out + speed;
                    end
                end
             RAISE: begin
                   if(speed <= 1) begin
                       state = FALL;
                       end
                   else begin
                       acc = acc + 1;
                       if(acc == 3) begin 
                          speed = speed - 1;
                          acc = 0;
                          end
                       ypos_out <= ypos_out - speed;
                       end   
             end
             
          endcase            
          else begin
          
                              xpos_out <= mouse_xpos;
                              ypos_out <= mouse_ypos;
                              speed = 0;
                              end
     end   
endmodule
