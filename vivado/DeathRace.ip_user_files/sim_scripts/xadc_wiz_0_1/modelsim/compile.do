vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../../../../../Desktop/Basys3-master/Projects/XADC_Demo/src/ip/xadc_wiz_0_1/xadc_wiz_0_funcsim.v" \


vlog -work xil_defaultlib \
"glbl.v"

