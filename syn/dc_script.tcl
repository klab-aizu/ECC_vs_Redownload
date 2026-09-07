```tcl
#
# ============================================================
# Libraries
# ============================================================

set TSV_PATH "/home/lib/TSV_lib"

set search_path [concat $search_path $TSV_PATH]

set target_library "/home/lib/typical.db"
set synthetic_library "dw_foundation.sldb"

set link_library [concat "*" $target_library $synthetic_library "TSV.db"]

set symbol_library "generic.sdb"


#
# ============================================================
# Design configuration
# ============================================================
#

# Choose design:
#   SECDED_1622_enc
#   SECDED_1622_dec

set base_name "SECDED_1622_enc"

set clock_name "clk"
set clock_period 2

set src_folder "../rtl"

set InDelay_ns 0.1
set OutDelay_ns 0.1
set clkUncertainty 0.004

set runname "net"


#
# ============================================================
# Directories
# ============================================================
#

define_design_lib WORK -path ./WORK

file mkdir ./reports
file mkdir ./output_files


#
# ============================================================
# Analyze HDL
# ============================================================
#

analyze -format verilog $src_folder/SECDED_1622_enc.v
analyze -format verilog $src_folder/SECDED_1622_dec.v


#
# ============================================================
# Elaborate
# ============================================================
#

elaborate ${base_name}

current_design ${base_name}

link

uniquify


#
# ============================================================
# Timing
# ============================================================
#

create_clock \
    -name $clock_name \
    -period $clock_period \
    [find port $clock_name]

set_clock_uncertainty \
    $clkUncertainty \
    [get_clocks $clock_name]


#
# Input delay
#
# Do not apply input delay to clk or rst_n
#

set_input_delay \
    $InDelay_ns \
    -clock $clock_name \
    [remove_from_collection [all_inputs] [get_ports "$clock_name rst_n"]]


#
# Output delay
#

set_output_delay \
    $OutDelay_ns \
    -clock $clock_name \
    [all_outputs]


#
# ============================================================
# Clock gating
# ============================================================
#

# set_clock_gating_style -sequential latch
# insert_clock_gating


#
# ============================================================
# Wire load model
# ============================================================
#

set_wire_load_model \
    -name 5K_hvratio_1_1 \
    -library NangateOpenCellLibrary


#
# ============================================================
# Synthesis
# ============================================================
#

# If you want to flatten the hierarchy:
# ungroup -all -flatten

compile -map_effort high

compile \
    -incremental_mapping \
    -map_effort high


#
# ============================================================
# Reports
# ============================================================
#

check_design \
    > ./reports/check_design_${base_name}_${runname}.txt

report_qor \
    > ./reports/summary_report_${base_name}_${runname}.txt

report_area -hierarchy \
    > ./reports/report_area_${base_name}_${runname}.txt

report_timing \
    > ./reports/report_timing_${base_name}_${runname}.txt

report_power -verbose \
    > ./reports/report_power_${base_name}_${runname}.txt


#
# ============================================================
# Output
# ============================================================
#

write -format verilog \
    -hierarchy \
    -output ./output_files/${base_name}_${runname}.v

write_sdc \
    ./output_files/${base_name}_${runname}.sdc

write_sdf \
    ./output_files/${base_name}_${runname}.sdf

write_parasitics \
    -output ./output_files/${base_name}_${runname}.spef

write_file \
    -format ddc \
    -hierarchy \
    -output ./output_files/${base_name}_${runname}.ddc


#
# ============================================================
# Exit
# ============================================================
#

exit
```
