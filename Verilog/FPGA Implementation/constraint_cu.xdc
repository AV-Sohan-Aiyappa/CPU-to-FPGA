
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {instruction[0]}]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {instruction[1]}]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports {instruction[2]}]
set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports {instruction[3]}]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports {instruction[4]}]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports {instruction[5]}]
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports {instruction[6]}]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports {instruction[7]}]
set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports {instruction[8]}]
set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports {instruction[9]}]
set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports {instruction[10]}]
set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports {instruction[11]}]
set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports {instruction[12]}]
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports {instruction[13]}]
set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33 } [get_ports {instruction[14]}]
set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports {instruction[15]}]



## ALU control
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports zx]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports nx]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports zy]
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports ny]
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports f]
set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports no]

## Mux select
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports selA]
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports selY]

## Destination controls
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports loadA]
set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports loadD]
set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports writeM]

## PC control
set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports loadPC]

