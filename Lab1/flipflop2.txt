library ieee;
use ieee.std_logic_1164.all;

entity flipflop2 is
port(
	D, Clk, RST, SET	:	in		std_logic;
	Q			:	out	std_logic);
end flipflop2;

architecture imp of flipflop2 is
begin
	process (Clk)
	begin
		if rising_edge(Clk) then
			if SET = '1' then
				Q <= '1';
			elsif RST = '1' then
				Q <= '0';
			else
				if SET = '0' then
					Q <= D;
				end if;
			end if;
		end if;
	end process;
end imp;
