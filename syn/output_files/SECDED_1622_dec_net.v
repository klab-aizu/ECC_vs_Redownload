/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : X-2025.06-SP5-2
// Date      : Mon Sep  7 23:34:12 2026
/////////////////////////////////////////////////////////////


module SECDED_1622_dec ( data_in, uncorrected, data_out );
  input [21:0] data_in;
  output [21:0] data_out;
  output uncorrected;
  wire   n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203;

  AOI21_X1 U127 ( .B1(n102), .B2(n103), .A(n104), .ZN(uncorrected) );
  XOR2_X1 U128 ( .A(n105), .B(n106), .Z(n104) );
  NOR2_X1 U129 ( .A1(n107), .A2(n108), .ZN(n106) );
  MUX2_X1 U130 ( .A(n109), .B(n110), .S(n111), .Z(n105) );
  NOR2_X1 U131 ( .A1(n112), .A2(n113), .ZN(n111) );
  NOR2_X1 U132 ( .A1(n114), .A2(n115), .ZN(n110) );
  NOR2_X1 U133 ( .A1(n102), .A2(n116), .ZN(n109) );
  XNOR2_X1 U134 ( .A(data_in[9]), .B(n117), .ZN(data_out[9]) );
  NAND2_X1 U135 ( .A1(n114), .A2(n118), .ZN(n117) );
  XOR2_X1 U136 ( .A(data_in[8]), .B(n119), .Z(data_out[8]) );
  NOR2_X1 U137 ( .A1(n120), .A2(n121), .ZN(n119) );
  XNOR2_X1 U138 ( .A(data_in[7]), .B(n122), .ZN(data_out[7]) );
  NAND3_X1 U139 ( .A1(n114), .A2(n113), .A3(n107), .ZN(n122) );
  XNOR2_X1 U140 ( .A(data_in[6]), .B(n123), .ZN(data_out[6]) );
  NAND4_X1 U141 ( .A1(n124), .A2(n114), .A3(n125), .A4(n126), .ZN(n123) );
  XNOR2_X1 U142 ( .A(data_in[5]), .B(n127), .ZN(data_out[5]) );
  NAND3_X1 U143 ( .A1(n112), .A2(n108), .A3(n115), .ZN(n127) );
  XOR2_X1 U144 ( .A(data_in[4]), .B(n128), .Z(data_out[4]) );
  NOR2_X1 U145 ( .A1(n121), .A2(n129), .ZN(n128) );
  NAND2_X1 U146 ( .A1(n130), .A2(n131), .ZN(n121) );
  XNOR2_X1 U147 ( .A(data_in[3]), .B(n132), .ZN(data_out[3]) );
  NAND2_X1 U148 ( .A1(n133), .A2(n115), .ZN(n132) );
  XNOR2_X1 U149 ( .A(data_in[2]), .B(n134), .ZN(data_out[2]) );
  NAND2_X1 U150 ( .A1(n135), .A2(n112), .ZN(n134) );
  XNOR2_X1 U151 ( .A(data_in[21]), .B(n136), .ZN(data_out[21]) );
  NAND2_X1 U152 ( .A1(n137), .A2(n112), .ZN(n136) );
  XNOR2_X1 U153 ( .A(data_in[20]), .B(n138), .ZN(data_out[20]) );
  NAND2_X1 U154 ( .A1(n137), .A2(n113), .ZN(n138) );
  AND2_X1 U155 ( .A1(n102), .A2(n139), .ZN(n137) );
  XNOR2_X1 U156 ( .A(data_in[1]), .B(n140), .ZN(data_out[1]) );
  NAND2_X1 U157 ( .A1(n135), .A2(n113), .ZN(n140) );
  AND2_X1 U158 ( .A1(n116), .A2(n139), .ZN(n135) );
  XNOR2_X1 U159 ( .A(data_in[19]), .B(n141), .ZN(data_out[19]) );
  NAND3_X1 U160 ( .A1(n126), .A2(n108), .A3(n142), .ZN(n141) );
  XNOR2_X1 U161 ( .A(data_in[18]), .B(n143), .ZN(data_out[18]) );
  NAND2_X1 U162 ( .A1(n142), .A2(n130), .ZN(n143) );
  AND2_X1 U163 ( .A1(n102), .A2(n125), .ZN(n142) );
  XNOR2_X1 U164 ( .A(data_in[17]), .B(n144), .ZN(data_out[17]) );
  NAND2_X1 U165 ( .A1(n114), .A2(n103), .ZN(n144) );
  XNOR2_X1 U166 ( .A(data_in[16]), .B(n145), .ZN(data_out[16]) );
  NAND2_X1 U167 ( .A1(n115), .A2(n103), .ZN(n145) );
  AND3_X1 U168 ( .A1(n125), .A2(n126), .A3(n139), .ZN(n103) );
  XOR2_X1 U169 ( .A(n146), .B(n147), .Z(data_out[15]) );
  NAND3_X1 U170 ( .A1(n124), .A2(n102), .A3(n112), .ZN(n147) );
  NOR2_X1 U171 ( .A1(n148), .A2(n125), .ZN(n112) );
  XNOR2_X1 U172 ( .A(data_in[14]), .B(n149), .ZN(data_out[14]) );
  NAND4_X1 U173 ( .A1(n115), .A2(n124), .A3(n125), .A4(n126), .ZN(n149) );
  XNOR2_X1 U174 ( .A(data_in[13]), .B(n150), .ZN(data_out[13]) );
  NAND3_X1 U175 ( .A1(n113), .A2(n102), .A3(n124), .ZN(n150) );
  AND2_X1 U176 ( .A1(n151), .A2(n152), .ZN(n124) );
  XOR2_X1 U177 ( .A(n153), .B(n154), .Z(data_out[12]) );
  NAND2_X1 U178 ( .A1(n133), .A2(n114), .ZN(n154) );
  INV_X1 U179 ( .A(n120), .ZN(n114) );
  NAND2_X1 U180 ( .A1(n155), .A2(n156), .ZN(n120) );
  AND3_X1 U181 ( .A1(n148), .A2(n131), .A3(n139), .ZN(n133) );
  NOR2_X1 U182 ( .A1(n152), .A2(n151), .ZN(n139) );
  INV_X1 U183 ( .A(n157), .ZN(n152) );
  XNOR2_X1 U184 ( .A(data_in[11]), .B(n158), .ZN(data_out[11]) );
  NAND4_X1 U185 ( .A1(n108), .A2(n102), .A3(n148), .A4(n131), .ZN(n158) );
  INV_X1 U186 ( .A(n126), .ZN(n148) );
  NOR2_X1 U187 ( .A1(n159), .A2(n156), .ZN(n102) );
  INV_X1 U188 ( .A(n160), .ZN(n156) );
  XNOR2_X1 U189 ( .A(data_in[10]), .B(n161), .ZN(data_out[10]) );
  NAND2_X1 U190 ( .A1(n115), .A2(n118), .ZN(n161) );
  AND2_X1 U191 ( .A1(n108), .A2(n113), .ZN(n118) );
  NOR2_X1 U192 ( .A1(n131), .A2(n126), .ZN(n113) );
  INV_X1 U193 ( .A(n125), .ZN(n131) );
  AND2_X1 U194 ( .A1(n157), .A2(n151), .ZN(n108) );
  INV_X1 U195 ( .A(n129), .ZN(n115) );
  NAND2_X1 U196 ( .A1(n160), .A2(n159), .ZN(n129) );
  INV_X1 U197 ( .A(n155), .ZN(n159) );
  XNOR2_X1 U198 ( .A(data_in[0]), .B(n162), .ZN(data_out[0]) );
  NAND3_X1 U199 ( .A1(n125), .A2(n130), .A3(n116), .ZN(n162) );
  NOR2_X1 U200 ( .A1(n160), .A2(n155), .ZN(n116) );
  XNOR2_X1 U201 ( .A(data_in[14]), .B(n163), .ZN(n155) );
  XOR2_X1 U202 ( .A(n164), .B(n165), .Z(n163) );
  XOR2_X1 U203 ( .A(n166), .B(n167), .Z(n165) );
  XOR2_X1 U204 ( .A(data_in[10]), .B(data_in[0]), .Z(n167) );
  XOR2_X1 U205 ( .A(data_in[1]), .B(data_in[16]), .Z(n166) );
  XOR2_X1 U206 ( .A(n168), .B(n169), .Z(n164) );
  XOR2_X1 U207 ( .A(data_in[3]), .B(data_in[2]), .Z(n169) );
  XOR2_X1 U208 ( .A(data_in[5]), .B(data_in[4]), .Z(n168) );
  XOR2_X1 U209 ( .A(n153), .B(n170), .Z(n160) );
  XOR2_X1 U210 ( .A(n171), .B(n172), .Z(n170) );
  XOR2_X1 U211 ( .A(n173), .B(n174), .Z(n172) );
  XOR2_X1 U212 ( .A(data_in[17]), .B(data_in[0]), .Z(n174) );
  XOR2_X1 U213 ( .A(data_in[2]), .B(data_in[1]), .Z(n173) );
  XOR2_X1 U214 ( .A(n175), .B(n176), .Z(n171) );
  XOR2_X1 U215 ( .A(data_in[7]), .B(data_in[6]), .Z(n176) );
  XOR2_X1 U216 ( .A(data_in[9]), .B(data_in[8]), .Z(n175) );
  INV_X1 U217 ( .A(data_in[12]), .ZN(n153) );
  AND2_X1 U218 ( .A1(n107), .A2(n126), .ZN(n130) );
  XOR2_X1 U219 ( .A(n177), .B(n178), .Z(n126) );
  XOR2_X1 U220 ( .A(n179), .B(n180), .Z(n178) );
  XOR2_X1 U221 ( .A(data_in[12]), .B(n181), .Z(n180) );
  XOR2_X1 U222 ( .A(data_in[1]), .B(data_in[13]), .Z(n179) );
  XOR2_X1 U223 ( .A(n182), .B(n183), .Z(n177) );
  XOR2_X1 U224 ( .A(data_in[9]), .B(data_in[7]), .Z(n183) );
  XNOR2_X1 U225 ( .A(data_in[20]), .B(data_in[3]), .ZN(n182) );
  NOR2_X1 U226 ( .A1(n151), .A2(n157), .ZN(n107) );
  XOR2_X1 U227 ( .A(n146), .B(n184), .Z(n157) );
  XOR2_X1 U228 ( .A(n185), .B(n186), .Z(n184) );
  XOR2_X1 U229 ( .A(n187), .B(n188), .Z(n186) );
  XOR2_X1 U230 ( .A(data_in[13]), .B(data_in[0]), .Z(n188) );
  XOR2_X1 U231 ( .A(data_in[18]), .B(data_in[14]), .Z(n187) );
  XOR2_X1 U232 ( .A(n189), .B(n190), .Z(n185) );
  XOR2_X1 U233 ( .A(data_in[6]), .B(data_in[4]), .Z(n190) );
  XOR2_X1 U234 ( .A(data_in[8]), .B(data_in[7]), .Z(n189) );
  XNOR2_X1 U235 ( .A(n191), .B(n192), .ZN(n151) );
  XOR2_X1 U236 ( .A(n193), .B(n194), .Z(n192) );
  XOR2_X1 U237 ( .A(data_in[13]), .B(n181), .Z(n194) );
  XOR2_X1 U238 ( .A(data_in[10]), .B(data_in[11]), .Z(n181) );
  XOR2_X1 U239 ( .A(data_in[15]), .B(data_in[14]), .Z(n193) );
  XOR2_X1 U240 ( .A(n195), .B(n196), .Z(n191) );
  XOR2_X1 U241 ( .A(data_in[9]), .B(data_in[6]), .Z(n196) );
  XNOR2_X1 U242 ( .A(data_in[19]), .B(data_in[5]), .ZN(n195) );
  XOR2_X1 U243 ( .A(n146), .B(n197), .Z(n125) );
  XOR2_X1 U244 ( .A(n198), .B(n199), .Z(n197) );
  XOR2_X1 U245 ( .A(n200), .B(n201), .Z(n199) );
  XOR2_X1 U246 ( .A(data_in[12]), .B(data_in[11]), .Z(n201) );
  XOR2_X1 U247 ( .A(data_in[2]), .B(data_in[21]), .Z(n200) );
  XOR2_X1 U248 ( .A(n202), .B(n203), .Z(n198) );
  XOR2_X1 U249 ( .A(data_in[4]), .B(data_in[3]), .Z(n203) );
  XOR2_X1 U250 ( .A(data_in[8]), .B(data_in[5]), .Z(n202) );
  INV_X1 U251 ( .A(data_in[15]), .ZN(n146) );
endmodule

