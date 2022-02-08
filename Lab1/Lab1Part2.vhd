library ieee; 
use ieee.std_logic_1164.all; 

entity part2 is 
port(. . . -- define input and output ports 
    ); 
end part2;
 
architecture rtl of part2 is 
    . . . -- declare signals 
type State_type is (A, B, C, D, E, F, G, H, I);
 
-- Attribute to declare a specific encoding for the states 
attribute syn_encoding : string; 
attribute syn_encoding of State_type : type is "0000 0001 0010 0011 0100 
0101 0110 0111 1000"; 
signal y_Q, Y_D : State_type; -- y_Q is present state, y_D is   
                              -- next state 
begin 
    . . . 
    process (w, y_Q) -- state table 
    begin 
        case y_Q is 
            when A  
                if (w = ’0’) then Y_D <= B; 
                else Y_D <= F; end if; 
        . . . -- other states 
        end case; 
    end process;  
    process (clock) -- state flip-flops 
    begin 
    . . .  
    end process; 
    . . . -- assignments for output z and the leds 
end rtl; 