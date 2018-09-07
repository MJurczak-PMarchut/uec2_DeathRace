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
  input wire go0, go1,
  input wire [7:0] direction,
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

wire [23:0] gremlin0, gremlin1;
wire gremlin0_enable, gremlin1_enable;
wire [21:0] car0_address, car1_address;
wire [7:0] Player1Score, Player2Score;

 `VGA_SPLIT_INPUT(vga_bus[5])
  wire Title_Sel,Wait_for_Game,Time_out,GameOn,Highscore,dual,single;

  collision my_collisions(
    .clk(clk),
    .rst(!rst),
    .TimeOut(TimeOut),
    .car0_enable(Car1Enable),
    .car1_enable(Car2Enable),
    .vga_in(vga_in),
    .vga_out(vga_bus[-1]),
    .grem0(gremlin0),
    .grem1(gremlin1),
    .car0(car0_address),
    .car1(car1_address),
    .grem0_out(gremlin0_enable),
    .grem1_out(gremlin1_enable),
    .points0_out(Player1Score),
    .points1_out(Player2Score)
  );

  gremlins_position my_gremlins(
    .vga_in(vga_bus[-1]),
    .vga_out(vga_bus[0]),
    .clk(clk),
    .grem0_enable(gremlin0_enable),
    .grem1_enable(gremlin1_enable),
    .grem0_out(gremlin0),
    .grem1_out(gremlin1)
  );  
  
Car_display #(.Color(3'b100),.X(300),.Y(500)) MyCar(
    .clk(clk),
    .direction(direction[7:4]),
    .enable(Car1Enable),
    .go(go0),
    .vga_in(vga_bus[0]),
    .vga_out(vga_bus[1]),
    .rst(!rst),
    .xpos(car0_address[21:11]),
    .ypos(car0_address[10:0])
);
Car_display #(.X(500),.Y(500),.Color(3'b011)) MyCar2(
    
    .clk(clk),
    .direction(direction[3:0]),
    .enable(Car2Enable),
    .go(go1),
    .vga_in(vga_bus[1]),
    .vga_out(vga_bus[2]),
    .rst(!rst),
    .xpos(car1_address[21:11]),
    .ypos(car1_address[10:0])
);

     
game_bg Game_bg(
    .clk(clk),
    .Player1Score(Player1Score),
    .Player2Score(Player2Score),
    .vga_in(vga_bus[2]),
    .vga_out(vga_bus[3]),
    .rst(!rst),
    .TimeOut(TimeOut),
    .NoOfPlayers(NoOfPlayers)
    
);  

Game_over_scr_ctl GOSC(
    .TimeOut(TimeOut),
    .NoOfPlayers(NoOfPlayers),
    .Player1Score(Player1Score),
    .Player2Score(Player2Score),
    .vga_in(vga_bus[3]),
    .GremlinsEnable(),
    .Car1Enable(Car1Enable),
    .Car2Enable(Car2Enable),
    .vga_out(vga_out)
);



endmodule
