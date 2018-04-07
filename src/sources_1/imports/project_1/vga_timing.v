// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 100 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output reg [10:0] vcount = 0,
  output reg vsync = 0,
  output reg vblnk = 0,
  output reg [10:0] hcount = 0,
  output reg hsync,
  output reg hblnk,
  input wire pclk,
  output wire pclk_out
  );
  
  
  
  always @(posedge pclk) 
  begin 
    if (hcount == 1055)
        begin
              hblnk = 0;
              hcount = 0;
            
              if(vcount == 627) vcount = 0;
              else vcount = vcount + 1;
              
              if(vcount > 599) vblnk = 1'b1;
              else vblnk = 1'b0;
             
              if((vcount >= 600) & (vcount <= 603)) vsync = 1'b1;
              else vsync = 1'b0;
        end
     else
        begin
            hcount = hcount + 1;
            if (hcount >= 800) hblnk = 1'b1;
            else hblnk = 1'b0; 
            
            if( (hcount >= 840) & ( hcount <= 968)) hsync = 1'b1;
            else hsync = 1'b0;
        end 
        
        
        
  end
  
assign pclk_out = !(pclk);
  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.

endmodule
