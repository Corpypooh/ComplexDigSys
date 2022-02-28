library ieee;
use ieee.std_logic_1164.all;

entity flipflop is
port(
	D, Clk, RST, SET	:	in		std_logic;
	Q			:	out	std_logic);
end flipflop;

architecture imp of flipflop is
begin
	process (Clk)
	begin
		if rising_edge(Clk) then
			if SET = '1' then
				Q <= D;
			elsif RST = '1' then
				Q <= '0';
			end if;
		end if;
	end process;
end imp;
