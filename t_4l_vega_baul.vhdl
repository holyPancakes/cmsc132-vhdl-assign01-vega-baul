-------------------------------------------------------------------------------
-- Filename: t_4l_vega_baul.vhdl
-- Authors: Julius Jireh Vega
--          Maru Gabriel S. Baul
--          CMSC 132 T-4L
-- Program Description: Alarm Buzzer from 6 sensors(3 in-sensors and 3 out-sensors)
--                      Architecture for Buzzer
-------------------------------------------------------------------------------

-- Library Statements
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity Definition
entity t_4l_vega_baul is
	port (alarm: out std_logic; -- alarm data output
		i2,i1,i0,o2,o1,o0: in std_logic ); -- signal data inputs from sensors(3 in-sensors, 3 out-sensors)
end t_4l_vega_baul;

-- Architecture Definition
architecture buzzer of t_4l_vega_baul is
begin
	alarm <= (i2 or i1 or i0) and (o2 or o1 or o0); 
end architecture buzzer;
