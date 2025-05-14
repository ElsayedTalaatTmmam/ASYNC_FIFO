vlib work
vlog -f source_file.txt
vsim -voptargs=+accs work.ASYNC_FIFO_TB
add wave *

run -all