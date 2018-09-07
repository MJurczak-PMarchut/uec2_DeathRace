# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache C:/Users/pauli/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-5060-DESKTOP-6F3MM83/incrSyn
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/pauli/Documents/GitHub/uec2_DeathRace/vivado/DeathRace.cache/wt [current_project]
set_property parent.project_path C:/Users/pauli/Documents/GitHub/uec2_DeathRace/vivado/DeathRace.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/pauli/Documents/GitHub/uec2_DeathRace/vivado/DeathRace.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/verilog_macro_bus.vh
read_verilog -library xil_defaultlib {
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/Car_display.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/Game_Over_Text_Rom.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/Game_over_scr_ctl.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/Screen_mux.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/State_Master.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/Title_Screen.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/vivado/DeathRace.srcs/sources_1/new/adc.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/cardata.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/char_rom.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/char_rom_16x16.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/ip/clk_wiz_0/clk_wiz_0.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/collision.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/drawNumber.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/draw_background.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/draw_rect_char.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/font_rom.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/game_bg.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/gremlin.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/gremlin_rom.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/gremlins_position.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/headstone_rom.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/headstones.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/start_screen.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/vivado/DeathRace.srcs/sources_1/new/steerage.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/vga.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/vga_timing.v
  C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/sources_1/new/vga_example.v
}
read_ip -quiet C:/Users/pauli/Documents/GitHub/uec2_DeathRace/vivado/DeathRace.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0.xci
set_property used_in_implementation false [get_files -all c:/Users/pauli/Documents/GitHub/uec2_DeathRace/vivado/DeathRace.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/pauli/Documents/GitHub/uec2_DeathRace/vivado/DeathRace.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/constrs_1/vga_example.xdc
set_property used_in_implementation false [get_files C:/Users/pauli/Documents/GitHub/uec2_DeathRace/src/constrs_1/vga_example.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top vga_example -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef vga_example.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file vga_example_utilization_synth.rpt -pb vga_example_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]