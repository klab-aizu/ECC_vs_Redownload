vlib work
vmap work work

# compile
vlog ../rtl/SECDED_1622_dec.v
vlog ../rtl/SECDED_1622_enc.v
vlog ../tb/tb_SECDED_1622_dec.v

# simulate

vsim -voptargs="+acc" work.tb_SECDED_1622_dec

# add wave to the view
add wave /*

# run the simulation
run -all