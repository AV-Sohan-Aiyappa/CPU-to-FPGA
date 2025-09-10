## x[3:0]
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports {x[0]}]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports {x[1]}]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports {x[2]}]
set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports {x[3]}]

## y[3:0]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports {y[0]}]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports {y[1]}]
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports {y[2]}]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports {y[3]}]

## Control bits
set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports zx]
set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports nx]
set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports zy]
set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports ny]
set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports f]
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports no]

## -------------------------------
## LEDs → ALU Outputs
## -------------------------------

## ALU out[3:0]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports {out[0]}]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports {out[1]}]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports {out[2]}]
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports {out[3]}]

## Flags
set_property -dict { PACKAGE_PIN P1   IOSTANDARD LVCMOS33 } [get_ports zr]   ## zero flag
set_property -dict { PACKAGE_PIN L1   IOSTANDARD LVCMOS33 } [get_ports ng]   ## negative flag

