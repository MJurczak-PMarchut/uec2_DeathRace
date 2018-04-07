// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 100 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.


`include "verilog_macro_bus.vh"

wire [`VGA_BUS_SIZE - 1 : 0] VGA_BUS;


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

wire [7:0] data;

clk_wiz_0 myClk(
    .clk_out1(pclk100),
    .clk_in1(clk),
    .locked(locked),
    .clk_out2(pclk),
    .reset(1'b0)
);

Keyboard my_keyboard(

    .CLK(pclk100),
    .PS2_CLK(ps2_clk),
    .PS2_DATA(ps2_data),
    .LED(data)

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

  wire [10:0] vcount, hcount,vcount_draw,hcount_draw,vcount_rect,hcount_rect;
  wire vsync, hsync, vsync_draw, hsync_draw, vsync_rect, hsync_rect,vsync_coursor,hsync_coursor;
  wire vblnk, hblnk,vblnk_draw,hblnk_draw,vblnk_rect,hblnk_rect;
  wire pclk_timing,pclk_draw,left;
  wire [11:0] rgb_draw, rgb_rect,rgb_mouse,rgb_rom,address;
  wire [11:0] ypos, xpos,ypos_out,xpos_out;
  
  
  
  MouseDisplay myCoursor(
    .xpos(xpos),
    .ypos(ypos),
    .hblank(hblnk_rect),
    .vblank(vblnk_rect),
    .red_in(rgb_rect[3:0]),
    .green_in(rgb_rect[7:4]),
    .blue_in(rgb_rect[11:8]),
    .red_out(rgb_mouse[3:0]),
    .green_out(rgb_mouse[7:4]),
    .blue_out(rgb_mouse[11:8]),
    .pixel_clk(pclk),
    .hcount(hcount_rect),
    .vcount(vcount_rect),
    .vsync_out(vsync_coursor),
    .hsync_out(hsync_coursor),
    .hsync_in(hsync_rect),
    .vsync_in(vsync_rect)
  );


draw_rect_ctl My_rect_ctl(  
    .clk(pclk),
    .xpos(xpos),
    .ypos(ypos),
    .ypos_out(ypos_out),
    .xpos_out(xpos_out),
  //  .left_button(left),
    .vsync(vsync),
    .data(data)


);


  /*
  MouseCtl myMouse(
    .clk(pclk100),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .xpos(xpos),
    .ypos(ypos),
    .left(left)
  );
*/
  vga_timing my_timing (
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk_out(pclk_timing),
    .pclk(pclk)
  );
  
  draw_background my_background(
    .hcount_in(hcount),
    .vcount_in(vcount),
    .hsync_in(hsync),
    .hblnk_in(hblnk),
    .vblnk_in(vblnk),
    .vsync_in(vsync),
    .pclk(pclk),
    .vsync_out(vsync_draw),
    .hsync_out(hsync_draw),
    .rgb_out(rgb_draw),
    .hcount_out(hcount_draw),
    .vcount_out(vcount_draw),
    .pclk_out(pclk_draw),
    .hblnk_out(hblnk_draw),
    .vblnk_out(vblnk_draw)
    );
    
    draw_rect my_rect(
        .xpos(xpos_out),
//        .left(left),
        .ypos(ypos_out),
        .rgb_in(rgb_draw),
        .hcount_in(hcount_draw),
        .vcount_in(vcount_draw),
        .hsync_in(hsync_draw),
        .hblnk_in(hblnk_draw),
        .vblnk_in(vblnk_draw),
        .vsync_in(vsync_draw),
        .pclk(pclk),
        .vsync_out(vsync_rect),
        .hsync_out(hsync_rect),
        .rgb_out(rgb_rect),
        .hcount_out(hcount_rect),
        .vcount_out(vcount_rect)
//        .rgb_rom(rgb_rom),
//        .address(address)
    );
    

    

  // This is a simple test pattern generator.
  
  always @(posedge pclk)
  begin
  vs <= vsync_coursor;
  hs <= hsync_coursor;
  {r,g,b} <= rgb_mouse;
  end

endmodule
