// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
`timescale 1 ns / 1 ps
 
/// sta-blackbox
module simple_por(
`ifdef USE_POWER_PINS
    inout vdd3v3,
    inout vdd1v8,
    inout vss3v3,
    inout vss1v8,
`endif
    output porb_h,
    output porb_l,
    output por_l
);

    wire mid;
    reg inode;

    // This is a behavioral model!  Actual circuit is a resitor dumping
    // current (slowly) from vdd3v3 onto a capacitor, and this fed into
    // two schmitt triggers for strong hysteresis/glitch tolerance.

    initial begin
	inode <= 1'b0; 
    end 

    // Emulate current source on capacitor as a 500ns delay either up or
    // down.  Note that this is sped way up for verilog simulation;  the
    // actual circuit is set to a 15ms delay.

    `ifdef USE_POWER_PINS
        always @(posedge vdd3v3) begin
    `else
        initial begin
    `endif
	#500 inode <= 1'b1;
    end

    `ifdef USE_POWER_PINS
        always @(negedge vdd3v3) begin
        #500 inode <= 1'b0;
        end
    `endif

    // Instantiate two shmitt trigger buffers in series

    sky130_fd_sc_hvl__schmittbuf_1 hystbuf1 (
`ifdef USE_POWER_PINS
	.VPWR(vdd3v3),
	.VGND(vss3v3),
	.VPB(vdd3v3),
	.VNB(vss3v3),
`endif
	.A(inode),
	.X(mid)
    );

    sky130_fd_sc_hvl__schmittbuf_1 hystbuf2 (
`ifdef USE_POWER_PINS
	.VPWR(vdd3v3),
	.VGND(vss3v3),
	.VPB(vdd3v3),
	.VNB(vss3v3),
`endif
	.A(mid),
	.X(porb_h)
    );

    sky130_fd_sc_hvl__lsbufhv2lv_1 porb_level (
`ifdef USE_POWER_PINS
	.VPWR(vdd3v3),
	.VPB(vdd3v3),
	.LVPWR(vdd1v8),
	.VNB(vss3v3),
	.VGND(vss3v3),
`endif
	.A(porb_h),
	.X(porb_l)
    );

    // since this is behavioral anyway, but this should be
    // replaced by a proper inverter
    assign por_l = ~porb_l;
endmodule
`default_nettype wire
