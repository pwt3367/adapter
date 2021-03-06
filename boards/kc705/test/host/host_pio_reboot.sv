`default_nettype none
`timescale 1ns/1ps

import pcie_tlp_pkg::*;

module host_pio (
	input wire pcie_clk,
	input wire sys_rst,

	input  PCIE_TREADY64   pcie_rx_tready,
	output PCIE_TVALID64   pcie_rx_tvalid,
	output PCIE_TLAST64    pcie_rx_tlast,
	output PCIE_TKEEP64    pcie_rx_tkeep,
	output PCIE_TDATA64    pcie_rx_tdata,
	output PCIE_TUSER64_RX pcie_rx_tuser
);

logic [7:0] count;
enum logic [1:0] { IDLE, READ } state;
always_ff @(posedge pcie_clk) begin
	if (sys_rst) begin
		count <= 0;
		state <= IDLE;
	end else begin
		case (state)
		IDLE: begin
			if (pcie_rx_tready) begin
				count <= 0;
				state <= READ;
			end
		end
		READ: begin
			if (pcie_rx_tready) begin
				count <= count + 1;
				if (count == 16) begin
					state <= IDLE;
				end
			end
		end
		endcase
	end
end

// cc
always_comb begin
	case (state)
	READ: begin
		case (count)
8'h4: {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b0, 1'b0, 8'b0000_0000, 64'h00000000_00000000, 22'b000000_00000000_00000000};
8'h5: {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b1, 1'b0, 8'b1111_1111, 64'h00000002_00000001, 22'b001110_01000001_00000000};
8'h6: {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b1, 1'b1, 8'b0000_1111, 64'h1863f2b7_c0000000, 22'b100110_00000001_00000000};
8'h7: {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b1, 1'b1, 8'b0000_1111, 64'h1863f2b7_c0000000, 22'b100110_00000001_00000000};
8'h8: {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b1, 1'b1, 8'b0000_1111, 64'h1863f2b7_c0000000, 22'b100110_00000001_00000000};
8'h9: {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b1, 1'b1, 8'b0000_1111, 64'h1863f2b7_c0000000, 22'b100110_00000001_00000000};
8'ha: {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b1, 1'b1, 8'b0000_1111, 64'h1863f2b7_c0000000, 22'b100110_00000001_00000000};
8'hb: {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b0, 1'b0, 8'b0000_1111, 64'h1863f2b7_c0000000, 22'b000000_00000000_00000000};
8'hc: {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b0, 1'b0, 8'b0000_1111, 64'h1863f2b7_c0000000, 22'b000000_00000000_00000000};
default:
      {pcie_rx_tvalid, pcie_rx_tlast, pcie_rx_tkeep, pcie_rx_tdata, pcie_rx_tuser} = {1'b0, 1'b0, 8'b0000_0000, 64'h00000000_00000000, 22'b000000_00000000_00000100};
endcase
	end
	endcase
end

endmodule

`default_nettype wire
