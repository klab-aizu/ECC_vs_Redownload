/*
* Project: OASIS
* Module : SECDED decoder module
* Revisions:
*            2015.12.16: First version.
*            2016.01.16: RAB, BLoD, SER, ECC, LAFT are completed
*/

`ifndef VCS
 `include "defines.v"
`endif

module SECDED_dec(
  clk,
  rst_n,
  data_in,
  uncorrected,
  data_out
);

parameter DATA_BIT = 16;
parameter CODE_BIT = 22;

input clk, rst_n;

input  [CODE_BIT-1:0] data_in;
output [CODE_BIT-1:0] data_out;

localparam PARITY_BIT = CODE_BIT-DATA_BIT;

output uncorrected;

wire [CODE_BIT-1:0] sb [PARITY_BIT-1:0];
// NOTE: is this synthesizable???
assign  sb[0] = {22'b000001_0100_0100_0011_1111};
assign  sb[1] = {22'b000010_0001_0011_1100_0111};
assign  sb[2] = {22'b000100_1110_0001_1101_0001};
assign  sb[3] = {22'b001000_1110_1110_0110_0000};
assign  sb[4] = {22'b010000_0011_1110_1000_1010};
assign  sb[5] = {22'b100000_1001_1001_0011_1100};

genvar i;
genvar k;

wire [PARITY_BIT-1:0] cb;
wire [DATA_BIT-1:0]   tcb [PARITY_BIT-1:0];
wire [CODE_BIT-1:0]   eb;
wire [PARITY_BIT-1:0] teb [CODE_BIT-1:0];
wire [PARITY_BIT-1:0] p;


wire error;
wire one_error;
wire two_error;

assign p[PARITY_BIT-1:0] = data_in[CODE_BIT-1:DATA_BIT];
assign error = (|cb[PARITY_BIT-1:0]);
assign one_error = error & (^cb[PARITY_BIT-1:0]);
assign two_error =  error & !(^cb[PARITY_BIT-1:0]);

generate if (`DISABLE_CORRECT == 1) begin: DIS_CORR
  assign uncorrected = one_error|two_error;
  assign data_out = ((one_error | two_error) && `DIAG_DROPFLIT)? {CODE_BIT{1'b0}}:
                    ((one_error | two_error) && (!`DIAG_DROPFLIT))? data_in:data_in;
end else begin : EN_CORR
  assign uncorrected = two_error;
  assign data_out = (one_error)? (data_in^eb):
                    (two_error && `DIAG_DROPFLIT)? {CODE_BIT{1'b0}}:
                    (two_error && (!`DIAG_DROPFLIT))? data_in:data_in;
end
endgenerate

// check bit
generate
  for (i=0; i<CODE_BIT-DATA_BIT;i=i+1)
  begin : check_bit
    assign tcb[i][0] = (sb[i][0])? (p[i]^data_in[0]) : (p[i]); // check first one
    for(k=1;k<DATA_BIT;k=k+1) begin : tempo_checkbit
      assign tcb[i][k] = (sb[i][k])? (tcb[i][k-1]^data_in[k]):(tcb[i][k-1]);  // check every one
    end
    assign cb[i] = tcb[i][DATA_BIT-1];
  end
endgenerate

// correct bit
generate
  for (i=0; i<CODE_BIT; i=i+1) begin : code_bit
    assign teb[i][0] = (sb[0][i])? cb[0]:!cb[0];
    for(k=1;k<PARITY_BIT;k=k+1) begin : tempo_errbit
      assign teb[i][k] = (sb[k][i])? (teb[i][k-1]&cb[k]):(teb[i][k-1]&(!cb[k]));
    end
    assign eb[i] = teb[i][PARITY_BIT-1];
  end
endgenerate

endmodule
