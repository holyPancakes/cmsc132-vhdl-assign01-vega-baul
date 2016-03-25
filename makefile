run:
	ghdl -a t_4l_vega_maru.vhdl
	ghdl -a t_4l_vega_maru_tb.vhdl
	ghdl -e t_4l_vega_maru_tb
	ghdl -r t_4l_vega_maru_tb --vcd=t_4l_vega_maru.vcd
	gtkwave t_4l_vega_maru.vcd
