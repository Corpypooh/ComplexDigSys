library ieee; 
use ieee.std_logic_1164.all; 

entity Lab1Part2 is
port(
	------------ KEY ------------
	KEY             	:in    	std_logic_vector(1 downto 0);

	------------ SW ------------
	SW              	:in    	std_logic_vector(1 downto 0);

	------------ LED ------------
	LEDR            	:out   	std_logic_vector(9 downto 0)
	);
end Lab1Part2;

architecture fsm2 of Lab1Part2 is 
	
	signal clk	 : std_logic;
	signal rst	 : std_logic;
	signal w 	 : std_logic;
	signal z		 : std_logic;
	
	type State_type is (A, B, C, D, E, F, G, H, I);
 
	-- Attribute to declare a specific encoding for the states 
	attribute syn_encoding : string; 
	attribute syn_encoding of State_type : type is "0000 0001 0010 0011 0100 0101 0110 0111 1000"; 

	signal y_Q, Y_D : State_type; -- y_Q is present state, y_D is   
                              -- next state 
begin 

	--Tie hardware inputs to software signals
	clk 	<= KEY(0);
	rst	<= SW(0);
	w		<= SW(1);
	
    process (clk) -- state table 
    begin 
		if(rising_edge(clk)) then
        case y_Q is 
            when A => 
                if (w = '0') then Y_D <= B; 
                else Y_D <= F; end if; 
				when B =>
					 if (w = '0') then Y_D <= C; 
                else Y_D <= F; end if;
				when C =>
					 if (w = '0') then Y_D <= D; 
                else Y_D <= F; end if;
				when D =>
					 if (w = '0') then Y_D <= E; 
                else Y_D <= F; end if;
				when E  =>
					 if (w = '0') then Y_D <= E; 
                else Y_D <= F; end if;
				when F  =>
					 if (w = '0') then Y_D <= B; 
                else Y_D <= G; end if;
				when G  =>
					 if (w = '0') then Y_D <= B; 
                else Y_D <= H; end if;
				when H  =>
					 if (w = '0') then Y_D <= B; 
                else Y_D <= I; end if;
				when I  =>
					 if (w = '0') then Y_D <= B; 
                else Y_D <= I; end if;
        end case;
		 end if; 
    end process;  
	 
    process (clk) -- state flip-flops 
    begin 
			if(clk = '1' and rst = '0') then y_Q <= Y_D; --loads the current input state to the output of the next state
			elsif(clk = '1' and rst = '1') then y_Q <= A; end if;
		
    end process; 
    
	process(clk) -- assignments for output z and the leds 
	begin
		LEDR(8) <= '0';
		LEDR(7) <= '0';
		LEDR(6) <= '0';
		LEDR(5) <= '0';
		LEDR(4) <= '0';
		if(rising_edge(clk)) then
			if(y_Q = E or y_Q = I) then  LEDR(9) <= '1';
			else LEDR(9) <= '0'; end if;
			
			--LEDR(9) <= z;
			if(y_Q = A) then
				LEDR(3) <= '0';
				LEDR(2) <= '0';
				LEDR(1) <= '0';
				LEDR(0) <= '0';
			end if;
			
			if(y_Q = I) then 
				LEDR(3) <= '1'; 
			else 
				LEDR(3) <= '0';
			end if;
			
			if(y_Q = E or y_Q = F or y_Q = G or y_Q = H) then
				LEDR(2) <= '1';
			else
				LEDR(2) <= '0';
			end if;
			
			if(y_Q = C or y_Q = D or y_Q = G or y_Q = H) then
				LEDR(1) <= '1';
			else
				LEDR(1) <= '0';
			end if;
			
			if(y_Q = B or y_Q = D or y_Q = F or y_Q = H) then
				LEDR(0) <= '1';
			else
				LEDR(0) <= '0';
			end if;
		end if;
			
	
	end process;
end fsm2; 
 
