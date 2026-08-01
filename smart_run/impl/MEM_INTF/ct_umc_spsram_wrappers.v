// SPDX-License-Identifier: Apache-2.0
//
// Thin wrappers that adapt the canonical T-Head single-port SRAM interface
// (A, CEN, CLK, D, GWEN, Q, WEN) -- all CEN/GWEN/WEN active-low -- to the
// TSMC 28HPC+ SP-SRAM macros generated under ../gen_sram/.
//
// TSMC pin convention:
//   CEB  : chip-enable-bar  (active low)            <- CEN
//   WEB  : global write-enable-bar (active low)     <- GWEN
//   BWEB : per-bit  write-enable-bar (active low)   <- WEN
//   SLP/SD : sleep / shutdown -- tie low for normal operation
//   RTSEL[1:0]/WTSEL[1:0] : timing margin select -- datasheet defaults
//                            RTSEL=2'b01, WTSEL=2'b00.
//
// Macro naming:
//   TS1N28HPCPUHDSVTB{W}X{D}M{MUX}SW  -- UHD SVT, write-mask (BWEB)
//   TS1N28HPCPHVTB{W}X{D}M8SW         -- HVT, byte-write (8:1 mux)
// Mux ratio (M2/M4/M8) is selected by data width and will be matched
// by gen_sram.sh configs.
//
// Large L2-cache SRAMs (>4096 words) are composed from 4096-word base
// macros with address decode and output mux.  This is standard practice
// because the TSMC 28HPC+ compiler maxes out at 4096 words per macro.

