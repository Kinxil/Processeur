library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry is
Port ( clock, ce, clear, load, reset, C : in std_logic;
		 carry_out : inout std_logic);
end entity;

architecture arc of carry is
begin

	process(clock, reset)
	begin
		if reset = '0' then
			carry_out <= '0';
		else
			if rising_edge(clock) then
				if(ce = '1') then
					if(clear = '1') then
						carry_out <= '0';
					elsif(load = '1') then
						carry_out <= C;
					else
						carry_out <= carry_out;
					end if;
				end if;
			end if;
		end if;
	end process;


end arc;