library ieee;
use ieee.std_logic_1164.all;

entity flipflop is
port(
	D, Clk, EN, RST	:	in		std_logic;
	Q			:	out	std_logic);
end flipflop;

architecture imp of flipflop is
begin
	process (Clk)
	begin
		if rising_edge(Clk) then
			if RST = '1' then
				Q <= '0';
			else
				if EN = '1' then
					Q <= D;
				end if;
			end if;
		end if;
	end process;
end imp;
