// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 100 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.


`include "verilog_macro_bus.vh"

wire [`VGA_BUS_SIZE - 1 : 0] vga_bus [3:-1];
wire [`MOUSE_BUS_SIZE - 1 : 0] mouse_bus [1:0] ;


module vga_example (
  inout wire ps2_data,
  inout wire ps2_clk,
  input wire clk,
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror
  );

  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.

  wire clk_in;
  wire locked;
  wire clk_fb;
  wire clk_ss;
  wire clk_out;
  wire pclk;
  wire pclk100;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg [7:0] safe_start = 0;
/*
  IBUF clk_ibuf (.I(clk),.O(clk_in));

  MMCME2_BASE #(
    .CLKIN1_PERIOD(10.000),
    .CLKFBOUT_MULT_F(10.000),
    .CLKOUT0_DIVIDE_F(25.000))
  clk_in_mmcme2 (
    .CLKIN1(clk_in),
    .CLKOUT0(clk_out),
    .CLKOUT0B(),
    .CLKOUT1(),
    .CLKOUT1B(),
    .CLKOUT2(),
    .CLKOUT2B(),
    .CLKOUT3(),
    .CLKOUT3B(),
    .CLKOUT4(),
    .CLKOUT5(),
    .CLKOUT6(),
    .CLKFBOUT(clkfb),
    .CLKFBOUTB(),
    .CLKFBIN(clkfb),
    .LOCKED(locked),
    .PWRDWN(1'b0),
    .RST(1'b0)
  );

  BUFH clk_out_bufh (.I(clk_out),.O(clk_ss));
  always @(posedge clk_ss) safe_start<= {safe_start[6:0],locked};

  BUFGCE clk_out_bufgce (.I(clk_out),.CE(safe_start[7]),.O(pclk));

  // Mirrors pclk on a pin for use by the testbench;
  // not functionally required for this design to work.
*/

clk_wiz_0 myClk(
    .clk_out1(pclk100),
    .clk_in1(clk),
    .locked(locked),
    .clk_out2(pclk),
    .reset(1'b0)
);





  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );

  // Instantiate the vga_timing module, which is
  // the module you are designing for this lab.

  wire [11:0] rgb_rom,address;
  
  
  
  MouseDisplayVeri myCoursor(
    .pclk(pclk),
    .mouse_in(mouse_bus[0]),
    .vga_in(vga_bus[0]),
    .vga_out(vga_bus[1])
  );
/*
    image_rom my_rom(
        .clk(!pclk),
        .address(address),
        .rgb(rgb_rom)
    
    );
    */
/*
draw_rect_ctl My_rect_ctl(  
    .clk(pclk),
    .mouse_in(mouse_bus[0]),
    .mouse_out(mouse_bus[1]),
    .vsync(vga_bus[-1][35])
);
*/

  MouseCtlVeri myMouse(
    .clk(pclk100),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .mouse_out(mouse_bus[0])
  );

  vga_timing my_timing (
    .vga_out(vga_bus[-1]),
    .pclk(pclk)
  );
  
  start_screen my_screen(
    .vga_in(vga_bus[-1]),
    .pclk(pclk),
    .vga_out(vga_bus[0])
    );
  
  /*  
    draw_rect my_rect(
        .mouse_in(mouse_bus[1]),
        .vga_in(vga_bus[0]),
        .pclk(pclk),
        .vga_out(vga_bus[1]),
        .rgb_rom(rgb_rom),
        .address(address)
    );
    */
       
 `VGA_SPLIT_INPUT(vga_bus[1])
    

  // This is a simple test pattern generator.
  
  always @(posedge pclk)
  begin
    vs <= vsync_in;
    hs <= hsync_in;
    {r,g,b} <= rgb_in;
  end

endmodule
