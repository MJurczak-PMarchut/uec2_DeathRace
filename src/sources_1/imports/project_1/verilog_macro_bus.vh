`ifndef _vga_macro
`define _vga_macro

`define VGA_BUS_SIZE 38
`define RGB_BUS_SIZE 12
`define HCOUNT_BUS_SIZE 11
`define VCOUNT_BUS_SIZE 11


//VGA BUS COMPONENTS

`define VGA_HB_BIT  37
`define VGA_VB_BIT  36
`define VGA_VS_BIT  35
`define VGA_HS_BIT  34
`define VGA_RGB_BITS 33:22
`define VGA_HCOUNT_BITS 21:11
`define VGA_VCOUNT_BITS 10:0

`define VGA_SPLIT_INPUT(BUS_NAME) \
    wire input hb_in = BUS_NAME[`VGA_HB_BIT];\
    wire input vb_in = BUS_NAME[`VGA_VB_BIT];\
    wire input vs_in = BUS_NAME[`VGA_VS_BIT];\
    wire input hs_in = BUS_NAME[`VGA_HS_BIT];\
    wire input [`RGB_BUS_SIZE - 1 : 0] rgb_in = BUS_NAME[`VGA_RGB_BITS];\
    wire input [`HCOUNT_BUS_SIZE - 1 : 0] hcount_in = BUS_NAME[`VGA_HCOUNT_BITS];\
    wire input [`VCOUNT_BUS_SIZE - 1 : 0] vcount_in = BUS_NAME[`VGA_VCOUNT_BITS];
    
 `define VGA_OUT_WIRE \
    wire output hb_out;\
    wire output vb_out;\
    wire output vs_out;\
    wire output hs_out;\
    wire output [`HCOUNT_BUS_SIZE - 1 : 0] hcount_out;\
    wire output [`VCOUNT_BUS_SIZE - 1 : 0] vcount_out;\
    wire output [`RGB_BUS_SIZE - 1 : 0] rgb_out;
 
 `define VGA_OUT_REG \
    reg output hb_out;\
    reg output vb_out;\
    reg output vs_out;\
    reg output hs_out;\
    reg output [`HCOUNT_BUS_SIZE - 1 : 0] hcount_out;\
    reg output [`VCOUNT_BUS_SIZE - 1 : 0] vcount_out;\
    reg output [`RGB_BUS_SIZE - 1 : 0] rgb_out;
    
 `define VGA_MERGE_AT_OUTPUT(BUS_NAME) \
    assign BUS_NAME[`VGA_VB_BIT] = vb_out;\
    assign BUS_NAME[`VGA_HB_BIT] = hb_out;\
    assign BUS_NAME[`VGA_HS_BIT] = hs_out;\
    assign BUS_NAME[`VGA_VS_BIT] = vs_out;\
    assign BUS_NAME[`VGA_RGB_BITS] = rgb_out;\
    assign BUS_NAME[`VGA_HCOUNT_BITS] = hcount_out;\
    assign BUS_NAME[`VGA_VCOUNT_BITS] = vcount_out;   
    

`endif
