library ieee;
use ieee.std_logic_1164.all;

entity Lab1Part1_tb is
end Lab1Part1_tb;

architecture tb of Lab1Part1_tb is
	signal clk, w	: std_logic := '0';
	signal rst : std_logic := '1';
	signal z : std_logic	:= '0';
	signal y : std_logic_vector(8 downto 0);
begin
	clk <= not clk after 1 ms;
	
	process
	begin
	wait for 2 ms;
	rst <= '0';
	wait for 1 ns;
	w <= '1';
	wait for 10 ms;
	w <= '0';
	wait for 10 ms;
	end process;
	
	UUT : entity work.Lab1Part1_b port map (KEY(0) => clk, KEY(1) => '0', SW(1) => w, SW(0) => rst, LEDR(8 downto 0) => y(8 downto 0), LEDR(9) => z);
	
end tb;
