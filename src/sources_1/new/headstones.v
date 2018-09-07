`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2018 15:02:48
// Design Name: 
// Module Name: headstones
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

module headstones(
    input wire clk, reset,
    input wire [`VGA_BUS_SIZE-1:0] vga_in,
    input wire f_in,
    input wire [21:0] address,
    output wire color_out,
    output wire f_out
    );

    `VGA_SPLIT_INPUT(vga_in)

wire [4:0] addr0, addr1, addr2, addr3, addr4, addr5, addr6, addr7;
wire [15:0] char_line_pix0, char_line_pix1, char_line_pix2, char_line_pix3, char_line_pix4, char_line_pix5, char_line_pix6, char_line_pix7;

reg f_nxt = 0;
reg [7:0] color = 0;
reg [2:0] i = 3'b000;
reg [3:0] j = 0;
reg [21:0] addr [7:0]; 
reg [10:0] hcount_char [7:0], vcount_char [7:0];

  headstone_rom my_headstone0_rom(
    .addr(addr0),
    .char_line_pixels(char_line_pix0)
  );

  headstone_rom my_headstone1_rom(
    .addr(addr1),
    .char_line_pixels(char_line_pix1)
  );
  
    headstone_rom my_headstone2_rom(
    .addr(addr2),
    .char_line_pixels(char_line_pix2)
  );
  
    headstone_rom my_headstone3_rom(
    .addr(addr3),
    .char_line_pixels(char_line_pix3)
  );
  
    headstone_rom my_headstone4_rom(
    .addr(addr4),
    .char_line_pixels(char_line_pix4)
  );
  
    headstone_rom my_headstone5_rom(
    .addr(addr5),
    .char_line_pixels(char_line_pix5)
  );
  
    headstone_rom my_headstone6_rom(
    .addr(addr6),
    .char_line_pixels(char_line_pix6)
  );
  
    headstone_rom my_headstone7_rom(
    .addr(addr7),
    .char_line_pixels(char_line_pix7)
  );

always @(posedge f_in) i = i + 3'b001;

always @(posedge clk)
if(!reset)
        begin      
          addr[0] <= 0;
          addr[1] <= 0;
          addr[2] <= 0;
          addr[3] <= 0;
          addr[4] <= 0;
          addr[5] <= 0;
          addr[6] <= 0;
          addr[7] <= 0;  
        end
else
begin
    
    if(f_in == 1'b1) begin
        addr[i] <= address;
        f_nxt <= 1'b0;
        end
    else f_nxt <= f_in;
            
    if(addr[0] != 0)begin            
            vcount_char[0] <= vcount_in - addr[0][10:0];
            hcount_char[0] <= hcount_in - addr[0][21:11];                        
            color[0] <= ((char_line_pix0[15 - hcount_char[0][3:0]] == 1) && (hcount_char[0][10:4] == 0) && (vcount_char[0][10:5] == 0))?1:0;
            end
            
    if(addr[1] != 0)begin            
            vcount_char[1] <= vcount_in - addr[1][10:0];
            hcount_char[1] <= hcount_in - addr[1][21:11];                        
            color[1] <= ((char_line_pix1[15 - hcount_char[1][3:0]] == 1) && (hcount_char[1][10:4] == 0) && (vcount_char[1][10:5] == 0))?1:0;
            end

    if(addr[2] != 0)begin            
            vcount_char[2] <= vcount_in - addr[2][10:0];
            hcount_char[2] <= hcount_in - addr[2][21:11];                        
            color[2] <= ((char_line_pix2[15 - hcount_char[2][3:0]] == 1) && (hcount_char[2][10:4] == 0) && (vcount_char[2][10:5] == 0))?1:0;
            end
            
    if(addr[3] != 0)begin            
            vcount_char[3] <= vcount_in - addr[3][10:0];
            hcount_char[3] <= hcount_in - addr[3][21:11];                        
            color[3] <= ((char_line_pix3[15 - hcount_char[3][3:0]] == 1) && (hcount_char[3][10:4] == 0) && (vcount_char[3][10:5] == 0))?1:0;
            end
            
    if(addr[4] != 0)begin            
            vcount_char[4] <= vcount_in - addr[4][10:0];
            hcount_char[4] <= hcount_in - addr[4][21:11];                        
            color[4] <= ((char_line_pix4[15 - hcount_char[4][3:0]] == 1) && (hcount_char[4][10:4] == 0) && (vcount_char[4][10:5] == 0))?1:0;
            end
            
    if(addr[5] != 0)begin            
            vcount_char[5] <= vcount_in - addr[5][10:0];
            hcount_char[5] <= hcount_in - addr[5][21:11];                        
            color[5] <= ((char_line_pix5[15 - hcount_char[5][3:0]] == 1) && (hcount_char[5][10:4] == 0) && (vcount_char[5][10:5] == 0))?1:0;
            end            

    if(addr[6] != 0)begin            
            vcount_char[6] <= vcount_in - addr[6][10:0];
            hcount_char[6] <= hcount_in - addr[6][21:11];                        
            color[6] <= ((char_line_pix6[15 - hcount_char[6][3:0]] == 1) && (hcount_char[6][10:4] == 0) && (vcount_char[6][10:5] == 0))?1:0;
            end
            
    if(addr[7] != 0)begin            
            vcount_char[7] <= vcount_in - addr[7][10:0];
            hcount_char[7] <= hcount_in - addr[7][21:11];                        
            color[7] <= ((char_line_pix7[15 - hcount_char[7][3:0]] == 1) && (hcount_char[7][10:4] == 0) && (vcount_char[7][10:5] == 0))?1:0;
            end

end

assign color_out = (vga_in == 12'hfff)?1:(color[0] | color[1] | color[2] | color[3] | color[4] | color[5] | color[6] | color[7]);
assign addr0 = vcount_char[0][4:0];
assign addr1 = vcount_char[1][4:0];
assign addr2 = vcount_char[2][4:0];
assign addr3 = vcount_char[3][4:0];
assign addr4 = vcount_char[4][4:0];
assign addr5 = vcount_char[5][4:0];
assign addr6 = vcount_char[6][4:0];
assign addr7 = vcount_char[7][4:0];
assign f_out = f_nxt;

endmodule


