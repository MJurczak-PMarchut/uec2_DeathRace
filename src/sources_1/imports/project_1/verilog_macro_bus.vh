`ifndef _vga_macro
`define _vga_macro

`define VGA_BUS_SIZE 38
`define RGB_BUS_SIZE 12
`define HCOUNT_BUS_SIZE 11
`define VCOUNT_BUS_SIZE 11

`define MOUSE_BUS_SIZE 25
`define XPOS_BUS_SIZE 12 
`define YPOS_BUS_SIZE 12
`define LEFT_BIT 24
`define XPOS_BITS 11:0
`define YPOS_BITS 23:12


`define MOUSE_SPLIT_INPUT(BUS_NAME) \
    wire left_in = BUS_NAME[`LEFT_BIT];\
    wire [`XPOS_BUS_SIZE-1:0] xpos_in = BUS_NAME[`XPOS_BITS];\
    wire [`YPOS_BUS_SIZE-1:0] ypos_in = BUS_NAME[`YPOS_BITS];
    
`define MOUSE_OUT_REG \
        reg left_out;\
        reg [`XPOS_BUS_SIZE-1:0] xpos_out;\
        reg [`YPOS_BUS_SIZE-1:0] ypos_out;
        
`define MOUSE_OUT_WIRE \
                wire left_out;\
                wire [`XPOS_BUS_SIZE-1:0] xpos_out;\
                wire [`YPOS_BUS_SIZE-1:0] ypos_out;
        
        
 `define MOUSE_MERGE_AT_OUTPUT(BUS_NAME) \
           assign BUS_NAME[`LEFT_BIT] = left_out;\
           assign BUS_NAME[`XPOS_BITS] = xpos_out;\
           assign BUS_NAME[`YPOS_BITS] = ypos_out;
//VGA BUS COMPONENTS

`define VGA_HB_BIT  37
`define VGA_VB_BIT  36
`define VGA_VS_BIT  35
`define VGA_HS_BIT  34
`define VGA_RGB_BITS 33:22
`define VGA_HCOUNT_BITS 21:11
`define VGA_VCOUNT_BITS 10:0

`define VGA_SPLIT_INPUT(BUS_NAME) \
    wire hblnk_in = BUS_NAME[`VGA_HB_BIT];\
    wire vblnk_in = BUS_NAME[`VGA_VB_BIT];\
    wire vsync_in = BUS_NAME[`VGA_VS_BIT];\
    wire hsync_in = BUS_NAME[`VGA_HS_BIT];\
    wire [`RGB_BUS_SIZE - 1 : 0] rgb_in = BUS_NAME[`VGA_RGB_BITS];\
    wire [`HCOUNT_BUS_SIZE - 1 : 0] hcount_in = BUS_NAME[`VGA_HCOUNT_BITS];\
    wire [`VCOUNT_BUS_SIZE - 1 : 0] vcount_in = BUS_NAME[`VGA_VCOUNT_BITS];
    
 `define VGA_OUT_WIRE \
    wire hblnk_out;\
    wire vblnk_out;\
    wire vsync_out;\
    wire hsync_out;\
    wire [`HCOUNT_BUS_SIZE - 1 : 0] hcount_out;\
    wire [`VCOUNT_BUS_SIZE - 1 : 0] vcount_out;\
    wire [`RGB_BUS_SIZE - 1 : 0] rgb_out;
 
 `define VGA_OUT_REG \
    reg hblnk_out;\
    reg vblnk_out;\
    reg vsync_out;\
    reg hsync_out;\
    reg [`HCOUNT_BUS_SIZE - 1 : 0] hcount_out;\
    reg [`VCOUNT_BUS_SIZE - 1 : 0] vcount_out;\
    reg [`RGB_BUS_SIZE - 1 : 0] rgb_out;
    
 `define VGA_MERGE_AT_OUTPUT(BUS_NAME) \
    assign BUS_NAME[`VGA_VB_BIT] = vblnk_out;\
    assign BUS_NAME[`VGA_HB_BIT] = hblnk_out;\
    assign BUS_NAME[`VGA_HS_BIT] = hsync_out;\
    assign BUS_NAME[`VGA_VS_BIT] = vsync_out;\
    assign BUS_NAME[`VGA_RGB_BITS] = rgb_out;\
    assign BUS_NAME[`VGA_HCOUNT_BITS] = hcount_out;\
    assign BUS_NAME[`VGA_VCOUNT_BITS] = vcount_out;   
    

`endif
