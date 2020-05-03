----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2019 14:50:16
-- Design Name: 
-- Module Name: multiplier_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity multiplier_test is
end multiplier_test;

architecture Behavioral of multiplier_test is
component Multiplier is
Generic (size:integer:=8);
   Port (  A_mul : in STD_LOGIC_VECTOR (size-1 downto 0);
           B_mul : in STD_LOGIC_VECTOR (size-1 downto 0);
           C_in_mul : in STD_LOGIC;
           product_out : out STD_LOGIC_VECTOR ((2*size)-1 downto 0));
end component;

constant size:integer:=8;  
signal A_tb : STD_LOGIC_VECTOR (size-1 downto 0);
signal B_tb : STD_LOGIC_VECTOR (size-1 downto 0);
signal C_in_tb : STD_LOGIC:='0';
signal product_tb : STD_LOGIC_VECTOR ((2*size)-1 downto 0);


begin

uut: multiplier port map(
        A_mul=>A_tb,
        B_mul=>B_tb,
        C_in_mul=>C_in_tb,
        product_out =>product_tb);

process      
begin
    for i in 0 to (2**size)-1 loop
        A_tb<=std_logic_vector(to_unsigned(i,size));
        for j in 0 to (2**size)-1 loop
            B_tb <= std_logic_vector(to_unsigned(j,size));
            wait for 10 ns;
            assert product_tb = std_logic_vector(unsigned(A_tb) * unsigned(B_tb))
                report "-----Failed---A_tb,B_tb,product_tb and A_tb*B_tb are respectively:"&" " & integer'image(to_integer(unsigned(A_tb)))
                                                                                           &" " & integer'image (to_integer(unsigned(B_tb))) 
                                                                                           &" " & integer'image (to_integer(unsigned(product_tb)))
                                                                                           &" " & integer'image(to_integer(unsigned(A_tb) * unsigned(B_tb))) 
                severity error;
        end loop; 
    end loop;
    wait;  
end process;

end Behavioral;
