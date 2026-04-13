library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- this is a simple 2-input AND gate implemented in VHDL. The output Y will be high (1) only when both inputs A and B are high (1). Otherwise, the output will be low (0).

entity AND2_gate is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Y : out STD_LOGIC);
end AND2_gate;

architecture Behavioral of AND2_gate is

begin
Y <= A and B ;

end Behavioral;
