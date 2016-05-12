library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IR is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           CE : in STD_LOGIC;
           Load : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end IR;

architecture Behavioral of IR is
begin

process(Reset,Clk)
begin
	if Reset='0' then
		Q <= (others=>'0');
	elsif rising_edge(Clk) then
		if CE='1' then
			if Load = '1' then
				Q <= D;
			end if;
		end if;
	end if;
end process;

end Behavioral;
