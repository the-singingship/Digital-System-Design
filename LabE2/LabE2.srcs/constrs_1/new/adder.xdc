## Inputs - x mapped to SW0-SW5
set_property PACKAGE_PIN V17 [get_ports {x[0]}]
set_property PACKAGE_PIN V16 [get_ports {x[1]}]
set_property PACKAGE_PIN W16 [get_ports {x[2]}]
set_property PACKAGE_PIN W17 [get_ports {x[3]}]
set_property PACKAGE_PIN W15 [get_ports {x[4]}]
set_property PACKAGE_PIN V15 [get_ports {x[5]}]

## Inputs - y mapped to SW6-SW11
set_property PACKAGE_PIN W14 [get_ports {y[0]}]
set_property PACKAGE_PIN W13 [get_ports {y[1]}]
set_property PACKAGE_PIN V2 [get_ports {y[2]}]
set_property PACKAGE_PIN T3 [get_ports {y[3]}]
set_property PACKAGE_PIN T2 [get_ports {y[4]}]
set_property PACKAGE_PIN R3 [get_ports {y[5]}]

## sel (add/subtract) - SW12
set_property PACKAGE_PIN W2 [get_ports sel]

## Outputs - sum mapped to LD0-LD5
set_property PACKAGE_PIN U16 [get_ports {sum[0]}]
set_property PACKAGE_PIN E19 [get_ports {sum[1]}]
set_property PACKAGE_PIN U19 [get_ports {sum[2]}]
set_property PACKAGE_PIN V19 [get_ports {sum[3]}]
set_property PACKAGE_PIN W18 [get_ports {sum[4]}]
set_property PACKAGE_PIN U15 [get_ports {sum[5]}]

## c_out - LD6
set_property PACKAGE_PIN U14 [get_ports c_out]

## overflow - LD7

## I/O Standards
set_property IOSTANDARD LVCMOS33 [get_ports {x[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {x[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {y[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports sel]
set_property IOSTANDARD LVCMOS33 [get_ports {sum[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sum[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sum[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sum[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sum[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sum[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports c_out]

set_property PACKAGE_PIN V14 [get_ports overflow]
set_property IOSTANDARD LVCMOS33 [get_ports overflow]