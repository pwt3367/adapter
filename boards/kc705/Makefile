project_name := nettlp-adapter
device_name := xc7k325t-2-ffg900

HW_SERVER := hw_server

build_dir := build
rtl_dir := rtl
test_dir := test
ip_dir := ip
tcl_dir := build-scripts
xdc_dir := xdc
cores_dir := ../../cores

PKG_SRC += $(cores_dir)/pkg/endian_pkg.sv
PKG_SRC += $(cores_dir)/pkg/utils_pkg.sv
PKG_SRC += $(cores_dir)/pkg/ethernet_pkg.sv
PKG_SRC += $(cores_dir)/pkg/ip_pkg.sv
PKG_SRC += $(cores_dir)/pkg/udp_pkg.sv
PKG_SRC += $(cores_dir)/pkg/pcie_tlp_pkg.sv
PKG_SRC += $(cores_dir)/pkg/pcie_tcap_pkg.sv
PKG_SRC += $(cores_dir)/pkg/nettlp_cmd_pkg.sv
PKG_SRC += $(cores_dir)/pkg/pciecfg_pkg.sv
PKG_SRC += $(cores_dir)/pkg/nettlp_pkg.sv

RTL_SRC += $(cores_dir)/mybram/mybram.sv
RTL_SRC += $(cores_dir)/clk_sync/clk_sync.sv
RTL_SRC += $(cores_dir)/clk_sync/clk_sync_ashot.sv
RTL_SRC += $(rtl_dir)/nettlp_cmd/nettlp_cmd_core.sv
RTL_SRC += $(rtl_dir)/nettlp_cmd/nettlp_cmd.sv
RTL_SRC += $(rtl_dir)/pciecfg/pciecfg_core.sv
RTL_SRC += $(rtl_dir)/pciecfg/pciecfg.sv
RTL_SRC += $(rtl_dir)/eth/eth_pcspma_conf.sv
RTL_SRC += $(rtl_dir)/eth/eth_mac_conf.sv
RTL_SRC += $(rtl_dir)/eth/eth_top.sv
RTL_SRC += $(rtl_dir)/eth_encap/eth_encap_core.sv
RTL_SRC += $(rtl_dir)/eth_encap/pcie2fifo.sv
RTL_SRC += $(rtl_dir)/eth_encap/eth_encap.sv
RTL_SRC += $(rtl_dir)/eth_decap/eth_decap_core.sv
RTL_SRC += $(rtl_dir)/eth_decap/fifo2pcie.sv
RTL_SRC += $(rtl_dir)/eth_decap/tlp_tx_mux.sv
RTL_SRC += $(rtl_dir)/eth_decap/eth_decap.sv
RTL_SRC += $(rtl_dir)/pcie_pio_app/pcie_rx_filter.sv
RTL_SRC += $(rtl_dir)/pcie_pio_app/pcie_top.sv
RTL_SRC += $(rtl_dir)/top.sv

RTL_SRC_NOSIM += $(rtl_dir)/pcie_pio_app/pcie_mem_access.sv
RTL_SRC_NOSIM += $(rtl_dir)/clock_control/clock_control.v
RTL_SRC_NOSIM += $(rtl_dir)/clock_control/clock_control_program.v
RTL_SRC_NOSIM += $(rtl_dir)/clock_control/kcpsm6.v
RTL_SRC_NOSIM += $(build_dir)/$(rtl_dir)/pcie_pio/PIO.v
RTL_SRC_NOSIM += $(build_dir)/$(rtl_dir)/pcie_pio/PIO_EP.v
RTL_SRC_NOSIM += $(build_dir)/$(rtl_dir)/pcie_pio/PIO_RX_ENGINE.v
RTL_SRC_NOSIM += $(build_dir)/$(rtl_dir)/pcie_pio/PIO_TO_CTRL.v
RTL_SRC_NOSIM += $(build_dir)/$(rtl_dir)/pcie_pio/PIO_TX_ENGINE.v
RTL_SRC_NOSIM += $(build_dir)/$(rtl_dir)/pcie_pio/pcie_app_7x.v
RTL_SRC_NOSIM += $(build_dir)/$(rtl_dir)/pcie_pio/pcie_7x_pipe_clock.v
RTL_SRC_NOSIM += $(build_dir)/$(rtl_dir)/pcie_pio/pcie_7x_support.v


XDC_SRC += $(xdc_dir)/nettlp-kc705.xdc

TCL_SRC += $(tcl_dir)/vivado_createprj.tcl
TCL_SRC += $(tcl_dir)/vivado_synth.tcl
TCL_SRC += $(tcl_dir)/vivado_place.tcl
TCL_SRC += $(tcl_dir)/vivado_route.tcl
TCL_SRC += $(tcl_dir)/vivado_bitstream.tcl

IP_SRC += $(ip_dir)/ila_0/ila_0.tcl
IP_SRC += $(ip_dir)/pcie_afifo/pcie_afifo.tcl
IP_SRC += $(ip_dir)/eth_afifo/eth_afifo.tcl
IP_SRC += $(ip_dir)/fifo_nettlp_cmd/fifo_nettlp_cmd.tcl
IP_SRC += $(ip_dir)/fifo_pciecfg_in/fifo_pciecfg_in.tcl
IP_SRC += $(ip_dir)/fifo_pciecfg_out/fifo_pciecfg_out.tcl
IP_SRC += $(ip_dir)/axi_10g_ethernet_0/axi_10g_ethernet_0.tcl
IP_SRC += $(ip_dir)/pcie_7x/pcie_7x.tcl

