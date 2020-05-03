----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2019 07:32:53 PM
-- Design Name: 
-- Module Name: ripple_carry_adder - Behavioral
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

entity ripple_carry_adder is
generic (size : natural);
  port (
    A  : in std_logic_vector(size-1 downto 0);
    B  : in std_logic_vector(size-1 downto 0);
    result_output   : out std_logic_vector(size downto 0) );
end ripple_carry_adder;

architecture Behavioral of ripple_carry_adder is
component full_adder is
    port (
      A  : in  std_logic;
      B  : in  std_logic;
      Cin : in  std_logic;
      S   : out std_logic;
      Cout : out std_logic);
  end component full_adder;
  
  signal s_CARRY : std_logic_vector(size downto 0);
  signal s_SUM   : std_logic_vector(size-1 downto 0);
  
  
begin

  s_CARRY(0) <= '0';              
   
 SET_WIDTH : for i in 0 to size-1 generate
  full_adder_instance : full_adder
      port map (
        A  => A(i),
        B  => B(i),
        Cin => s_CARRY(i),
        S   => s_SUM(i),
        Cout => s_CARRY(i+1) );
  end generate SET_WIDTH;
 
  result_output <= s_CARRY(size) & s_SUM;  

end Behavioral;
