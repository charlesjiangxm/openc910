#!/bin/tcsh
# Generate all SRAM macros required by openc910 (ct_spsram_* / ct_f_spsram_*)
# using TSMC 28HPC+ mc-2 compilers.
# Usage: source gen_sram.sh
#
# All C910 SRAM wrappers expose the canonical T-Head SP-SRAM pinout
# (A, CEN, CLK, D, GWEN, Q, WEN) with WE_WIDTH == DATA_WIDTH (per-bit BWEB).
# BWEB is enabled by default (no -NonBWEB flag).
#
# Three compiler types are used:
#   d127 (HVT, byte-write, 8:1 mux):
#     1024x64, 1024x128, 1024x144, 2048x128, 2048x144, 4096x128, 4096x144
#   UHD (SVT, write-mask, 4:1 mux):
#     64x108, 128x104, 128x144, 256x84, 256x100, 256x128, 256x144,
#     512x96, 512x144, 1024x92, 2048x32, 2048x59, 2048x88, 4096x32, 4096x84
#   UHD (SVT, write-mask, 2:1 mux):
#     128x16, 256x7, 256x23, 256x52, 256x54, 256x59, 256x68,
#     512x7, 512x22, 512x44, 512x52, 512x54, 512x59, 1024x32
#
# Large L2-cache arrays (>4096 words: 8192/16384/32768/65536 x 128/32) are
# composed from 4096-word base macros in ct_umc_spsram_wrappers.v — no
# compiler macros are generated for them.

# ---------------------------------------------------------------
# preparation
# ---------------------------------------------------------------
rm -rf ts1*1*0a ts5*1*0a

source /dfs/app/tsmc_icdc/tsmc028/28HPCplus_RF/SRAM/Compiler/tsmc_n28hpcpmc_20120200_110a/cshrc.mc2

# ---------------------------------------------------------------
# generate (high-density 1-port SRAM, HVT, byte-write 8:1 mux):
#   TS1N28HPCPHVTB{W}X{D}M8SW
# ---------------------------------------------------------------
setenv MC_HOME /dfs/app/tsmc_icdc/tsmc028/28HPCplus_RF/SRAM/Compiler/tsn28hpcpd127spsram_20120200_180a
${MC_HOME}/tsn28hpcpd127spsram_180a.pl -file config/ts1n_28hpcp_hvt_m8s_w.txt \
    -NonBIST -NonAWT

# ---------------------------------------------------------------
# generate (ultra-high-density 1-port SRAM, SVT, write-mask 4:1 mux):
#   TS1N28HPCPUHDSVTB{W}X{D}M4SW
# ---------------------------------------------------------------
setenv MC_HOME /dfs/app/tsmc_icdc/tsmc028/28HPCplus_RF/SRAM/Compiler/tsn28hpcpuhdspsram_20120200_170a
${MC_HOME}/tsn28hpcpuhdspsram_170a.pl -file config/ts1n_28hpcp_uhd_svt_m4s_w.txt \
    -SVT -NonBIST

# ---------------------------------------------------------------
# generate (ultra-high-density 1-port SRAM, SVT, write-mask 2:1 mux):
#   TS1N28HPCPUHDSVTB{W}X{D}M2SW
# ---------------------------------------------------------------
setenv MC_HOME /dfs/app/tsmc_icdc/tsmc028/28HPCplus_RF/SRAM/Compiler/tsn28hpcpuhdspsram_20120200_170a
${MC_HOME}/tsn28hpcpuhdspsram_170a.pl -file config/ts1n_28hpcp_uhd_svt_m2s_w.txt \
    -SVT -NonBIST -NonSLP -NonSD

echo ""
echo "SRAM generation complete. Run cvrt_lib2db.sh to convert .lib to .db."
