/*
* Project: OASIS
* Module : SECDED encoder module
* Revisions:
*            2015.12.16: First version.
*            2016.01.16: RAB, BLoD, SER, ECC, LAFT are completed
*/

module SECDED_enc(
  clk,
  rst_n,
  data_in,
  data_out
);

parameter DATA_BIT = 16;
parameter CODE_BIT = 22;

input clk, rst_n;

input  [DATA_BIT-1:0] data_in;
output [CODE_BIT-1:0] data_out;

localparam PARITY_BIT = CODE_BIT-DATA_BIT;

wire [DATA_BIT-1:0] sb [PARITY_BIT-1:0];
// NOTE: is this synthesizable???
assign  sb[0] = {16'b0100_0100_0011_1111};
assign  sb[1] = {16'b0001_0011_1100_0111};
assign  sb[2] = {16'b1110_0001_1101_0001};
assign  sb[3] = {16'b1110_1110_0110_0000};
assign  sb[4] = {16'b0011_1110_1000_1010};
assign  sb[5] = {16'b1001_1001_0011_1100};
genvar i;
genvar k;

wire [PARITY_BIT-1:0] p;
wire  [PARITY_BIT-1:0] tp [DATA_BIT-1:0];

generate
  for (i=0; i<PARITY_BIT;i=i+1)
  begin : parity_loop
    assign tp[0][i] = (sb[i][0] & data_in[0]);
    for(k=1;k<DATA_BIT;k=k+1) begin : tempo_parity
      assign tp[k][i] = tp[k-1][i] ^ (sb[i][k]&data_in[k]);
    end
    assign p[i] = tp[DATA_BIT-1][i];
 end
endgenerate

assign data_out[DATA_BIT-1:0]        = data_in[DATA_BIT-1:0];
assign data_out[CODE_BIT-1:DATA_BIT] = p[PARITY_BIT-1:0];

endmodule
