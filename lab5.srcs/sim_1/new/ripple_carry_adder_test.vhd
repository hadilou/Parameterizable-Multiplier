----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2019 07:56:24 PM
-- Design Name: 
-- Module Name: ripple_carry_adder_test - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_carry_adder_test is
--  Port ( );
end ripple_carry_adder_test;

architecture Behavioral of ripple_carry_adder_test is
constant s_size : integer := 8;
   
  signal A_tb  :  std_logic_vector(s_size-1 downto 0) := (others => '0');
  signal B_tb  : std_logic_vector(s_size-1 downto 0) := (others => '0');
  signal result_tb : std_logic_vector(s_size downto 0);
  signal i,j: integer:=0;
  component ripple_carry_adder is
    generic ( size : natural );
    port (
      A : in  std_logic_vector(s_size-1 downto 0);
      B : in  std_logic_vector(s_size-1 downto 0);
      result_output    : out std_logic_vector(s_size downto 0) );
  end component ripple_carry_adder; 
begin
 
  uut : ripple_carry_adder
    generic map (size     => s_size)
    port map (A => A_tb,
              B => B_tb,
              result_output  => result_tb);

process      
begin
    for i in 0 to (2**s_size)-1 loop
        A_tb<=std_logic_vector(to_unsigned(i,s_size));
        for j in 0 to (2**s_size)-1 loop
            B_tb <= std_logic_vector(to_unsigned(j,s_size));
            wait for 10 ns;
                assert result_tb = std_logic_vector(to_unsigned(i,s_size + 1) + to_unsigned(j,s_size + 1))
                report "-----Failed---A_tb,B_tb,result_tb and A_tb+B_tb are respectively:"&" " & integer'image(to_integer(unsigned(A_tb)))
                                                                                           &" " & integer'image (to_integer(unsigned(B_tb))) 
                                                                                           &" " & integer'image (to_integer(unsigned(result_tb)))
                                                                                           &" " & integer'image(to_integer(unsigned(A_tb) + unsigned(B_tb))) 
                severity error;
        end loop; 
    end loop;
    wait;  
end process;
  
  
           
end Behavioral;
