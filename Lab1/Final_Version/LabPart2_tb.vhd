library ieee;
use ieee.std_logic_1164.all;

entity LabPart2_tb is
end entity LabPart2_tb;

architecture tb of LabPart2_tb is
	signal clk, w	: std_logic := '0';
	signal rst : std_logic := '0';
	signal z : std_logic;
	signal y : std_logic_vector(8 downto 0);
	signal bunk : std_logic := '0';
begin
	clk <= not clk after 200 ms;
	
	rst <= not rst after 5000 ms;
	
	process
	begin
	w <= '1';
	wait for 400 ms;
	--w <= '0';
	--wait for 100 ms;
	end process;
	
	UUT : entity work.Lab1Part2 port map (KEY(0) => clk, KEY(1) => bunk, SW(1) => w, SW(0) => rst, LEDR(8 downto 0) => y(8 downto 0), LEDR(9) => z);
	
end tb;