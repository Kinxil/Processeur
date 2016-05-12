library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port ( D : in STD_LOGIC_VECTOR (5 downto 0);
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           CE : in STD_LOGIC;
           Load : in STD_LOGIC;
           Inc : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (5 downto 0));
end PC;

architecture Behavioral of PC is
signal temp : STD_LOGIC_VECTOR (5 downto 0);
begin

process(Reset,Clk,CE,Load,Inc,temp)
begin
	if Reset='0' then
		temp <= (others=>'0');
	elsif rising_edge(Clk) then
		if CE = '1' then
			if Load = '1' then
				temp <= D;
			elsif Inc = '1' then
				temp <= std_logic_vector(unsigned(temp)+ 1);
			end if;
		end if;
	end if;
end process;

	Q<=temp;

end Behavioral;
