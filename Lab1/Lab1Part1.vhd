library ieee;
use ieee.std_logic_1164.all;

entity Lab1Part1 is
port(
	------------ KEY ------------
	KEY             	:in    	std_logic_vector(0);

	------------ SW ------------
	SW              	:in    	std_logic_vector(1 downto 0);

	------------ LED ------------
	LEDR            	:out   	std_logic_vector(9 downto 0);
	);
end flipflop;

architecture fsm of Lab1Part1 is
	component flipflop
	port (
		D, clk, en, rst		: in	std_logic;
		q							: out std_logic);
	end component;
	
	signal w 	 : std_logic;
	signal z		 : std_logic;
	signal D_in  : std_logic(8 downto 0);
	signal Q_out : std_logic(8 downto 0);
begin
	--Tie hardware inputs to software signals
	clk 	<= KEY(0);
	rst	<= SW(0);
	w		<= SW(1);
	
	--State A, 0
	D_in(0) <= '0';
	S0: flipflop PORT MAP (D_in(0), clk, rst, '1', Q_out(0));
	
	--State B, 1
	D_in(1) <= (Q_out(0) OR Q_out(5) OR Q_out(6) OR Q_out(7) OR Q_out(8)) AND NOT (w);
	S1: flipflop PORT MAP (D_in(1), clk, rst, '1', Q_out(1));
	
	--State C, 2
	D_in(2) <= (Q_out(1)) AND NOT (w);
	S2: flipflop PORT MAP (D_in(2), clk, rst, '1', Q_out(2));
	
	--State D, 3
	D_in(3) <= (Q_out(2)) AND NOT (w);
	S3: flipflop PORT MAP (D_in(3), clk, rst, '1', Q_out(3));
	
	--State E, 4
	D_in(4) <= (Q_out(3) OR Q_out(4)) AND NOT (w);
	S4: flipflop PORT MAP (D_in(4), clk, rst, '1', Q_out(4));
	
	--State F, 5
	D_in(5) <= (Q_out(0) OR Q_out(1) OR Q_out(2) OR Q_out(3) OR Q_out(4)) AND (w);
	S5: flipflop PORT MAP (D_in(5), clk, rst, '1', Q_out(5));
	
	--State G, 6
	D_in(6) <= (Q_out(5)) AND (w);
	S6: flipflop PORT MAP (D_in(6), clk, rst, '1', Q_out(6));
	
	--State H, 7
	D_in(7) <= (Q_out(6)) AND (w);
	S7: flipflop PORT MAP (D_in(7), clk, rst, '1', Q_out(7));
	
	--State I, 8
	D_in(8) <= (Q_out(7) OR Q_out(8)) AND (w);
	S8: flipflop PORT MAP (D_in(8), clk, rst, '1', Q_out(8));
	
	--Outputs to hardware
	LEDR(8 downto 0) <= Q_out(8 downto 0);
	z <= (Q_out(4) OR Q_out(8));
	LEDR(9) <= z;
end fsm;
