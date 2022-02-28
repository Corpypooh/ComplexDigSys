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
	component pipo_shifter
	port (
	clk, en, rst : in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0));
	end component;
	
	component flipflop2
	port (
		D, clk, rst, set		: in	std_logic;
		q							: out std_logic);
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
	D_in(0) <= '0';
	flipper: flipflop2 PORT MAP (D_in(0), clk, '1', rst, Q_out(0));
	
	--State B, 1
	D_in(1) <= (Q_out(0) OR Q_out(5) OR Q_out(6) OR Q_out(7) OR Q_out(8)) AND NOT (w);

	--State C, 2
	D_in(2) <= Q_out(1) AND NOT (w);
	
	--State D, 3
	D_in(3) <= Q_out(2) AND NOT (w);
	
	--State E, 4
	D_in(4) <= (Q_out(3) OR Q_out(4)) AND NOT (w);
	
	--0000 Shifter
	shif0s: pipo_shifter PORT MAP (clk, '1', rst, D_in(4 downto 1), Q_out(4 downto 1));
	
	--State F, 5
	D_in(5) <= (Q_out(0) OR Q_out(1) OR Q_out(2) OR Q_out(3) OR Q_out(4)) AND (w);
	
	--State G, 6
	D_in(6) <= Q_out(5) AND (w);
	
	--State H, 7
	D_in(7) <= Q_out(6) AND (w);
	
	--State I, 8
	D_in(8) <= (Q_out(7) OR Q_out(8)) AND (w);
	
	--1111 Shifter
	shif1s: pipo_shifter PORT MAP (clk, '1', rst, D_in(8 downto 5), Q_out(8 downto 5));
	
	--Outputs to hardware
	LEDR(8 downto 0) <= Q_out(8 downto 0);
	z <= (Q_out(4) OR Q_out(8));
	LEDR(9) <= z;
end fsm;
