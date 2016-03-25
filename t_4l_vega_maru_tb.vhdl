--Julius Jireh Vega
--Maru Gabriel S. Baul
--T-4L
--testbench for buzzer

library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity t_4l_vega_maru_tb is
end entity;

architecture t_4l_vega_maru_tb of t_4l_vega_maru_tb is
    signal alarm, i2, i1, i0, o2, o1, o0: std_logic;
	component t_4l_vega_maru is
			port (alarm: out std_logic; 
				i2,i1,i0,o2,o1,o0: in std_logic );
	end component;
	
begin --architecture

	uut: component t_4l_vega_maru port map(alarm,i2,i1,i0,o2,o1,o0);
	main: process is
	
			variable temp: unsigned(5 downto 0);
			variable expected_alarm: std_logic;
			variable error_count: integer := 0;
			
	begin --process
	
		report "start simulation";
		
		for i in 0 to 63 loop
			temp := TO_UNSIGNED(i, 6);
			i2 <= temp(5);
			i1 <= temp(4);
			i0 <= temp(3);

			o2 <= temp(2);
			o1 <= temp(1);
			o0 <= temp(0);
			
			wait for 10 ns;
			
			if ((i2 = '1' or i1 = '1' or i0 = '1') and (o2 = '1' or o1 = '1' or o0 = '1')) then 
				expected_alarm := '1';
			else
				expected_alarm := '0';
			end if;
			
			assert(expected_alarm = alarm)
				report "ERROR: Expected Alarm " & std_logic'image(expected_alarm) & " /= actual alarm " & 
					std_logic'image(alarm) & " at time " & time'image(now);
				
			if  (expected_alarm /= alarm)
				then error_count := error_count + 1;
			end if;
		end loop;
		
		wait for 10 ns;
		
		assert (error_count = 0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
				
		if(error_count = 0)
			then report "Simulation completed with NO errors.";
		end if;
		
		wait;
		
	end process;
end architecture t_4l_vega_maru_tb;
