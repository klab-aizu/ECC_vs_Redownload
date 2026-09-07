#
# Your design
#
set design_name "SECDED_1622_dec"
set model_name "net"
set base_name "${design_name}_${model_name}"
set vnet_file "${design_name}_${model_name}.v"
set sdc_file  "${design_name}_${model_name}.sdc"
set sdf_file  "${design_name}_${model_name}.sdf"
set spef_file "${design_name}_${model_name}.spef"
set saif_file "${design_name}.saif"

#
# Libraries
#
set target_library "/home/lib/typical.db"
set synthetic_library "/home/lib/dw_foundation.sldb"
set link_library [concat "*" $target_library $synthetic_library]
set symbol_library "/home/lib/generic.sdb"

set power_enable_analysis "true"
set report_default_significant_digit 6

#
# Read post-layout netlist
#

read_file -format verilog ../syn/output_files/$vnet_file
current_design $design_name
link


#
# Delay and RC information
#
read_sdc ../syn/output_files/$sdc_file
read_sdf ../syn/output_files/$sdf_file
read_parasitics ../syn/output_files/$spef_file



#
# Read switching activity information
#
read_saif ../post_syn_power_sim/$saif_file -strip_path "tb_SECDED_1622_dec/decoder/"


report_timing > ./reports/timing_report_${base_name}.txt
report_power -verbose -hier > ./reports/power_report_${base_name}.txt
redirect –tee –append ./EW.log {print_message_info}
quit
