################################################################################
# User configuration
################################################################################
set PROJ_ROOT       /dfs/grphome/eeweiz/jjiangan/openc910
set RTL_ROOT        ${PROJ_ROOT}/C910_RTL_FACTORY
set SDC_ROOT        ${PROJ_ROOT}/smart_run/impl/sdc
set TOP_MODULE_NAME openC910

# C910 filelists embed paths as ${CODE_BASE_PATH}/gen_rtl/...
# Export it so read_filelist can substitute the token while loading.
set ::env(CODE_BASE_PATH) ${RTL_ROOT}

# Create a timestamped batch directory for all outputs
# Read BATCH_DIR from environment if set, otherwise auto-generate
if {[info exists ::env(BATCH_DIR)] && $::env(BATCH_DIR) ne ""} {
  set BATCH_DIR $::env(BATCH_DIR)
} else {
  set date_hour [clock format [clock seconds] -format "%Y%m%d_%H"]
  set BATCH_DIR "batch_${date_hour}"
}
file mkdir ${BATCH_DIR}/reports
file mkdir ${BATCH_DIR}/results

################################################################################
# Step 1: library setup
################################################################################
set SRAM_DB_DIR ${PROJ_ROOT}/smart_run/impl/gen_sram/db

set search_path [list . \
  /dfs/app/tsmc_icdc/tsmc028/28HPCplus_RF/SC/tcbn28hpcplusbwp30p140/tcbn28hpcplusbwp30p140_190a/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp30p140_180a/ \
  /dfs/app/tsmc_icdc/tsmc028/28HPCplus_RF/SC/tcbn28hpcplusbwp30p140hvt/tcbn28hpcplusbwp30p140hvt_190a/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp30p140hvt_180a/ \
  /dfs/app/tsmc_icdc/tsmc028/28HPCplus_RF/SC/tcbn28hpcplusbwp30p140lvt/tcbn28hpcplusbwp30p140lvt_190a/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp30p140lvt_180a/ \
  /dfs/app/tsmc_icdc/tsmc028/28HPCplus_RF/SC/tcbn28hpcplusbwp40p140ehvt/tcbn28hpcplusbwp40p140ehvt_190a/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp40p140ehvt_170a \
  ${SRAM_DB_DIR} \
]

set target_library [list \
  tcbn28hpcplusbwp30p140tt1v25c_ccs.db \
  tcbn28hpcplusbwp30p140hvttt1v25c_ccs.db \
  tcbn28hpcplusbwp30p140lvttt1v25c_ccs.db \
  tcbn28hpcplusbwp40p140ehvttt1v25c_ccs.db \
]

set sram_db_list [glob -nocomplain -directory ${SRAM_DB_DIR} *.db]
set link_library [concat [list {*}] $target_library $sram_db_list]

# naming rules
define_name_rules lab_vlog   -type  port  \
        -allowed {a-zA-Z0-9[]_} \
        -equal_ports_nets    \
        -first_restricted  "0-9_"  \
        -max_length   256
define_name_rules lab_vlog   -type  net  \
        -allowed "a-zA-Z0-9_" \
        -equal_ports_nets    \
        -first_restricted  "0-9_"  \
        -max_length   256
define_name_rules lab_vlog   -type  cell  \
        -allowed "a-zA-Z0-9_" \
        -first_restricted  "0-9_"  \
        -map {{{"\[","_","\]",""},{"\[","_"}}}  \
        -max_length   256
define_name_rules slash   -restricted  {/}  -replace  {_}

################################################################################
# Step 2: import design
################################################################################
define_design_lib WORK -path ${BATCH_DIR}/WORK

# Helper proc: read a filelist and resolve relative paths from the filelist dir.
# Also expands ${ENV_VAR} tokens (the C910 filelists use ${CODE_BASE_PATH}).
proc read_filelist {fl_path} {
    set fl_dir [file dirname $fl_path]
    set files {}
    set fp [open $fl_path r]
    while {[gets $fp line] >= 0} {
        set line [string trim $line]
        if {$line eq "" || [string match "#*" $line] || [string match "+*" $line]} continue
        while {[regexp {\$\{([A-Za-z_][A-Za-z0-9_]*)\}} $line -> var]} {
            if {![info exists ::env($var)]} {
                error "read_filelist: environment variable '$var' is not set (referenced in $fl_path)"
            }
            set line [string map [list "\${$var}" $::env($var)] $line]
        }
        lappend files [file normalize [file join $fl_dir $line]]
    }
    close $fp
    return $files
}

# Read C910 RTL filelist
set all_rtl_files [read_filelist ${RTL_ROOT}/gen_rtl/filelists/C910_asic_rtl.fl]

