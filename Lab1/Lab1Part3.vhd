library ieee;
use ieee.std_logic_1164.all;

entity Lab1Part3 is
port(
	------------ KEY ------------
	KEY             	:in    	std_logic_vector(1 downto 0);

	------------ SW ------------
	SW              	:in    	std_logic_vector(1 downto 0);

	------------ LED ------------
	LEDR            	:out   	std_logic_vector(9 downto 0)
	);
end Lab1Part3;

architecture fsm of Lab1Part3 is
	component shifter
	port (
		clk, rst, si	: in	std_logic;
		so					: out std_logic);
	end component;
	
	signal clk	 : std_logic;
	signal rst	 : std_logic;
	signal w 	 : std_logic;
	signal z		 : std_logic;
	signal D_in  : std_logic_vector(8 downto 0);
	signal Q_out : std_logic_vector(8 downto 0);
begin
	--Tie hardware inputs to software signals
	clk 	<= KEY(0);
	rst	<= SW(0);
	w		<= SW(1);
	
	--State A, 0
	D_in(0) <= rst; 
	S0: shifter PORT MAP (D_in(0), clk, rst, Q_out(0));
	
	-- Shifter 0000
	D_in(1) <= (
				(Q_out(0) OR Q_out(5) OR Q_out(6) OR Q_out(7) OR Q_out(8)) AND NOT (w)) OR ( -- B
				(Q_out(1)) AND NOT (w)) OR ( -- C
				(Q_out(2)) AND NOT (w)) OR ( -- D
				(Q_out(3) OR Q_out(4)) AND NOT (w)); -- E
	shif0s: shifter PORT MAP (D_in(1), clk, rst, Q_out(4));
	
	--Shifter 1111
	D_in(5) <= (
				(Q_out(0) OR Q_out(1) OR Q_out(2) OR Q_out(3) OR Q_out(4)) AND (w)) AND ( -- F
				(Q_out(5)) AND (w)) AND ( -- G
				(Q_out(6)) AND (w)) AND ( -- H
				(Q_out(7) OR Q_out(8)) AND (w)); -- I
	shif1s: shifter PORT MAP (D_in(5), clk, rst, Q_out(8));
	
	--Outputs to hardware
	LEDR(8 downto 0) <= Q_out(8 downto 0);
	z <= (Q_out(4) OR Q_out(8));
	LEDR(9) <= z;
end fsm;
