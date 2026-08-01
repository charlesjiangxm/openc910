// SPDX-License-Identifier: Apache-2.0
//
// ASIC shim that overrides the C910 FPGA behavioral RAM models
// (gen_rtl/fpga/rtl/ct_f_spsram_*.v) with thin wrappers that delegate to
// the TSMC 28HPC+ hard-macro wrappers in
//   smart_run/impl/MEM_INTF/ct_umc_spsram_wrappers.v
//
// Used by the DC synthesis flow (see dc.tcl): the original FPGA .v files are
// filtered out of the filelist, and this shim + ct_umc_spsram_wrappers.v are
// analysed in their place.  The C910 RTL wrappers (ct_spsram_NxM, in
// gen_rtl/{ifu,lsu,mmu,l2c}/rtl/) still instantiate ct_f_spsram_NxM by name,
// so the module names below must match exactly.

`timescale 1ns/10ps

// ====================================================================
// 64-word variants (6-bit address)
// ====================================================================
module ct_f_spsram_64x108 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [5:0]    A; input CEN; input CLK; input [107:0] D;
  input GWEN; output [107:0] Q; input [107:0] WEN;
  ct_umc_spsram_64x108 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 128-word variants (7-bit address)
// ====================================================================
module ct_f_spsram_128x16 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [6:0]   A; input CEN; input CLK; input [15:0] D;
  input GWEN; output [15:0] Q; input [15:0] WEN;
  ct_umc_spsram_128x16 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_128x104 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [6:0]    A; input CEN; input CLK; input [103:0] D;
  input GWEN; output [103:0] Q; input [103:0] WEN;
  ct_umc_spsram_128x104 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_128x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [6:0]    A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  ct_umc_spsram_128x144 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 256-word variants (8-bit address)
// ====================================================================
module ct_f_spsram_256x7 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]  A; input CEN; input CLK; input [6:0] D;
  input GWEN; output [6:0] Q; input [6:0] WEN;
  ct_umc_spsram_256x7 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_256x23 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [22:0] D;
  input GWEN; output [22:0] Q; input [22:0] WEN;
  ct_umc_spsram_256x23 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_256x52 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [51:0] D;
  input GWEN; output [51:0] Q; input [51:0] WEN;
  ct_umc_spsram_256x52 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_256x54 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [53:0] D;
  input GWEN; output [53:0] Q; input [53:0] WEN;
  ct_umc_spsram_256x54 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_256x59 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [58:0] D;
  input GWEN; output [58:0] Q; input [58:0] WEN;
  ct_umc_spsram_256x59 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_256x84 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [83:0] D;
  input GWEN; output [83:0] Q; input [83:0] WEN;
  ct_umc_spsram_256x84 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_256x100 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]   A; input CEN; input CLK; input [99:0] D;
  input GWEN; output [99:0] Q; input [99:0] WEN;
  ct_umc_spsram_256x100 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_256x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]    A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  ct_umc_spsram_256x144 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_256x196 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [7:0]    A; input CEN; input CLK; input [195:0] D;
  input GWEN; output [195:0] Q; input [195:0] WEN;
  ct_umc_spsram_256x196 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 512-word variants (9-bit address)
// ====================================================================
module ct_f_spsram_512x7 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]  A; input CEN; input CLK; input [6:0] D;
  input GWEN; output [6:0] Q; input [6:0] WEN;
  ct_umc_spsram_512x7 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_512x22 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [21:0] D;
  input GWEN; output [21:0] Q; input [21:0] WEN;
  ct_umc_spsram_512x22 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_512x44 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [43:0] D;
  input GWEN; output [43:0] Q; input [43:0] WEN;
  ct_umc_spsram_512x44 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_512x52 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [51:0] D;
  input GWEN; output [51:0] Q; input [51:0] WEN;
  ct_umc_spsram_512x52 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_512x54 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [53:0] D;
  input GWEN; output [53:0] Q; input [53:0] WEN;
  ct_umc_spsram_512x54 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_512x59 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [58:0] D;
  input GWEN; output [58:0] Q; input [58:0] WEN;
  ct_umc_spsram_512x59 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_512x96 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]   A; input CEN; input CLK; input [95:0] D;
  input GWEN; output [95:0] Q; input [95:0] WEN;
  ct_umc_spsram_512x96 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_512x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [8:0]    A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  ct_umc_spsram_512x144 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 1024-word variants (10-bit address)
// ====================================================================
module ct_f_spsram_1024x32 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]   A; input CEN; input CLK; input [31:0] D;
  input GWEN; output [31:0] Q; input [31:0] WEN;
  ct_umc_spsram_1024x32 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_1024x59 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]   A; input CEN; input CLK; input [58:0] D;
  input GWEN; output [58:0] Q; input [58:0] WEN;
  ct_umc_spsram_1024x59 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_1024x64 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]   A; input CEN; input CLK; input [63:0] D;
  input GWEN; output [63:0] Q; input [63:0] WEN;
  ct_umc_spsram_1024x64 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_1024x92 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]   A; input CEN; input CLK; input [91:0] D;
  input GWEN; output [91:0] Q; input [91:0] WEN;
  ct_umc_spsram_1024x92 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_1024x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]    A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  ct_umc_spsram_1024x128 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_1024x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [9:0]    A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  ct_umc_spsram_1024x144 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 2048-word variants (11-bit address)
// ====================================================================
module ct_f_spsram_2048x32 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]  A; input CEN; input CLK; input [31:0] D;
  input GWEN; output [31:0] Q; input [31:0] WEN;
  ct_umc_spsram_2048x32 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_2048x59 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]  A; input CEN; input CLK; input [58:0] D;
  input GWEN; output [58:0] Q; input [58:0] WEN;
  ct_umc_spsram_2048x59 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_2048x88 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]  A; input CEN; input CLK; input [87:0] D;
  input GWEN; output [87:0] Q; input [87:0] WEN;
  ct_umc_spsram_2048x88 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_2048x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  ct_umc_spsram_2048x128 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_2048x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [10:0]   A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  ct_umc_spsram_2048x144 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 4096-word variants (12-bit address)
// ====================================================================
module ct_f_spsram_4096x32 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [11:0]  A; input CEN; input CLK; input [31:0] D;
  input GWEN; output [31:0] Q; input [31:0] WEN;
  ct_umc_spsram_4096x32 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_4096x84 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [11:0]  A; input CEN; input CLK; input [83:0] D;
  input GWEN; output [83:0] Q; input [83:0] WEN;
  ct_umc_spsram_4096x84 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_4096x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [11:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  ct_umc_spsram_4096x128 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_4096x144 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [11:0]   A; input CEN; input CLK; input [143:0] D;
  input GWEN; output [143:0] Q; input [143:0] WEN;
  ct_umc_spsram_4096x144 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 8192-word variants (13-bit address) — composed from 2x 4096-word macros
// ====================================================================
module ct_f_spsram_8192x32 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [12:0]  A; input CEN; input CLK; input [31:0] D;
  input GWEN; output [31:0] Q; input [31:0] WEN;
  ct_umc_spsram_8192x32 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

module ct_f_spsram_8192x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [12:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  ct_umc_spsram_8192x128 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 16384-word variants (14-bit address) — composed from 4x 4096-word macros
// ====================================================================
module ct_f_spsram_16384x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [13:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  ct_umc_spsram_16384x128 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 32768-word variants (15-bit address) — composed from 8x 4096-word macros
// ====================================================================
module ct_f_spsram_32768x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [14:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  ct_umc_spsram_32768x128 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule

// ====================================================================
// 65536-word variants (16-bit address) — composed from 16x 4096-word macros
// ====================================================================
module ct_f_spsram_65536x128 (A, CEN, CLK, D, GWEN, Q, WEN);
  input  [15:0]   A; input CEN; input CLK; input [127:0] D;
  input GWEN; output [127:0] Q; input [127:0] WEN;
  ct_umc_spsram_65536x128 u_mem (.A(A),.CEN(CEN),.CLK(CLK),.D(D),.GWEN(GWEN),.Q(Q),.WEN(WEN));
endmodule
