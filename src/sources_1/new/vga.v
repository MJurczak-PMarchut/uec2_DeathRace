// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 100 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.


`include "verilog_macro_bus.vh"

module vga (
//  inout wire ps2_data,
//  inout wire ps2_clk,
  input wire [`VGA_BUS_SIZE-1:0] vga_in,
  input wire clk,
  input wire [15:0] sw,
  input wire NoOfPlayers,
  output wire [`VGA_BUS_SIZE-1:0] vga_out,
  output wire TimeOut,
  input wire rst
    );

wire [`VGA_BUS_SIZE - 1 : 0] vga_bus [6:-1];
wire [`MOUSE_BUS_SIZE - 1 : 0] mouse_bus [1:0] ;


  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.


wire [11:0] rgb;
wire Car1Enable,Car2Enable;
wire [3:0] rgb_back;

wire [6:0] char_code;
wire [7:0] char_line_pixels;  
wire [7:0] char_xy;
wire [3:0] char_line;
//wire [23:0] grem0, grem1; 


 `VGA_SPLIT_INPUT(vga_bus[5])
  wire Title_Sel,Wait_for_Game,Time_out,GameOn,Highscore,dual,single;

  
  
Car_display #(.Color(3'b110),.X(500),.Y(500)) MyCar(
    .clk(clk),
    .direction(sw[3:0]),
    .enable(Car1Enable),
    .go(sw[5]),
    .vga_in(vga_in),
    .vga_out(vga_bus[0]),
    .rst(!rst)
);
Car_display #(.X(300),.Y(500),.Color(3'b100)) MyCar2(
    
    .clk(clk),
    .direction(sw[9:6]),
    .enable(Car2Enable),
    .go(sw[11]),
    .vga_in(vga_bus[0]),
    .vga_out(vga_bus[1]),
    .rst(!rst)
);

     
game_bg Game_bg(
    .clk(clk),
    .Player1Score(8'hf),
    .Player2Score({4'b0,sw[15:12]}),
    .vga_in(vga_bus[1]),
    .vga_out(vga_bus[2]),
    .rst(!rst),
    .TimeOut(TimeOut),
    .NoOfPlayers(NoOfPlayers)
    
);  

Game_over_scr_ctl GOSC(
    .TimeOut(TimeOut),
    .NoOfPlayers(NoOfPlayers),
    .Player1Score(8'hf),
    .Player2Score({4'b0,sw[15:12]}),
    .vga_in(vga_bus[2]),
    .GremlinsEnable(),
    .Car1Enable(Car1Enable),
    .Car2Enable(Car2Enable),
    .vga_out(vga_out)
);



endmodule