# --- ASIC SRAM + ICG substitution -----------------------------------------------
# The C910 RTL wrappers gen_rtl/{ifu,lsu,mmu,l2c}/rtl/ct_spsram_*.v hard-code an
# instantiation of ct_f_spsram_* (FPGA behavioral RAM, gen_rtl/fpga/rtl/), which
# DC would synthesise into a massive flip-flop array.  For ASIC synthesis we
# drop those behavioural files and substitute:
#   * ct_f_spsram_shim.v        — re-defines ct_f_spsram_* as thin wrappers that
#                                 instantiate ct_umc_spsram_* by the same port
#                                 names, so no RTL edit is needed upstream.
#   * ct_umc_spsram_wrappers.v  (smart_run/impl/MEM_INTF) — instantiates the
#                                 TSMC 28HPC+ hard macros (TS1N28HPCPUHDSVT.../
#                                 TS1N28HPCPHVT...) which are linked from the
#                                 .db files in smart_run/impl/gen_sram/db/.
#   * gated_clk_cell_syn.v      — replaces gen_rtl/clk/rtl/gated_clk_cell.v (a
#                                 non-gating pass-through stub) with a version
#                                 that instantiates the TSMC integrated
#                                 clock-gating cell, so the RTL's hand-
#                                 instantiated clock gates become real ICGs.
set asic_rtl_files {}
foreach f $all_rtl_files {
    if {[string match "*/gen_rtl/fpga/rtl/ct_f_spsram_*.v" $f]} continue
    if {[string match "*/gen_rtl/fpga/rtl/fpga_ram.v" $f]} continue
    if {[string match "*/gen_rtl/clk/rtl/gated_clk_cell.v" $f]} continue
    lappend asic_rtl_files $f
}
set MEM_INTF_DIR ${PROJ_ROOT}/smart_run/impl/MEM_INTF
set SYN_DIR      ${PROJ_ROOT}/smart_run/impl/syn
lappend asic_rtl_files \
    ${SYN_DIR}/ct_f_spsram_shim.v \
    ${SYN_DIR}/gated_clk_cell_syn.v \
    ${MEM_INTF_DIR}/ct_umc_spsram_wrappers.v

# Analyze RTL
# NOTE: .h header files contain `define macros and must be analyzed first (no
#       `include directives exist in this design — macro visibility depends on
#       compile order). The filelist already has .h files listed before the .v
#       files that use them.
analyze -format verilog $asic_rtl_files

elaborate ${TOP_MODULE_NAME}

# Link to resolve library cell references (ICG cell, TSMC SRAM macros)
# before the SDC's get_flat_pins queries the design hierarchy.
link

# store the unmapped results
write -hierarchy -format ddc -output ${BATCH_DIR}/results/${TOP_MODULE_NAME}.unmapped.ddc

################################################################################
# Step 3: constrain your design
################################################################################

# --- C910 SDC compatibility fix 1: define get_flat_pins/get_flat_cells -------
# The C910 SDC defines these procs only inside `if {$synopsys_program_name ==
# "pt_shell"}`. Under dc_shell they are undefined, causing generated-clock
# constraints (PLIC_CLK, L2C_DATA/TAG_MEM_CLOCK) to abort.
# --- Fix 2: redirect generated-clock pin lookups to BUFGCE outputs ----------
# The SDC's get_flat_pins patterns reference `gated_clk_cell` instances
# (x_apb_gated_clk, l2cache_*_ram_gated_clk) that are COMMENTED OUT in the
# released RTL (ct_mp_clk_top.v). The RTL uses BUFGCE instances instead
# (apb_clk_buf, data_bank0/1_clk_buf, tag_bank0/1_clk_buf). We redirect these
# patterns to the BUFGCE output pins so create_generated_clock succeeds.
proc get_flat_pins {arg} {
    if {[string match "*apb_gated_clk*gated_clk_cell*" $arg]} {
        set ppath ""
        if {[info exists ::parent_path]} { set ppath $::parent_path }
        return [get_pins -quiet "${ppath}x_ct_mp_clk_top/apb_clk_buf/O"]
    }
    if {[string match "*l2cache_data_ram_gated_clk*gated_clk_cell*" $arg]} {
        set ppath ""
        if {[info exists ::parent_path]} { set ppath $::parent_path }
        return [get_pins -quiet "${ppath}x_ct_mp_clk_top/data_bank*_clk_buf/O"]
    }
    if {[string match "*l2cache_tag_ram_gated_clk*gated_clk_cell*" $arg]} {
        set ppath ""
        if {[info exists ::parent_path]} { set ppath $::parent_path }
        return [get_pins -quiet "${ppath}x_ct_mp_clk_top/tag_bank*_clk_buf/O"]
    }
    return [get_pins -hier -filter "is_hierarchical==false && full_name=~$arg"]
}
proc get_flat_cells {arg} {
    return [get_cells -hier -filter "is_hierarchical==false && full_name=~$arg"]
}

