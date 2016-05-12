library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxPC is
    Port ( PC_in : in STD_LOGIC_VECTOR (5 downto 0);
           RI_in : in STD_LOGIC_VECTOR (5 downto 0);
           sel_addr : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (5 downto 0));
end MuxPC;

architecture Behavioral of MuxPC is

begin
	data_out <= PC_in when sel_addr = '0' else RI_in;

end Behavioral;
