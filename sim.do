
vsim -voptargs=+acc work.contour_top_tb
add wave -position insertpoint sim:/contour_top_tb/dut/*
run 0.0062ms
