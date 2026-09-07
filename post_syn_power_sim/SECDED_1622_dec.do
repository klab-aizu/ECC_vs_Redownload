vlib work
vmap work work

# compile
vlog /home/lib/cells.v
vlog ../syn/output_files/SECDED_1622_dec_net.v
vlog ../syn/output_files/SECDED_1622_enc_net.v
vlog ../tb/tb_SECDED_1622_dec

# simulate

vsim -t 1ps -voptargs="+acc" -sdfmax /decoder=./verilog_files/SECDED_1622_dec_net.sdf -sdfnoerror -L work +no_neg_tcheck tb_SECDED_1622_dec

power add /tb_SECDED_1622_dec/decoder/*

# add wave to the view
add wave /*

run -all
power report -all -bsaif SECDED_1622_dec.saif

exit