vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../../../../../../Desktop/Basys3-master/Projects/XADC_Demo/src/ip/xadc_wiz_0_1/xadc_wiz_0_funcsim.v" \


vlog -work xil_defaultlib \
"glbl.v"

