// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 100 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output wire [`VGA_BUS_SIZE-1:0] vga_out,
  input wire pclk,
  output wire pclk_out
  );
  
    `VGA_OUT_REG
    `VGA_MERGE_AT_OUTPUT(vga_out)
 
  
  always @(posedge pclk) 
  begin 
    if (hcount_out == 1055)
        begin
              hblnk_out = 0;
              hcount_out = 0;
            
              if(vcount_out == 627) vcount_out = 0;
              else vcount_out = vcount_out + 1;
              
              if(vcount_out > 599) vblnk_out = 1'b1;
              else vblnk_out = 1'b0;
             
              if((vcount_out >= 600) & (vcount_out <= 603)) vsync_out = 1'b1;
              else vsync_out = 1'b0;
        end
     else
        begin
            hcount_out = hcount_out + 1;
            if (hcount_out >= 800) hblnk_out = 1'b1;
            else hblnk_out = 1'b0; 
            
            if( (hcount_out >= 840) & ( hcount_out <= 968)) hsync_out = 1'b1;
            else hsync_out = 1'b0;
        end 
        
        
        
  end
  
assign pclk_out = !(pclk);
  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.

endmodule
