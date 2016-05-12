----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:40:00 02/15/2011 
-- Design Name: 
-- Module Name:    CPU_8bits - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU is
    Port ( Clk : in  STD_LOGIC;
	      Ce : in  STD_LOGIC;
        Reset : in  STD_LOGIC;  
        cmd_up : in STD_LOGIC;
        cmd_down : in STD_LOGIC;
			  Adr : out  STD_LOGIC_VECTOR (5 downto 0);
			  data_men_in : out  STD_LOGIC_VECTOR (7 downto 0);
			  data_men_out : out  STD_LOGIC_VECTOR (7 downto 0);
			  Adr_affi : out  STD_LOGIC_VECTOR (5 downto 0);
			  data_affi : out std_logic_vector(7 downto 0)
			 );
end CPU;

architecture Behavioral of CPU is

component UC
  Port ( Clk : in STD_LOGIC; --Horloge
           Reset : in STD_LOGIC; --Reset
           CE : in STD_LOGIC; --Clock Enable commun à tout le monde
           Carry : in STD_LOGIC; -- Sortie du module Carry
           UM_in : in STD_LOGIC_VECTOR(7 downto 0); -- Lecture mémoire UM
           W_Mem : out STD_LOGIC; -- 0 > Read, 1 > Write
           Clear_Carry : out STD_LOGIC; -- Ordre de Reset de la carry
           Sel_UAL : out STD_LOGIC; -- Sélection de l'opération ADD/NOR
           Load_Reg1 : out STD_LOGIC; -- Ordre de chargement du registre R1
           Load_Reg_Accu : out STD_LOGIC; -- Ordre de chargement de l'accumulateur
           Load_Reg_Carry : out  STD_LOGIC; -- Ordre de chargement de la Carry
           UM_addr : out STD_LOGIC_VECTOR (5 downto 0)); -- Adresse mémoire UM
end component;

component uop
port ( clock, ce, clear, sel_ual, loadR, loadC, loadA, reset : in std_logic;
		 data_in : in std_logic_vector(7 downto 0);
		 c : inout std_logic;
		 data_out : out std_logic_vector(7 downto 0));
end component;

component ram 
port( clock, ce, RW : in std_logic;
		data_in : in std_logic_vector(7 downto 0);
		addr : in std_logic_vector(5 downto 0);
		addr_affi : in std_logic_vector(5 downto 0);
		data_out : out std_logic_vector(7 downto 0);
		data_affi : out std_logic_vector(7 downto 0)
);
end component;

component mem_brw
Port ( clk : in STD_LOGIC;
		ce : in STD_LOGIC;
		reset : in STD_LOGIC;
		cmd_up : in STD_LOGIC;
		cmd_down : in STD_LOGIC;
		addr_affi : out STD_LOGIC_VECTOR (5 downto 0));
end component;

signal Data_Mem_Unit		: STD_LOGIC_VECTOR (7 downto 0);
signal Data_Unit_Mem		: STD_LOGIC_VECTOR (7 downto 0);
signal sig_Adr          : STD_LOGIC_VECTOR (5 downto 0);
signal addr_affi 				: STD_LOGIC_VECTOR (5 downto 0);
signal Carry 		 		: STD_LOGIC;
signal Clear_Carry		: STD_LOGIC;
signal Enable_Mem			: STD_LOGIC;
signal Load_Reg1			: STD_LOGIC;
signal Load_Reg_Accu 	: STD_LOGIC;
signal Load_Reg_Carry 	: STD_LOGIC;
signal Sel_UAL_UT			: STD_LOGIC_VECTOR (2 downto 0);
signal Sel_UAL_UC			: STD_LOGIC;
signal W_Mem  				: STD_LOGIC;


begin

UC1 : UC port map (Clk, Reset, Ce, Carry, Data_Mem_Unit, W_Mem, Clear_Carry, Sel_UAL_UC, Load_Reg1, Load_Reg_Accu, Load_Reg_Carry, sig_Adr);												  
UT  : uop port map (Clk, Ce, Clear_Carry, sel_ual_UC, Load_Reg1, Load_Reg_Carry, Load_Reg_Accu, reset, Data_Mem_Unit, Carry, Data_Unit_Mem);													  
UM  : ram port map (Clk, Ce, W_Mem, Data_Unit_Mem, sig_Adr, addr_affi, Data_Mem_Unit, data_affi);
MEMBRW : mem_brw port map (Clk, Ce, Reset, cmd_up, cmd_down, addr_affi);

Adr <= sig_Adr;
Adr_Affi <= addr_affi;
data_men_in  <= Data_Unit_Mem;
data_men_out <= Data_Mem_Unit;												 

end Behavioral;

