library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM is
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
end FSM;

architecture Behavioral of FSM is

type state_type is (init, fetch_ins, decode, store, jcc, fetch_op, exe_nor_add);  
signal current_s, next_s: state_type;

begin
process (Clk,Reset,CE)
begin
	if (Reset='0') then
		current_s <= init;  --default state on reset.
	elsif (rising_edge(clk)) then
		if (CE = '1') then
  			current_s <= next_s;   --state change.
  	end if;
  end if;
end process;

--state machine process.
process (current_s, RI_OP, Carry)
begin
	case current_s is
	when init => 
		Sel_UAL <= '0'; --Pas important
		Load_Reg1 <= '0'; --clear ?
		Load_Reg_Accu <= '0'; --clear ?
		Clear_Carry <= '1';
		Load_Reg_Carry <= '0';
		W_MEM <= '0';
		Load_PC <= '0';
		Inc_PC <= '0';
		Load_IR <= '0';
		Mux_Addr <= '0';
		next_s <= fetch_ins;
			
	when fetch_ins => 
		Sel_UAL <= '0'; --Pas important
		Load_Reg1 <= '0'; 
		Load_Reg_Accu <= '0';
		Clear_Carry <= '0';
		Load_Reg_Carry <= '0';
		W_MEM <= '0';
		Load_PC <= '0';
		Inc_PC <= '1';
		Load_IR <= '1';
		Mux_Addr <= '0'; 	
		next_s <= decode;

	when decode => 
		Sel_UAL <= '0'; --Pas important
		Load_Reg1 <= '0'; 
		Load_Reg_Accu <= '0';
		Clear_Carry <= '0';
		Load_Reg_Carry <= '0';
		W_MEM <= '0';
		Load_PC <= '0';
		Inc_PC <= '0';
		Load_IR <= '0';
		Mux_Addr <= '1'; 	
		if(RI_OP ="11") then
			next_s <= jcc;
		elsif(RI_OP="10") then
			next_s <= store;
		else
			next_s <= fetch_op;
		end if;

	when jcc =>
		Sel_UAL <= '0'; --Pas important
		Load_Reg1 <= '0'; 
		Load_Reg_Accu <= '0';
		Load_Reg_Carry <= '0';
		W_MEM <= '0';
		Inc_PC <= '0';
		Load_IR <= '0';
		Mux_Addr <= '0'; -- 
		next_s <= fetch_ins;
		if carry='0' then
			Load_PC <= '1';
			Clear_Carry <= '0';
		else
			Load_PC <= '0';
			Clear_Carry <= '1';
		end if;
		
	when store =>
		Sel_UAL <= '0'; --Pas important
		Load_Reg1 <= '0'; 
		Load_Reg_Accu <= '0';
		Clear_Carry <= '0';
		Load_Reg_Carry <= '0';
		W_MEM <= '1';
		Load_PC <= '0';
		Inc_PC <= '0';
		Load_IR <= '0';
		Mux_Addr <= '1';  
		next_s <= fetch_ins;
	
	when fetch_op => 
		Sel_UAL <= '0'; --Pas important
		Load_Reg1 <= '1'; 
		Load_Reg_Accu <= '0';
		Clear_Carry <= '0';
		Load_Reg_Carry <= '0';
		W_MEM <= '0';
		Load_PC <= '0';
		Inc_PC <= '0';
		Load_IR <= '0';
		Mux_Addr <= '1';
		next_s <= exe_nor_add;
		
	when exe_nor_add => 
		Sel_UAL <= RI_OP(0); --Recuperation de l'operande add/nor
		Load_Reg1 <= '0'; 
		Load_Reg_Accu <= '1';
		Clear_Carry <= '0';
		Load_Reg_Carry <= '1';
		W_MEM <= '0';
		Load_PC <= '0';
		Inc_PC <= '0';
		Load_IR <= '0';
		Mux_Addr <= '1';
		next_s <= fetch_ins;
	end case;
end process;

end Behavioral;