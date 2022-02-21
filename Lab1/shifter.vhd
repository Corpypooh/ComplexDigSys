library ieee;
use ieee.std_logic_1164.all;

entity shifter is
port( 
	clk,  rst, si : in std_logic;
	so : out std_logic);
end shifter;

architecture impl of shifter is
	signal tmp : std_logic_vector(3 downto 0);
begin
	process (clk)
	begin
		if rising_edge(clk) then
			tmp <= tmp(2 downto 0) & si; -- & is concatenation
		end if;
	end process;
	if rst = '1' then
		so <= '0';
	else
		so <= tmp(3); -- Copy to output
	end if;
end impl;