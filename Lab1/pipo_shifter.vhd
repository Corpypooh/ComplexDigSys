library ieee;
use ieee.std_logic_1164.all;
 
entity pipo_shifter is
port(
	clk, en, rst : in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0));
end pipo_shifter;
 
architecture imp of pipo_shifter is
begin
	process (Clk)
	begin
		if rising_edge(Clk) then
			if RST = '1' then
				Q <= "0000";
			else
				if EN = '1' then
					Q <= D;
				end if;
			end if;
		end if;
	end process;
end imp;