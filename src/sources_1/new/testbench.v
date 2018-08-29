// File: testbench.v
// This is a top level testbench for the
// vga_example design, which is part of
// the EE178 Lab #4 assignment.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 100 ps

module testbench;

  // Declare wires to be driven by the outputs
  // of the design, and regs to drive the inputs.
  // The testbench will be in control of inputs
  // to the design, and will check the outputs.
  // Then, instantiate the design to be tested.

  reg clk;

  // Instantiate the vga_example module.
  

  // Instantiate the tiff_writer module.

//  tiff_writer my_writer (
//    .pclk_mirror(pclk_mirror),
//    .r({r,r}), // fabricate an 8-bit value
//    .g({g,g}), // fabricate an 8-bit value
//    .b({b,b}), // fabricate an 8-bit value
//    .go(vs),
//    .xdim(16'd1056),
//    .ydim(16'd628)
//  );

  // Describe a process that generates a clock
  // signal. The clock is 100 MHz.

reg [20:0] c_count = 0;
  always
  begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
    c_count = c_count +1;
  end
  
wire [21:0] address;
  wire [11:0] rgb;
  wire [23:0] gremlin0, gremlin1;
  wire gremlin0_enable, gremlin1_enable;
  wire [21:0] car0_address, car1_address;
  wire [7:0] Player1Score, Player2Score;




  collision my_collisions(
    .clk(clk),
    .grem0(gremlin0),
    .grem1(gremlin1),
    .car0({11'h40,11'h40}),
    .car1({11'h40,11'h80}),
    .grem0_out(gremlin0_enable),
    .grem1_out(gremlin1_enable),
    .points0_out(Player1Score),
    .points1_out(Player2Score)
  );

   assign gremlin0= (c_count >= 50)? {1'b1,11'h42,11'h43,1'b1}:
   (c_count >= 30)?{1'b1,11'h42,11'h43,1'b0}:{1'b1,11'h80,11'h80,1'b1};
   
   assign gremlin1= (c_count >= 50)? {1'b1,11'h82,11'h83,1'b1}:
      (c_count >= 30)?{1'b1,11'h82,11'h83,1'b0}:{1'b1,11'h40,11'h40,1'b1};
  
endmodule
