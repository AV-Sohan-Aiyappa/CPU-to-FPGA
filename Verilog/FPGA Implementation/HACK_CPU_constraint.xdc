## ========================================
## Basys 3 Constraints for HACK CPU 
## ========================================

## Clock signal (100 MHz)
set_property PACKAGE_PIN W5 [get_ports clk_100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100MHz]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_100MHz]

## Reset button (BTNU - Top button)
set_property PACKAGE_PIN T18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Center pushbutton (BTNC - Execute instruction)
set_property PACKAGE_PIN U18 [get_ports btnc]
set_property IOSTANDARD LVCMOS33 [get_ports btnc]

## Slide Switches (16 bits for instruction input)
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]

set_property PACKAGE_PIN V16 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]

set_property PACKAGE_PIN W16 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]

set_property PACKAGE_PIN W17 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]

set_property PACKAGE_PIN W15 [get_ports {sw[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]

set_property PACKAGE_PIN V15 [get_ports {sw[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]

set_property PACKAGE_PIN W14 [get_ports {sw[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]

set_property PACKAGE_PIN W13 [get_ports {sw[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]

set_property PACKAGE_PIN V2 [get_ports {sw[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]

set_property PACKAGE_PIN T3 [get_ports {sw[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]

set_property PACKAGE_PIN T2 [get_ports {sw[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]

set_property PACKAGE_PIN R3 [get_ports {sw[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]

set_property PACKAGE_PIN W2 [get_ports {sw[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]

set_property PACKAGE_PIN U1 [get_ports {sw[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]

set_property PACKAGE_PIN T1 [get_ports {sw[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]

set_property PACKAGE_PIN R2 [get_ports {sw[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]

## VGA Red pins (4 bits)
set_property PACKAGE_PIN G19 [get_ports {red[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {red[0]}]

set_property PACKAGE_PIN H19 [get_ports {red[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {red[1]}]

set_property PACKAGE_PIN J19 [get_ports {red[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {red[2]}]

set_property PACKAGE_PIN N19 [get_ports {red[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {red[3]}]

## VGA Green pins (4 bits)
set_property PACKAGE_PIN J17 [get_ports {green[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {green[0]}]

set_property PACKAGE_PIN H17 [get_ports {green[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {green[1]}]

set_property PACKAGE_PIN G17 [get_ports {green[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {green[2]}]

set_property PACKAGE_PIN D17 [get_ports {green[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {green[3]}]

## VGA Blue pins (4 bits)
set_property PACKAGE_PIN N18 [get_ports {blue[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {blue[0]}]

set_property PACKAGE_PIN L18 [get_ports {blue[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {blue[1]}]

set_property PACKAGE_PIN K18 [get_ports {blue[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {blue[2]}]

set_property PACKAGE_PIN J18 [get_ports {blue[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {blue[3]}]

## VGA Horizontal Sync
set_property PACKAGE_PIN P19 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports hsync]

## VGA Vertical Sync
set_property PACKAGE_PIN R19 [get_ports vsync]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]

## Configuration options
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
