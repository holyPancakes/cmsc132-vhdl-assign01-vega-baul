-------------------------------------------------------------------------------
-- Filename: t_4l_vega_baul.vhdl
-- Authors: Julius Jireh Vega
--          Maru Gabriel S. Baul
--          CMSC 132 T-4L
-- Program Description: Alarm Buzzer from 6 sensors(3 in-sensors and 3 out-sensors)
--                      Testbench for Alarm Buzzer
-------------------------------------------------------------------------------

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity Definition
entity t_4l_vega_baul_tb is
end entity;

-- Architecture Definition
architecture t_4l_vega_baul_tb of t_4l_vega_baul_tb is
    signal alarm, i2, i1, i0, o2, o1, o0: std_logic;
	component t_4l_vega_baul is
			port (alarm: out std_logic;  -- alarm data output
				i2,i1,i0,o2,o1,o0: in std_logic ); -- signal data inputs from sensors(3 in-sensors, 3 out-sensors)
	end component;
	
begin --architecture

	uut: component t_4l_vega_baul port map(alarm,i2,i1,i0,o2,o1,o0); --unit under test
	main: process is
	
			variable temp: unsigned(5 downto 0);
			variable expected_alarm: std_logic;
			variable error_count: integer := 0;
			
	begin --process
	
		report "start simulation";
		
        --test all the possible combinations for 3 in-sensor and 3 out-sensor inputs
        --(2^6 = 64 combinations)
		for i in 0 to 63 loop
			temp := TO_UNSIGNED(i, 6);
            --assign each input a value from temp
			i2 <= temp(5);
			i1 <= temp(4);
			i0 <= temp(3);

			o2 <= temp(2);
			o1 <= temp(1);
			o0 <= temp(0);
			
            --delay
			wait for 10 ns;
			
            --compute expected output
			if ((i2 = '1' or i1 = '1' or i0 = '1') and (o2 = '1' or o1 = '1' or o0 = '1')) then 
				expected_alarm := '1';
			else
				expected_alarm := '0';
			end if;
			
            --test actual output based on expected output
			assert(expected_alarm = alarm)
				report "ERROR: Expected Alarm " & std_logic'image(expected_alarm) & " /= actual alarm " & 
					std_logic'image(alarm) & " at time " & time'image(now);
				
			if  (expected_alarm /= alarm)
				then error_count := error_count + 1;
			end if;
		end loop;
		
        --delay
		wait for 10 ns;
		
        --check for errors
		assert (error_count = 0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
				
		if(error_count = 0)
			then report "Simulation completed with NO errors.";
		end if;
		
		wait;
		
	end process;
end architecture t_4l_vega_baul_tb;
