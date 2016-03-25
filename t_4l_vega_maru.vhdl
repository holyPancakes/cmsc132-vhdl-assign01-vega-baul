--Julius Jireh Vega
--Maru Gabriel S. Baul
--T-4L
--architecture for buzzer

library IEEE;
use IEEE.std_logic_1164.all;

entity t_4l_vega_maru is
	port (alarm: out std_logic; 
		i2,i1,i0,o2,o1,o0: in std_logic );
end t_4l_vega_maru;

architecture buzzer of t_4l_vega_maru is
begin
	alarm <= (i2 or i1 or i0) and (o2 or o1 or o0);
end architecture buzzer;