SIM_SRC += $(test_dir)/graycounter.v
SIM_SRC += $(test_dir)/asfifo.v
SIM_SRC += $(test_dir)/pcie_afifo.sv
SIM_SRC += $(test_dir)/eth_afifo.sv
SIM_SRC += $(test_dir)/fifo_nettlp_cmd.sv
SIM_SRC += $(test_dir)/fifo_pciecfg_in.sv
SIM_SRC += $(test_dir)/fifo_pciecfg_out.sv
SIM_SRC += $(test_dir)/BUFG.sv
SIM_SRC += $(test_dir)/IBUF.sv
SIM_SRC += $(test_dir)/IBUFDS.sv
SIM_SRC += $(test_dir)/IBUFDS_GTE2.sv
SIM_SRC += $(test_dir)/IBUFDS_GTE4.sv
SIM_SRC += $(test_dir)/OBUF.sv
SIM_SRC += $(test_dir)/device/device_eth.sv
SIM_SRC += $(test_dir)/axi_10g_ethernet_0.sv
SIM_SRC += $(test_dir)/clock_control.sv
SIM_SRC += $(test_dir)/pcie_7x_support.v
SIM_SRC += $(test_dir)/pcie_app_7x.v
SIM_SRC += $(test_dir)/ila_0.sv

TARGET := $(build_dir)/$(project_name)

.PHONY: all
all: $(TARGET)

XCIS := $(addprefix $(build_dir)/,$(patsubst %.tcl,%.xci,$(IP_SRC)))

$(TARGET): $(XCIS) pio bitstream
	@echo "Done."

$(build_dir)/%.xci: %.tcl
	@if [ ! -e $(build_dir)/$(ip_dir) ]; then mkdir -p $(build_dir)/$(ip_dir); fi
	@if [ ! -e $(dir $@) ]; then cp -r $(dir $<) $(dir $@); fi
	make -C $(dir $@)

pio: $(build_dir)/$(rtl_dir)/pcie_pio
$(build_dir)/$(rtl_dir)/pcie_pio: $(XCIS)
	@if [ ! -e $(build_dir)/$(rtl_dir) ]; then mkdir -p $(build_dir)/$(rtl_dir); fi
	cp -R $(build_dir)/ip/pcie_7x/pcie_pio $(build_dir)/$(rtl_dir)/

lint:
	verilator -Wall --lint-only -Wno-PINCONNECTEMPTY --top-module testbench -sv $(PKG_SRC) test/testbench.sv $(SIM_SRC) $(RTL_SRC)

sim:
	verilator -Wall -Wno-PINCONNECTEMPTY --cc --trace --exe test/sim_main.cpp --top-module testbench -sv $(PKG_SRC) test/testbench.sv $(SIM_SRC) $(RTL_SRC)
	make -j -C obj_dir -f Vtestbench.mk Vtestbench
	obj_dir/Vtestbench

prj: $(project_name).xpr
$(project_name).xpr: $(XCIS)
	vivado -mode batch -source $(tcl_dir)/vivado_createprj.tcl -log $(build_dir)/createprj_log.txt -nojournal -tempDir $(build_dir) -tclargs $(project_name) $(build_dir) $(device_name) "$(PKG_SRC) $(RTL_SRC) $(RTL_SRC_NOSIM)" "$(XCIS)" "$(XDC_SRC)"

synth: $(build_dir)/post_syn.dcp
$(build_dir)/post_syn.dcp:
	vivado -mode batch -source $(tcl_dir)/vivado_synth.tcl -log $(build_dir)/syn_log.txt -nojournal -tempDir $(build_dir) -tclargs $(project_name) $(build_dir) $(device_name) "$(PKG_SRC) $(RTL_SRC) $(RTL_SRC_NOSIM)" "$(XCIS)" "$(XDC_SRC)"

place: $(build_dir)/post_place.dcp
$(build_dir)/post_place.dcp: $(build_dir)/post_syn.dcp
	vivado -mode batch -source $(tcl_dir)/vivado_place.tcl -log $(build_dir)/place_log.txt -nojournal -tempDir $(build_dir) -tclargs $(project_name) $(build_dir)

route: $(build_dir)/post_route.dcp
$(build_dir)/post_route.dcp: $(build_dir)/post_place.dcp
	vivado -mode batch -source $(tcl_dir)/vivado_route.tcl -log $(build_dir)/route_log.txt -nojournal -tempDir $(build_dir) -tclargs $(project_name) $(build_dir)

bitstream: $(build_dir)/$(proj).bit
$(build_dir)/$(proj).bit: $(build_dir)/post_route.dcp
	vivado -mode batch -source $(tcl_dir)/vivado_bitstream.tcl -log $(build_dir)/bitstream_log.txt -nojournal -tempDir $(build_dir) -tclargs $(project_name) $(build_dir)

.PHONY: clean
clean:
	rm -f usage_statistics_webtalk.html usage_statistics_webtalk.xml
	rm -f fsm_encoding.os
	rm -rf build

