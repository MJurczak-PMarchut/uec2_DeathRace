vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../../../../../Desktop/Basys3-master/Projects/XADC_Demo/src/ip/xadc_wiz_0_1/xadc_wiz_0_funcsim.v" \


vlog -work xil_defaultlib \
"glbl.v"

