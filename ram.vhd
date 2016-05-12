library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
port( clock, ce, RW : in std_logic;
		data_in : in std_logic_vector(7 downto 0);
		addr : in std_logic_vector(5 downto 0);
		addr_affi : in std_logic_vector(5 downto 0);
		data_out : out std_logic_vector(7 downto 0);
		data_affi : out std_logic_vector(7 downto 0)
);
end entity;

architecture arc of ram is
type tab is array (0 to 21) of std_logic_vector(7 downto 0);
signal memoire : tab := (X"11", X"15", X"53", X"54", X"C9", X"94", X"51", X"CD", X"C0", X"12", X"53", X"95", X"C0", X"CD", X"00", X"00", X"00", X"FF", X"00", X"01", X"F0", X"7E");
--signal memoire : tab := (X"08", X"47", X"86", X"C4", X"C4", X"00", X"00", X"7E", X"FE", X"12", X"53", X"95", X"C0", X"CD", X"00", X"00", X"FF", X"FF", X"00", X"01", X"28", X"18");
begin

	process(clock, ce, RW, addr)
	begin
		if(RW = '0') then
			data_out <= memoire(to_integer(unsigned(addr)));
   	else
			if rising_edge(clock) then
					if(ce = '1') then
						  memoire(to_integer(unsigned(addr))) <= data_in;
					end if;		
			end if;
		end if;
	end process;
	
	process(clock, ce, addr_affi)
	begin
		if rising_edge(clock) then
			if(ce = '1') then
				data_affi <= memoire(to_integer(unsigned(addr_affi)));
			end if;
		end if;
	end process;
end arc;