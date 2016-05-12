library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registre is
port ( clock, ce, reset, load: in std_logic;
		 data_in : in std_logic_vector(7 downto 0);
		 data_out : inout std_logic_vector(7 downto 0)
		 );
end entity;

architecture arc of registre is

begin
	
	process(clock, reset)
	begin
		if(reset = '0') then
			data_out <= (others => '0');
		else
			if rising_edge(clock) then
				if(ce = '1') then
					if(load = '1') then
						data_out <= data_in;
					end if;
				else 
					data_out <= data_out;
				end if;
			end if;
		end if;
	end process;

end arc;