`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2018 21:57:18
// Design Name: 
// Module Name: collision
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

module collision(
    input wire clk,
    input wire rst,
    input wire [23:0] grem0, grem1,
    input wire [21:0] car0, car1,
    input wire car1_enable, car0_enable,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [`VGA_BUS_SIZE-1:0] vga_out,
    output wire [7:0] points0_out, points1_out,
    output wire grem0_out, grem1_out,
    output wire [2:0] i
    );

    `VGA_SPLIT_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_MERGE_AT_OUTPUT(vga_out)

wire color, f0, f1;
wire [21:0] address;

reg f_nxt = 0;
reg [21:0] address_nxt = 0;
reg grem0_nxt = 1'b1, grem1_nxt = 1'b1;
reg [7:0] points0 = 0, points1 = 0;
reg [11:0] rgb_nxt = 0;

localparam CARW = 32;    
localparam GREMCARH = 32;
localparam GREMW = 16;

headstones my_headstones(
    .clk(clk),
    .reset(rst),
    .vga_in(vga_in),
    .f_in(f0),
    .address(address),
    .color_out(color),
    .f_out(f1),
    .i_out(i)
);

always @(posedge vsync_in or negedge rst)
    if(!rst)
        fork
            f_nxt <= 1'b0;
            points0 <= 8'b0;
            points1 <= 8'b0;
            grem0_nxt <= 1'b1;
            grem1_nxt <= 1'b1;
        join
    else
        begin
            f_nxt = f1;
            if((car0[21:11] >= grem0[22:12] - CARW) && (car0[21:11] <= grem0[22:12] + GREMW) && (car0[10:0] >= grem0[11:1] - GREMCARH) && (car0[10:0] <= grem0[11:1] + GREMCARH) && (grem0[0] == 1'b1) && (car0_enable == 1'b1)) begin
                address_nxt <= grem0[22:1];
                f_nxt = 1'b1;
                grem0_nxt = 1'b0;
                points0 = 8'b00000001 + points0;
            end
            else if((car0[21:11] >= grem1[22:12] - CARW) && (car0[21:11] <= grem1[22:12] + GREMW) && (car0[10:0] >= grem1[11:1] - GREMCARH) && (car0[10:0] <= grem1[11:1] + GREMCARH) && (grem1[0] == 1'b1) && (car0_enable == 1'b1)) begin
                address_nxt <= grem1[22:1];
                f_nxt = 1'b1;
                grem1_nxt = 1'b0;
                points0 = 8'b00000001 + points0;
            end
            else if((car1[21:11] >= grem0[22:12] - CARW) && (car1[21:11] <= grem0[22:12] + GREMW) && (car1[10:0] >= grem0[11:1] - GREMCARH) && (car1[10:0] <= grem0[11:1] + GREMCARH) && (grem0[0] == 1'b1) && (car1_enable == 1'b1)) begin
                address_nxt <= grem0[22:1];
                f_nxt = 1'b1;
                grem0_nxt = 1'b0;
                points1 = 8'b00000001 + points1;
            end
            else if((car1[21:11] >= grem1[22:12] - CARW) && (car1[21:11] <= grem1[22:12] + GREMW) && (car1[10:0] >= grem1[11:1] - GREMCARH) && (car1[10:0] <= grem1[11:1] + GREMCARH) && (grem1[0] == 1'b1) && (car1_enable == 1'b1)) begin
                address_nxt <= grem1[22:1];
                f_nxt = 1'b1;
                grem1_nxt = 1'b0;
                points1 = 8'b00000001 + points1;
            end
            else begin
                f_nxt = 1'b0;
                grem1_nxt = 1'b1;
                grem0_nxt = 1'b1;
            end
        end
        
always @*
    if(color)
        rgb_nxt <= 12'hfff;
    else 
        rgb_nxt <= rgb_in;

assign address = address_nxt;        
assign f0 = f_nxt;
assign grem0_out = grem0_nxt;
assign grem1_out = grem1_nxt;
assign points0_out = points0;
assign points1_out = points1;

always @(posedge clk)
 begin
     hcount_out = hcount_in;
     hsync_out = hsync_in;
     hblnk_out = hblnk_in;
     vcount_out = vcount_in;
     vsync_out = vsync_in;
     vblnk_out = vblnk_in;
     rgb_out = rgb_nxt;
 end 
   
endmodule
