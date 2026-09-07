/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : X-2025.06-SP5-2
// Date      : Mon Sep  7 23:36:14 2026
/////////////////////////////////////////////////////////////


module SECDED_1622_enc ( data_in, data_out );
  input [15:0] data_in;
  output [21:0] data_out;
  wire   \tp[14][0] , \tp[13][4] , \tp[12][1] , n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54;
  assign data_out[15] = data_in[15];
  assign data_out[14] = data_in[14];
  assign data_out[13] = data_in[13];
  assign data_out[12] = data_in[12];
  assign data_out[11] = data_in[11];
  assign data_out[10] = data_in[10];
  assign data_out[9] = data_in[9];
  assign data_out[8] = data_in[8];
  assign data_out[7] = data_in[7];
  assign data_out[6] = data_in[6];
  assign data_out[5] = data_in[5];
  assign data_out[4] = data_in[4];
  assign data_out[3] = data_in[3];
  assign data_out[2] = data_in[2];
  assign data_out[1] = data_in[1];
  assign data_out[0] = data_in[0];
  assign data_out[16] = \tp[14][0] ;
  assign data_out[20] = \tp[13][4] ;
  assign data_out[17] = \tp[12][1] ;

  XOR2_X1 U36 ( .A(n28), .B(n29), .Z(\tp[14][0] ) );
  XOR2_X1 U37 ( .A(n30), .B(n31), .Z(n29) );
  XOR2_X1 U38 ( .A(data_out[10]), .B(n32), .Z(n28) );
  XOR2_X1 U39 ( .A(data_out[5]), .B(data_out[1]), .Z(n32) );
  XOR2_X1 U40 ( .A(n33), .B(n34), .Z(\tp[13][4] ) );
  XOR2_X1 U41 ( .A(n35), .B(n36), .Z(n34) );
  XNOR2_X1 U42 ( .A(data_out[11]), .B(n37), .ZN(n35) );
  XNOR2_X1 U43 ( .A(data_out[12]), .B(n38), .ZN(n33) );
  XOR2_X1 U44 ( .A(data_out[3]), .B(data_out[13]), .Z(n38) );
  XOR2_X1 U45 ( .A(n39), .B(n40), .Z(\tp[12][1] ) );
  XOR2_X1 U46 ( .A(n41), .B(n42), .Z(n40) );
  XNOR2_X1 U47 ( .A(data_out[0]), .B(n36), .ZN(n41) );
  XOR2_X1 U48 ( .A(data_out[1]), .B(data_out[7]), .Z(n36) );
  XNOR2_X1 U49 ( .A(data_out[2]), .B(n43), .ZN(n39) );
  XOR2_X1 U50 ( .A(data_out[9]), .B(data_out[6]), .Z(n43) );
  XOR2_X1 U51 ( .A(n44), .B(n45), .Z(data_out[21]) );
  XNOR2_X1 U52 ( .A(n46), .B(n42), .ZN(n45) );
  XOR2_X1 U53 ( .A(data_out[12]), .B(data_out[8]), .Z(n42) );
  XNOR2_X1 U54 ( .A(data_out[4]), .B(n31), .ZN(n44) );
  XOR2_X1 U55 ( .A(data_out[2]), .B(data_out[3]), .Z(n31) );
  XOR2_X1 U56 ( .A(n47), .B(n48), .Z(data_out[19]) );
  XOR2_X1 U57 ( .A(n46), .B(n49), .Z(n48) );
  XOR2_X1 U58 ( .A(data_out[11]), .B(n50), .Z(n46) );
  XOR2_X1 U59 ( .A(data_out[5]), .B(data_out[15]), .Z(n50) );
  XOR2_X1 U60 ( .A(data_out[14]), .B(n37), .Z(n47) );
  XOR2_X1 U61 ( .A(data_out[10]), .B(data_out[9]), .Z(n37) );
  XOR2_X1 U62 ( .A(n51), .B(n52), .Z(data_out[18]) );
  XOR2_X1 U63 ( .A(n30), .B(n49), .Z(n52) );
  XOR2_X1 U64 ( .A(data_out[13]), .B(data_out[6]), .Z(n49) );
  XOR2_X1 U65 ( .A(data_out[0]), .B(n53), .Z(n30) );
  XOR2_X1 U66 ( .A(data_out[4]), .B(data_out[14]), .Z(n53) );
  XOR2_X1 U67 ( .A(data_out[15]), .B(n54), .Z(n51) );
  XOR2_X1 U68 ( .A(data_out[8]), .B(data_out[7]), .Z(n54) );
endmodule

