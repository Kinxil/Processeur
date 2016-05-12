library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UAL is
Port (
	Sel_UAL : in std_logic;
	R1, accu_in : in std_logic_vector(7 downto 0);
	c: inout std_logic;
	accu_out : out std_logic_vector(7 downto 0));
end entity;

architecture arc of UAL is
signal value, acc, acc_out : signed(8 downto 0);
begin

	value <= signed('0' & R1 );
	acc <= signed( '0' & accu_in );
	
	with Sel_UAL select
		acc_out <= acc nor value when '0',
			acc + value when '1',
					  acc_out when others;
	with Sel_UAL select
		c <= acc_out(8) when '1',
					c when others;
					
	accu_out <= std_logic_vector(acc_out(7 downto 0));
	
end arc;