`timescale 1ns/10ps

// ====================================================================
// 64-word variants (6-bit address)
// ====================================================================
module ct_umc_spsram_64x108 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [5:0]    A; input CEN; input CLK; input [107:0] D;
  input GWEN; output [107:0] Q; input [107:0] WEN;
  TS1N28HPCPUHDSVTB64X108M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

// ====================================================================
// 128-word variants (7-bit address)
// ====================================================================
module ct_umc_spsram_128x16 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [6:0]   A; input CEN; input CLK; input [15:0] D;
  input GWEN; output [15:0] Q; input [15:0] WEN;
  TS1N28HPCPUHDSVTB128X16M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_128x104 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [6:0]    A; input CEN; input CLK; input [103:0] D;
  input GWEN; output [103:0] Q; input [103:0] WEN;
  TS1N28HPCPUHDSVTB128X104M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_128x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [6:0]    A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  TS1N28HPCPUHDSVTB128X144M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

// ====================================================================
// 256-word variants (8-bit address)
// ====================================================================
module ct_umc_spsram_256x7 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]  A; input CEN; input CLK; input [6:0] D;
  input GWEN; output [6:0] Q; input [6:0] WEN;
  TS1N28HPCPUHDSVTB256X7M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_256x23 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [22:0] D;
  input GWEN; output [22:0] Q; input [22:0] WEN;
  TS1N28HPCPUHDSVTB256X23M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_256x52 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [51:0] D;
  input GWEN; output [51:0] Q; input [51:0] WEN;
  TS1N28HPCPUHDSVTB256X52M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_256x54 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [53:0] D;
  input GWEN; output [53:0] Q; input [53:0] WEN;
  TS1N28HPCPUHDSVTB256X54M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_256x59 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [58:0] D;
  input GWEN; output [58:0] Q; input [58:0] WEN;
  TS1N28HPCPUHDSVTB256X59M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_256x84 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [83:0] D;
  input GWEN; output [83:0] Q; input [83:0] WEN;
  TS1N28HPCPUHDSVTB256X84M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_256x100 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [99:0] D;
  input GWEN; output [99:0] Q; input [99:0] WEN;
  TS1N28HPCPUHDSVTB256X100M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_256x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]    A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  TS1N28HPCPUHDSVTB256X144M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

// 256x196: compose from 128-bit + 68-bit macros (width composition)
module ct_umc_spsram_256x196 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]    A; input CEN; input CLK; input [195:0] D;
  input GWEN; output [195:0] Q; input [195:0] WEN;
  TS1N28HPCPUHDSVTB256X128M4SW u_lo (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D[127:0]),
    .BWEB(WEN[127:0]), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q[127:0]));
  TS1N28HPCPUHDSVTB256X68M2SW u_hi (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D[195:128]),
    .BWEB(WEN[195:128]), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q[195:128]));
endmodule

// ====================================================================
// 512-word variants (9-bit address)
// ====================================================================
module ct_umc_spsram_512x7 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]  A; input CEN; input CLK; input [6:0] D;
  input GWEN; output [6:0] Q; input [6:0] WEN;
  TS1N28HPCPUHDSVTB512X7M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_512x22 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [21:0] D;
  input GWEN; output [21:0] Q; input [21:0] WEN;
  TS1N28HPCPUHDSVTB512X22M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_512x44 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [43:0] D;
  input GWEN; output [43:0] Q; input [43:0] WEN;
  TS1N28HPCPUHDSVTB512X44M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_512x52 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [51:0] D;
  input GWEN; output [51:0] Q; input [51:0] WEN;
  TS1N28HPCPUHDSVTB512X52M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_512x54 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [53:0] D;
  input GWEN; output [53:0] Q; input [53:0] WEN;
  TS1N28HPCPUHDSVTB512X54M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_512x59 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [58:0] D;
  input GWEN; output [58:0] Q; input [58:0] WEN;
  TS1N28HPCPUHDSVTB512X59M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_512x96 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [95:0] D;
  input GWEN; output [95:0] Q; input [95:0] WEN;
  TS1N28HPCPUHDSVTB512X96M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_512x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]    A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  TS1N28HPCPUHDSVTB512X144M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

// ====================================================================
// 1024-word variants (10-bit address)
// ====================================================================
module ct_umc_spsram_1024x32 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]   A; input CEN; input CLK; input [31:0] D;
  input GWEN; output [31:0] Q; input [31:0] WEN;
  TS1N28HPCPUHDSVTB1024X32M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_1024x59 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]   A; input CEN; input CLK; input [58:0] D;
  input GWEN; output [58:0] Q; input [58:0] WEN;
  TS1N28HPCPUHDSVTB1024X59M2SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_1024x64 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]   A; input CEN; input CLK; input [63:0] D;
  input GWEN; output [63:0] Q; input [63:0] WEN;
  TS1N28HPCPHVTB1024X64M8SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .Q(Q));
endmodule

module ct_umc_spsram_1024x92 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]   A; input CEN; input CLK; input [91:0] D;
  input GWEN; output [91:0] Q; input [91:0] WEN;
  TS1N28HPCPUHDSVTB1024X92M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_1024x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]    A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  TS1N28HPCPHVTB1024X128M8SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .Q(Q));
endmodule

module ct_umc_spsram_1024x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]    A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  TS1N28HPCPHVTB1024X144M8SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .Q(Q));
endmodule

// ====================================================================
// 2048-word variants (11-bit address)
// ====================================================================
module ct_umc_spsram_2048x32 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]  A; input CEN; input CLK; input [31:0] D;
  input GWEN; output [31:0] Q; input [31:0] WEN;
  TS1N28HPCPUHDSVTB2048X32M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_2048x59 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]  A; input CEN; input CLK; input [58:0] D;
  input GWEN; output [58:0] Q; input [58:0] WEN;
  TS1N28HPCPUHDSVTB2048X59M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_2048x88 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]  A; input CEN; input CLK; input [87:0] D;
  input GWEN; output [87:0] Q; input [87:0] WEN;
  TS1N28HPCPUHDSVTB2048X88M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_2048x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  TS1N28HPCPHVTB2048X128M8SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .Q(Q));
endmodule

module ct_umc_spsram_2048x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]   A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  TS1N28HPCPHVTB2048X144M8SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .Q(Q));
endmodule

// ====================================================================
// 4096-word variants (12-bit address) — base size for composition
// ====================================================================
module ct_umc_spsram_4096x32 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [11:0]  A; input CEN; input CLK; input [31:0] D;
  input GWEN; output [31:0] Q; input [31:0] WEN;
  TS1N28HPCPUHDSVTB4096X32M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_4096x84 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [11:0]  A; input CEN; input CLK; input [83:0] D;
  input GWEN; output [83:0] Q; input [83:0] WEN;
  TS1N28HPCPUHDSVTB4096X84M4SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(Q));
endmodule

module ct_umc_spsram_4096x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [11:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  TS1N28HPCPHVTB4096X128M8SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .Q(Q));
endmodule

module ct_umc_spsram_4096x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [11:0]   A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  TS1N28HPCPHVTB4096X144M8SW u_mem (
    .CLK(CLK), .CEB(CEN), .WEB(GWEN), .A(A), .D(D),
    .BWEB(WEN), .Q(Q));
endmodule

// ====================================================================
// 8192-word variants (13-bit address) — 2x 4096-word banks
// ====================================================================
module ct_umc_spsram_8192x32 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [12:0]  A; input CEN; input CLK; input [31:0] D;
  input GWEN; output [31:0] Q; input [31:0] WEN;
  wire cs0 = ~CEN & ~A[12];
  wire cs1 = ~CEN &  A[12];
  wire [31:0] q0, q1;
  TS1N28HPCPUHDSVTB4096X32M4SW u0 (
    .CLK(CLK), .CEB(~cs0), .WEB(GWEN), .A(A[11:0]), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(q0));
  TS1N28HPCPUHDSVTB4096X32M4SW u1 (
    .CLK(CLK), .CEB(~cs1), .WEB(GWEN), .A(A[11:0]), .D(D),
    .BWEB(WEN), .RTSEL(2'b01), .WTSEL(2'b00), .Q(q1));
  assign Q = A[12] ? q1 : q0;
endmodule

module ct_umc_spsram_8192x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [12:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  wire cs0 = ~CEN & ~A[12];
  wire cs1 = ~CEN &  A[12];
  wire [127:0] q0, q1;
  TS1N28HPCPHVTB4096X128M8SW u0 (
    .CLK(CLK), .CEB(~cs0), .WEB(GWEN), .A(A[11:0]), .D(D),
    .BWEB(WEN), .Q(q0));
  TS1N28HPCPHVTB4096X128M8SW u1 (
    .CLK(CLK), .CEB(~cs1), .WEB(GWEN), .A(A[11:0]), .D(D),
    .BWEB(WEN), .Q(q1));
  assign Q = A[12] ? q1 : q0;
endmodule

// ====================================================================
// 16384-word variants (14-bit address) — 4x 4096-word banks
// ====================================================================
module ct_umc_spsram_16384x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [13:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  wire [3:0] cs;
  wire [127:0] q0, q1, q2, q3;
  assign cs[0] = ~CEN & (A[13:12]==2'b00);
  assign cs[1] = ~CEN & (A[13:12]==2'b01);
  assign cs[2] = ~CEN & (A[13:12]==2'b10);
  assign cs[3] = ~CEN & (A[13:12]==2'b11);
  TS1N28HPCPHVTB4096X128M8SW u0 (
    .CLK(CLK), .CEB(~cs[0]), .WEB(GWEN), .A(A[11:0]), .D(D), .BWEB(WEN), .Q(q0));
  TS1N28HPCPHVTB4096X128M8SW u1 (
    .CLK(CLK), .CEB(~cs[1]), .WEB(GWEN), .A(A[11:0]), .D(D), .BWEB(WEN), .Q(q1));
  TS1N28HPCPHVTB4096X128M8SW u2 (
    .CLK(CLK), .CEB(~cs[2]), .WEB(GWEN), .A(A[11:0]), .D(D), .BWEB(WEN), .Q(q2));
  TS1N28HPCPHVTB4096X128M8SW u3 (
    .CLK(CLK), .CEB(~cs[3]), .WEB(GWEN), .A(A[11:0]), .D(D), .BWEB(WEN), .Q(q3));
  assign Q = (A[13:12]==2'b00) ? q0 :
             (A[13:12]==2'b01) ? q1 :
             (A[13:12]==2'b10) ? q2 : q3;
endmodule

// ====================================================================
// 32768-word variants (15-bit address) — 8x 4096-word banks
// ====================================================================
module ct_umc_spsram_32768x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [14:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  wire [7:0] cs;
  wire [127:0] q [7:0];
  assign cs[0] = ~CEN & (A[14:12]==3'b000);
  assign cs[1] = ~CEN & (A[14:12]==3'b001);
  assign cs[2] = ~CEN & (A[14:12]==3'b010);
  assign cs[3] = ~CEN & (A[14:12]==3'b011);
  assign cs[4] = ~CEN & (A[14:12]==3'b100);
  assign cs[5] = ~CEN & (A[14:12]==3'b101);
  assign cs[6] = ~CEN & (A[14:12]==3'b110);
  assign cs[7] = ~CEN & (A[14:12]==3'b111);
  TS1N28HPCPHVTB4096X128M8SW u0 (.CLK(CLK),.CEB(~cs[0]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[0]));
  TS1N28HPCPHVTB4096X128M8SW u1 (.CLK(CLK),.CEB(~cs[1]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[1]));
  TS1N28HPCPHVTB4096X128M8SW u2 (.CLK(CLK),.CEB(~cs[2]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[2]));
  TS1N28HPCPHVTB4096X128M8SW u3 (.CLK(CLK),.CEB(~cs[3]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[3]));
  TS1N28HPCPHVTB4096X128M8SW u4 (.CLK(CLK),.CEB(~cs[4]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[4]));
  TS1N28HPCPHVTB4096X128M8SW u5 (.CLK(CLK),.CEB(~cs[5]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[5]));
  TS1N28HPCPHVTB4096X128M8SW u6 (.CLK(CLK),.CEB(~cs[6]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[6]));
  TS1N28HPCPHVTB4096X128M8SW u7 (.CLK(CLK),.CEB(~cs[7]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[7]));
  assign Q = q[A[14:12]];
endmodule

// ====================================================================
// 65536-word variants (16-bit address) — 16x 4096-word banks (L2 cache, 1MB)
// ====================================================================
module ct_umc_spsram_65536x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [15:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  wire [15:0] cs;
  wire [127:0] q [15:0];
  assign cs[0]  = ~CEN & (A[15:12]==4'h0);
  assign cs[1]  = ~CEN & (A[15:12]==4'h1);
  assign cs[2]  = ~CEN & (A[15:12]==4'h2);
  assign cs[3]  = ~CEN & (A[15:12]==4'h3);
  assign cs[4]  = ~CEN & (A[15:12]==4'h4);
  assign cs[5]  = ~CEN & (A[15:12]==4'h5);
  assign cs[6]  = ~CEN & (A[15:12]==4'h6);
  assign cs[7]  = ~CEN & (A[15:12]==4'h7);
  assign cs[8]  = ~CEN & (A[15:12]==4'h8);
  assign cs[9]  = ~CEN & (A[15:12]==4'h9);
  assign cs[10] = ~CEN & (A[15:12]==4'ha);
  assign cs[11] = ~CEN & (A[15:12]==4'hb);
  assign cs[12] = ~CEN & (A[15:12]==4'hc);
  assign cs[13] = ~CEN & (A[15:12]==4'hd);
  assign cs[14] = ~CEN & (A[15:12]==4'he);
  assign cs[15] = ~CEN & (A[15:12]==4'hf);
  TS1N28HPCPHVTB4096X128M8SW u0  (.CLK(CLK),.CEB(~cs[0]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[0]));
  TS1N28HPCPHVTB4096X128M8SW u1  (.CLK(CLK),.CEB(~cs[1]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[1]));
  TS1N28HPCPHVTB4096X128M8SW u2  (.CLK(CLK),.CEB(~cs[2]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[2]));
  TS1N28HPCPHVTB4096X128M8SW u3  (.CLK(CLK),.CEB(~cs[3]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[3]));
  TS1N28HPCPHVTB4096X128M8SW u4  (.CLK(CLK),.CEB(~cs[4]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[4]));
  TS1N28HPCPHVTB4096X128M8SW u5  (.CLK(CLK),.CEB(~cs[5]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[5]));
  TS1N28HPCPHVTB4096X128M8SW u6  (.CLK(CLK),.CEB(~cs[6]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[6]));
  TS1N28HPCPHVTB4096X128M8SW u7  (.CLK(CLK),.CEB(~cs[7]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[7]));
  TS1N28HPCPHVTB4096X128M8SW u8  (.CLK(CLK),.CEB(~cs[8]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[8]));
  TS1N28HPCPHVTB4096X128M8SW u9  (.CLK(CLK),.CEB(~cs[9]), .WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[9]));
  TS1N28HPCPHVTB4096X128M8SW u10 (.CLK(CLK),.CEB(~cs[10]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[10]));
  TS1N28HPCPHVTB4096X128M8SW u11 (.CLK(CLK),.CEB(~cs[11]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[11]));
  TS1N28HPCPHVTB4096X128M8SW u12 (.CLK(CLK),.CEB(~cs[12]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[12]));
  TS1N28HPCPHVTB4096X128M8SW u13 (.CLK(CLK),.CEB(~cs[13]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[13]));
  TS1N28HPCPHVTB4096X128M8SW u14 (.CLK(CLK),.CEB(~cs[14]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[14]));
  TS1N28HPCPHVTB4096X128M8SW u15 (.CLK(CLK),.CEB(~cs[15]),.WEB(GWEN),.A(A[11:0]),.D(D),.BWEB(WEN),.Q(q[15]));
  assign Q = q[A[15:12]];
endmodule
