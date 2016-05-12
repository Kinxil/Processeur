library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
port(clk, reset : in std_logic;
		 cmd_up : in STD_LOGIC;
     cmd_down : in STD_LOGIC;
     AN : out std_logic_vector(7 downto 0);
     S : out std_logic_vector(7 downto 0)
);
end entity;

architecture arc of top is
component CPU 
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
end component;
 
component acces_carte
port (	 clk : in std_logic;
	 		 reset  : in std_logic;
       AdrLSB : in std_logic_vector(3 downto 0);
       AdrMSB : in std_logic_vector(1 downto 0);
       DataLSB: in std_logic_vector(3 downto 0);
       DataMSB: in std_logic_vector(3 downto 0);
       AdrAffiLSB : in std_logic_vector(3 downto 0);
       AdrAffiMSB : in std_logic_vector(1 downto 0);
       DataAffiLSB: in std_logic_vector(3 downto 0);
       DataAffiMSB: in std_logic_vector(3 downto 0);
       DataInMem: in std_logic_vector(7 downto 0);
	 		 ce1s  : out std_logic;
	 		 ce25M : out std_logic;
	 		 AN : out std_logic_vector(7 downto 0);
	 		 S : out std_logic_vector(7 downto 0);
	 		 LED  : out std_logic_vector(7 downto 0);
			 LEDg : out std_logic);			
end component;

signal adr : std_logic_vector(5 downto 0);
signal data_in, data_out : std_logic_vector(7 downto 0);
signal addr_affi : std_logic_vector(5 downto 0);
signal data_affi : std_logic_vector(7 downto 0);
signal ce, ce25: std_logic;
signal LED  : std_logic_vector(7 downto 0);
signal LEDg : std_logic;

begin 

	inst1 : CPU port map(clk, ce, reset, cmd_up, cmd_down, adr, data_in, data_out, addr_affi, data_affi);
	inst2 : acces_carte port map(clk, reset, adr(3 downto 0), adr(5 downto 4), data_out(3 downto 0), data_out(7 downto 4), 
	addr_affi(3 downto 0), addr_affi(5 downto 4), data_affi(3 downto 0), data_affi(7 downto 4), 
	data_in, ce, ce25, AN, S, LED, LEDg);     
end arc;