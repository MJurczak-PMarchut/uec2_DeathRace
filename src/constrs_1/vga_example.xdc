# Constraints for CLK
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
#create_clock -name external_clock -period 10.00 [get_ports clk]

# Constraints for VS and HS
set_property PACKAGE_PIN R19 [get_ports {vs}]
set_property IOSTANDARD LVCMOS33 [get_ports {vs}]
set_property PACKAGE_PIN P19 [get_ports {hs}]
set_property IOSTANDARD LVCMOS33 [get_ports {hs}]

# Constraints for RED
set_property PACKAGE_PIN G19 [get_ports {r[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[0]}]
set_property PACKAGE_PIN H19 [get_ports {r[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[1]}]
set_property PACKAGE_PIN J19 [get_ports {r[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[2]}]
set_property PACKAGE_PIN N19 [get_ports {r[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {r[3]}]

# Constraints for GRN
set_property PACKAGE_PIN J17 [get_ports {g[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[0]}]
set_property PACKAGE_PIN H17 [get_ports {g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[1]}]
set_property PACKAGE_PIN G17 [get_ports {g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[2]}]
set_property PACKAGE_PIN D17 [get_ports {g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {g[3]}]

# Constraints for BLU
set_property PACKAGE_PIN N18 [get_ports {b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[0]}]
set_property PACKAGE_PIN L18 [get_ports {b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[1]}]
set_property PACKAGE_PIN K18 [get_ports {b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[2]}]
set_property PACKAGE_PIN J18 [get_ports {b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[3]}]

# Constraints for PCLK_MIRROR
#set_property PACKAGE_PIN J1 [get_ports {pclk_mirror}]
#set_property IOSTANDARD LVCMOS33 [get_ports {pclk_mirror}]

# Constraints for CFGBVS
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#constraints for Mouse
#set_property PACKAGE_PIN C17 [get_ports ps2_clk]
#set_property IOSTANDARD LVCMOS33 [get_ports ps2_clk]
#set_property PACKAGE_PIN B17 [get_ports ps2_data]
#set_property IOSTANDARD LVCMOS33 [get_ports ps2_data]
#set_property PULLUP true [get_ports ps2_clk] 
#set_property PULLUP true [get_ports ps2_data]


#set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
#set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
#set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
#set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
#set_property PACKAGE_PIN W15 [get_ports {sw[4]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
#set_property PACKAGE_PIN V15 [get_ports {sw[5]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
#set_property PACKAGE_PIN W14 [get_ports {sw[6]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
#set_property PACKAGE_PIN W13 [get_ports {sw[7]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
#set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
#set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
#set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
#set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
#set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
#set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
#set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
#set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
	
set_property PACKAGE_PIN U18 [get_ports rst]						
        set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN W19 [get_ports LEFT]						
    set_property IOSTANDARD LVCMOS33 [get_ports LEFT]
set_property PACKAGE_PIN T17 [get_ports RIGHT]                        
    set_property IOSTANDARD LVCMOS33 [get_ports RIGHT]
set_property PACKAGE_PIN U17 [get_ports START]						
    set_property IOSTANDARD LVCMOS33 [get_ports START]
set_property PACKAGE_PIN T18 [get_ports Restart]						
        set_property IOSTANDARD LVCMOS33 [get_ports Restart]
        
        
        
#set_property PACKAGE_PIN U16 [get_ports {LED[0]}]					
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
#set_property PACKAGE_PIN E19 [get_ports {LED[1]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
#set_property PACKAGE_PIN U19 [get_ports {LED[2]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
#set_property PACKAGE_PIN V19 [get_ports {LED[3]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
#set_property PACKAGE_PIN W18 [get_ports {LED[4]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
#set_property PACKAGE_PIN U15 [get_ports {LED[5]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
#set_property PACKAGE_PIN U14 [get_ports {LED[6]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
#set_property PACKAGE_PIN V14 [get_ports {LED[7]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]
#set_property PACKAGE_PIN V13 [get_ports {LED[8]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[8]}]
#set_property PACKAGE_PIN V3 [get_ports {LED[9]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[9]}]
#set_property PACKAGE_PIN W3 [get_ports {LED[10]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[10]}]
#set_property PACKAGE_PIN U3 [get_ports {LED[11]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[11]}]
#set_property PACKAGE_PIN P3 [get_ports {LED[12]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[12]}]
#set_property PACKAGE_PIN N3 [get_ports {LED[13]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[13]}]
#set_property PACKAGE_PIN P1 [get_ports {LED[14]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[14]}]
#set_property PACKAGE_PIN L1 [get_ports {LED[15]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {LED[15]}]
    
#Pmod Header JA
#Sch name = JA1
#set_property PACKAGE_PIN J1 [get_ports {ACK}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {ACK}]
#Sch name = JA2
#set_property PACKAGE_PIN L2 [get_ports {Controller_sel[1]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {Controller_sel[1]}]
#Sch name = JA3
#set_property PACKAGE_PIN J2 [get_ports {DATA}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {DATA}]
#Sch name = JA4
#set_property PACKAGE_PIN G2 [get_ports {CMD}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {CMD}]
#Sch name = JA7
#set_property PACKAGE_PIN H1 [get_ports {JA[4]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {JA[4]}]
#Sch name = JA8
#set_property PACKAGE_PIN K2 [get_ports {JA[5]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]
#Sch name = JA9
#set_property PACKAGE_PIN H2 [get_ports {Controller_sel[0]}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {Controller_sel[0]}]
#Sch name = JA10
#set_property PACKAGE_PIN G3 [get_ports {c_clk}]                    
#    set_property IOSTANDARD LVCMOS33 [get_ports {c_clk}]
    
#set_property PULLUP true [get_ports c_clk]
#set_property PULLUP true [get_ports Controller[0]]


#Pmod Header JXADC
#Sch name = XA1_P
set_property PACKAGE_PIN J3 [get_ports {vauxp6}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vauxp6}]
#Sch name = XA2_P
#set_property PACKAGE_PIN L3 [get_ports {vauxp14}]				
#	set_property IOSTANDARD LVCMOS33 [get_ports {vauxp14}]
#Sch name = XA3_P
set_property PACKAGE_PIN M2 [get_ports {vauxp7}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vauxp7}]
#Sch name = XA4_P
#set_property PACKAGE_PIN N2 [get_ports {vauxp15}]				
#	set_property IOSTANDARD LVCMOS33 [get_ports {vauxp15}]
#Sch name = XA1_N
set_property PACKAGE_PIN K3 [get_ports {vauxn6}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vauxn6}]
#Sch name = XA2_N
#set_property PACKAGE_PIN M3 [get_ports {vauxn14}]				
#	set_property IOSTANDARD LVCMOS33 [get_ports {vauxn14}]
#Sch name = XA3_N
set_property PACKAGE_PIN M1 [get_ports {vauxn7}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {vauxn7}]
#Sch name = XA4_N
#set_property PACKAGE_PIN N1 [get_ports {vauxn15}]				
#	set_property IOSTANDARD LVCMOS33 [get_ports {vauxn15}]

set_property PACKAGE_PIN J1 [get_ports {butt0}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {butt0}]
set_property PACKAGE_PIN J2 [get_ports {butt1}]				
        set_property IOSTANDARD LVCMOS33 [get_ports {butt1}]