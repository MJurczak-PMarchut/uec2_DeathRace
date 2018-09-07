`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2018 23:44:54
// Design Name: 
// Module Name: adc
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

module adc(
    input wire clk,
    input wire vauxp6,
    input wire vauxn6,
    input wire vauxp7,
    input wire vauxn7,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    output wire [3:0] direction1_out, direction0_out
 );

reg [15:0] data0, data1;  
wire enable;  
wire ready;
wire [15:0] data;   
wire [6:0] Address_in;     
reg [11:0] data0_nxt = 0, data1_nxt = 0;
reg en, st;

    `VGA_SPLIT_INPUT(vga_in)
  
   
//xadc instantiation connect the eoc_out .den_in to get continuous conversion
xadc_wiz_0  XLXI_7 (.daddr_in(Address_in), //addresses can be found in the artix 7 XADC user guide DRP register space
    .dclk_in(clk),
    .reset_in(0), 
    .den_in(enable), 
    .di_in(0), 
    .dwe_in(0), 
    .busy_out(),                    
    .vauxp6(vauxp6),
    .vauxn6(vauxn6),
    .vauxp7(vauxp7),
    .vauxn7(vauxn7),
    .vn_in(0), 
    .vp_in(0), 
    .alarm_out(), 
    .do_out(data), 
    .eoc_out(enable),
    .channel_out(),
    .drdy_out(ready)
    );

steerage my_steerage0(
    .direction_in(data0[11:0]),
    .direction_out(direction0_out)
);

steerage my_steerage1(
    .direction_in(data1[11:0]),
    .direction_out(direction1_out)
);

always @(posedge clk)
begin
    if ((vsync_in == 1) && (en == 1) )
        begin             
            en <= 0;
            st <= 1; 
        end
    else if ((vsync_in == 1) && (en == 0) && (st == 0))
        en <= 1;
    else if (vsync_in == 0)
        begin
            en <= 0;
            st <= 0;
        end        

end
      
always @(posedge ready)
    if(vcount_in <= 300) data0_nxt <= data[15:4];
    else data1_nxt <= data[15:4];

always @(posedge clk)
if(en) begin
    data0 <= data0_nxt;
    data1 <= data1_nxt;
    end      

assign Address_in = (vcount_in <= 300)? 8'h16 : 8'h17;
       
endmodule

