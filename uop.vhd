library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uop is
port ( clock, ce, clear, sel_ual, loadR, loadC, loadA, reset : in std_logic;
		 data_in : in std_logic_vector(7 downto 0);
		 c : inout std_logic;
		 data_out : out std_logic_vector(7 downto 0));
end entity;

architecture arc of uop is

component UAL
Port (
	Sel_UAL : in std_logic;
	R1, accu_in : in std_logic_vector(7 downto 0);
	c : inout std_logic;
	accu_out : out std_logic_vector(7 downto 0));
end component;

component carry
Port ( clock, ce, clear, load, reset, C : in std_logic;
		 carry_out : inout std_logic);
end component;

component registre
port ( clock, ce, load, reset : in std_logic;
		 data_in : in std_logic_vector(7 downto 0);
		 data_out : inout std_logic_vector(7 downto 0)
		 );
end component;

signal R1 : std_logic_vector(7 downto 0);
signal ACCU : std_logic_vector(7 downto 0);
signal ACCUOUT : std_logic_vector(7 downto 0);
signal Ca : std_logic;

begin

ual_inst : UAL port map(sel_ual, R1, ACCU, Ca, ACCUOUT);
carry_inst : carry port map(clock, ce, clear, loadC, reset, Ca, c);
R1_inst : registre port map(clock, ce, loadR, reset, data_in, R1); 
accu_inst : registre port map(clock, ce, loadA, reset, ACCUOUT, ACCU);

data_out <= ACCU;
end arc;