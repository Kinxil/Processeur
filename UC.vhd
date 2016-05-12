library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
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
end UC;

architecture Behavioral of UC is

signal Load_IR, Load_PC, Inc_PC, Mux_addr : STD_LOGIC;
signal Q_IR : STD_LOGIC_VECTOR (7 downto 0);
signal Q_PC : STD_LOGIC_VECTOR (5 downto 0);

component FSM
	Port ( Clk : in STD_LOGIC;
    	   Reset : in STD_LOGIC;
    	   CE : in STD_LOGIC;
           Carry : in STD_LOGIC;
           RI_OP : in STD_LOGIC_VECTOR (1 downto 0); 
           W_Mem : out STD_LOGIC;
           Load_Reg1 : out STD_LOGIC;
           Load_Reg_Accu : out STD_LOGIC;
           Clear_Carry : out STD_LOGIC;
           Load_Reg_Carry : out  STD_LOGIC;
           Load_IR : out STD_LOGIC;
           Load_PC : out STD_LOGIC;
           Inc_PC : out STD_LOGIC;
           Mux_addr : out STD_LOGIC;
           Sel_UAL: out STD_LOGIC);
end component;

component PC
    Port ( D : in STD_LOGIC_VECTOR (5 downto 0);
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           CE : in STD_LOGIC;
           Load : in STD_LOGIC;
           Inc : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (5 downto 0));
end component;

component IR
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           CE : in STD_LOGIC;
           Load : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component MuxPC
	Port ( PC_in : in STD_LOGIC_VECTOR (5 downto 0);
           RI_in : in STD_LOGIC_VECTOR (5 downto 0);
           sel_addr : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (5 downto 0));
end component;

begin
	uFSM : FSM
	port map (Clk,Reset,CE,Carry,Q_IR(7 downto 6),W_Mem,Load_Reg1,Load_Reg_Accu,
	Clear_Carry,Load_Reg_Carry,Load_IR,Load_PC,Inc_PC,Mux_addr,Sel_UAL);

	uIR : IR
	port map (UM_in,Clk,Reset,CE,Load_IR,Q_IR);
	
	uPC : PC
	port map (Q_IR(5 downto 0),Clk,Reset,CE,Load_PC,Inc_PC,Q_PC);
	
	uMuxPC : MuxPC
	port map (Q_PC,Q_IR(5 downto 0),Mux_addr,UM_addr);
end Behavioral;
