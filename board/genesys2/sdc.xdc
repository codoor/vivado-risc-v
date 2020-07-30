# SDIO
set_property -dict { PACKAGE_PIN R28   IOSTANDARD LVCMOS33 IOB TRUE } [get_ports { sdio_clk }];
set_property -dict { PACKAGE_PIN R29   IOSTANDARD LVCMOS33 IOB TRUE } [get_ports { sdio_cmd }];
set_property -dict { PACKAGE_PIN R26   IOSTANDARD LVCMOS33 IOB TRUE } [get_ports { sdio_dat[0] }];
set_property -dict { PACKAGE_PIN R30   IOSTANDARD LVCMOS33 IOB TRUE } [get_ports { sdio_dat[1] }];
set_property -dict { PACKAGE_PIN P29   IOSTANDARD LVCMOS33 IOB TRUE } [get_ports { sdio_dat[2] }];
set_property -dict { PACKAGE_PIN T30   IOSTANDARD LVCMOS33 IOB TRUE } [get_ports { sdio_dat[3] }];
set_property -dict { PACKAGE_PIN AE24  IOSTANDARD LVCMOS33 } [get_ports { sdio_reset }];
set_property -dict { PACKAGE_PIN P28   IOSTANDARD LVCMOS33 } [get_ports { sdio_cd }];

set sdio_clock [get_clocks -of_objects [get_pins -hier clk_wiz_1/clk_out1]]
set main_clock [get_clocks -of_objects [get_pins -hier clk_wiz_0/clk_out1]]

set_clock_groups -asynchronous -group $sdio_clock -group $main_clock

set_max_delay -from $main_clock -to $sdio_clock -datapath_only 8.0
set_max_delay -from $sdio_clock -to $main_clock -datapath_only 8.0

set_max_delay -from $sdio_clock -to [get_ports sdio_*] -datapath_only 10.0
set_max_delay -from [get_ports sdio_cmd] -to $sdio_clock -datapath_only 10.0
set_max_delay -from [get_ports sdio_dat*] -to $sdio_clock -datapath_only 10.0
set_max_delay -from [get_ports sdio_cd] -to $sdio_clock -datapath_only 10.0

set_false_path -through [get_pins -hier SD/async_resetn]
set_false_path -through [get_pins -hier SD/interrupt]