# --- Fix 3: override SDC's 16nm cell names with 28HPC+ values ---------------
# The C910 SDC hardcodes `set IF_READ_BUIDIN_VARIABLES 1` and uses 16nm cell
# names (BUFFD2BWP6T16P96CPDLVT, AN2D2BWP6T16P96CPDLVT/A1). These cells don't
# exist in the TSMC 28HPC+ library, so set_driving_cell/set_load would fail.
# We use Tcl trace to intercept and force 28HPC+ values whenever the SDC
# tries to set them.
set LIB_DRIVING_CELL  "BUFFD2BWP30P140"
set LIB_LOAD_PIN      "BUFFD2BWP30P140/I"

proc _force_driving_cell {name1 name2 op} {
    set ::DRIVING_CELL $::LIB_DRIVING_CELL
}
proc _force_load_pin {name1 name2 op} {
    set ::LOAD_PIN $::LIB_LOAD_PIN
}

trace add variable DRIVING_CELL write _force_driving_cell
trace add variable LOAD_PIN     write _force_load_pin

# Source the top-level SDC (which internally sources ct_top.sdc per core)
source ${SDC_ROOT}/openC910.sdc

# Remove traces now that the SDC has been sourced
trace remove variable DRIVING_CELL write _force_driving_cell
trace remove variable LOAD_PIN     write _force_load_pin

# Create default path groups
set ports_clock_root \
  [filter_collection [get_attribute [get_clocks] sources] object_class==port]
group_path -name REGOUT -to [all_outputs]
group_path -name REGIN -from [remove_from_collection [all_inputs] \
  ${ports_clock_root}]
group_path -name FEEDTHROUGH -from \
  [remove_from_collection [all_inputs] ${ports_clock_root}] -to [all_outputs]

# Prevent assignment statements in the Verilog netlist.
set_fix_multiple_port_nets -all -buffer_constants

# Check for design errors
check_design -summary
check_design > ${BATCH_DIR}/reports/${TOP_MODULE_NAME}.check_design.rpt

################################################################################
# Step 4: compile the design (with register clock gating)
################################################################################
# Register clock gating: infer integrated clock-gating (ICG) cells on register
# banks whose enables DC can extract. The library ICGs (CKLNQD*) have a
# test-enable pin; tie the control point before the latch so scan can force
# clocks on. -minimum_bitwidth 4 avoids gating tiny banks where the ICG costs
# more than it saves.
set_clock_gating_style \
    -sequential_cell latch \
    -positive_edge_logic {integrated} \
    -negative_edge_logic  {integrated} \
    -control_point before \
    -control_signal scan_enable \
    -minimum_bitwidth 4 \
    -max_fanout 32

# Protect the hand-instantiated ICGs from gated_clk_cell_syn.v: DC may resize
# them but must not remove or restructure the clock-gate function.
set icg_insts [get_cells -quiet -hierarchical -filter "ref_name =~ CKLNQD*"]
if {[sizeof_collection $icg_insts] > 0} {
    set_size_only $icg_insts true
}

# Keep hierarchy for debug; -gate_clock enables register clock-gating insertion
compile_ultra -no_autoungroup -gate_clock

################################################################################
# Step 5: write out final design and reports
################################################################################
change_names -rules verilog -hierarchy

# Write out design
write -format verilog -hierarchy -output ${BATCH_DIR}/results/${TOP_MODULE_NAME}.mapped.v
write -format ddc -hierarchy -output ${BATCH_DIR}/results/${TOP_MODULE_NAME}.mapped.ddc
write_sdf ${BATCH_DIR}/results/${TOP_MODULE_NAME}.mapped.sdf
write_sdc -nosplit ${BATCH_DIR}/results/${TOP_MODULE_NAME}.mapped.sdc

# Write PTPX name mapping file (RTL-to-gate register name mapping)
# This is sourced by PrimePower when annotating RTL VCD/FSDB onto the gate netlist.
saif_map -type ptpx -write_map ${BATCH_DIR}/results/${TOP_MODULE_NAME}.ptpxmap.tcl
report_saif -hier -rtl -missing > ${BATCH_DIR}/reports/${TOP_MODULE_NAME}.saif_annotation.rpt

# Generate reports
report_clock_gating -gating_elements \
  > ${BATCH_DIR}/reports/${TOP_MODULE_NAME}.mapped.clock_gating.rpt
report_qor > ${BATCH_DIR}/reports/${TOP_MODULE_NAME}.mapped.qor.rpt
report_timing -transition_time -nets -attribute -nosplit \
  > ${BATCH_DIR}/reports/${TOP_MODULE_NAME}.mapped.timing.rpt
report_area -nosplit > ${BATCH_DIR}/reports/${TOP_MODULE_NAME}.mapped.area.rpt
report_area -hierarchy -nosplit > ${BATCH_DIR}/reports/${TOP_MODULE_NAME}.mapped.area_hier.rpt
report_power -hierarchy -nosplit > ${BATCH_DIR}/reports/${TOP_MODULE_NAME}.mapped.power_hier.rpt

################################################################################
# Exit Design Compiler
################################################################################
exit
