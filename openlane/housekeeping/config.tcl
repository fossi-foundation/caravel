# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

## This should be changed to point at Caravel root
set ::env(CARAVEL_ROOT) $::env(DESIGN_DIR)/../..
set ::env(STA_WRITE_LIB) 1
set ::env(DESIGN_IS_CORE) 0

set ::env(DESIGN_NAME) "housekeeping"
set ::env(ROUTING_CORES) 12
set ::env(RUN_KLAYOUT) 0
set ::env(PDK) "sky130A"

set ::env(VERILOG_FILES) "\
	$::env(DESIGN_DIR)/../../verilog/rtl/defines.v\
    $::env(DESIGN_DIR)/../../verilog/rtl/housekeeping_spi.v\
    $::env(DESIGN_DIR)/../../verilog/rtl/housekeeping.v"

set ::env(CLOCK_PORT) ""
set ::env(CLOCK_NET) "wb_clk_i csclk mgmt_gpio_in\[4\]"
set ::env(CLOCK_TREE_SYNTH) 1


set ::env(BASE_SDC_FILE) [glob $::env(DESIGN_DIR)/base.sdc]
set ::env(RCX_SDC_FILE) [glob $::env(DESIGN_DIR)/signoff.sdc]

## Synthesis 
set ::env(NO_SYNTH_CELL_LIST) [glob $::env(DESIGN_DIR)/no_synth.list] 
set ::env(DRC_EXCLUDE_CELL_LIST) [glob $::env(DESIGN_DIR)/drc_exclude.list] 
set ::env(SYNTH_STRATEGY) "AREA 0"

set ::env(SYNTH_MAX_FANOUT) 20
set ::env(SYNTH_BUFFERING) 0
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

## Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 410.230 550.950"

set ::env(FP_PIN_ORDER_CFG) [glob $::env(DESIGN_DIR)/pin_order.cfg]

set ::env(FP_IO_MIN_DISTANCE) 2

set ::env(CELL_PAD) 0

set ::env(FP_PDN_CORE_RING) 0
set ::env(FP_PDN_HPITCH) 78.2
set ::env(FP_PDN_VPITCH) 76.8
set ::env(FP_PDN_HSPACING) 37.5
set ::env(FP_PDN_HOFFSET) 16.41

## Placement
set ::env(PL_TARGET_DENSITY) 0.31
set ::env(PL_TIME_DRIVEN) 1
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 800
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 0.4

set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.1
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) "50"
set ::env(PL_RESIZER_MAX_CAP_MARGIN) "50"

# set ::env(PL_RESIZER_HOLD_MAX_BUFFER_PERCENT) 50
# set ::env(PL_RESIZER_ALLOW_SETUP_VIOS) 1
set ::env(CLOCK_TREE_SYNTH) 1

## Routing 
set ::env(GRT_ADJUSTMENT) 0.2
# set ::env(GLB_OVERFLOW_ITERS) 100
set ::env(GRT_ALLOW_CONGESTION) 1
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(RT_MAX_LAYER) met4
set ::env(DRT_MAX_LAYER) met4

set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.4
set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) 600
set ::env(GLB_RESIZER_MAX_SLEW_MARGIN) "30"
set ::env(GLB_RESIZER_MAX_CAP_MARGIN) "30"
set ::env(GLB_RESIZER_SETUP_SLACK_MARGIN) 0.2

## Diode Insertion
set ::env(GRT_REPAIR_ANTENNAS) 1
set ::env(RUN_HEURISTIC_DIODE_INSERTION) 1
set ::env(HEURISTIC_ANTENNA_THRESHOLD) 180
set ::env(DIODE_ON_PORTS) "both"
set ::env(GRT_ANT_ITERS) 12
set ::env(GRT_MAX_DIODE_INS_ITERS) 4
set ::env(DIODE_PADDING) 0

## clock buffering
# set ::env(CTS_CLK_BUFFER_LIST) {sky130_fd_sc_hd__clkbuf_8 sky130_fd_sc_hd__clkbuf_4}
# set ::env(CTS_ROOT_BUFFER) {sky130_fd_sc_hd__clkbuf_8}
# set ::env(CTS_CLK_MAX_WIRE_LENGTH) 120
set ::env(CTS_MAX_CAP) 0.25

set ::env(MAGIC_DEF_LABELS) 0
set ::env(RSZ_DONT_TOUCH_RX) {mgmt_gpio_out_9_prebuff|mgmt_gpio_out\[9\]|mgmt_gpio_out_14_prebuff|mgmt_gpio_out\[14\]|mgmt_gpio_out_15_prebuff|mgmt_gpio_out\[15\]|pad_flash_clk\y|pad_flash_clk_prebuff}
set ::env(FP_PDN_IRDROP) 0