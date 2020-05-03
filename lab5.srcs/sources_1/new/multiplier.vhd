----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2019 21:22:10
-- Design Name: 
-- Module Name: multiplier - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity Multiplier is
Generic (size:integer:=8);
   Port (  A_mul : in STD_LOGIC_VECTOR (size-1 downto 0);
           B_mul : in STD_LOGIC_VECTOR (size-1 downto 0);
           C_in_mul: in std_logic;
           product_out : out STD_LOGIC_VECTOR ((2*size)-1 downto 0));
end Multiplier;

architecture Behavioral of Multiplier is

component ripple_carry_adder is
generic (size : natural );
  port (
    A  : in std_logic_vector(size-1 downto 0);
    B  : in std_logic_vector(size-1 downto 0);
    result_output   : out std_logic_vector(size downto 0) );
end component;          

type adder_type is array (0 to size-1) of std_logic_vector(size-1 downto 0);
type multiplier_type is array (0 to size-1) of std_logic_vector((2*size)-1 downto 0);

signal adder_signal: adder_type;
signal product_signal: multiplier_type;
constant zero: integer:=0;
begin

--for-generate  values to be added
 Traversing1rstNumber: for i in 0 to size-1 generate
        adder_signal(i) <=  B_mul when A_mul(i)='1' else (others => '0'); 
    end generate; 
    
product_signal(0)(size downto 0) <= '0' & adder_signal(0);--initialize to first number of adder list if not will encounter null
multiplication_block: for k in 1 to size-1 generate
      signal a_temp: std_logic_vector(size-1+k downto 0);
      begin
       a_temp<=adder_signal(k)&std_logic_vector(to_unsigned(zero,k));
       n_bits_ripple_carry_adder: component ripple_carry_adder 
                                  generic map ( size=> size+k)
                                  port map(A => a_temp,
                                           B => product_signal(k-1)(size-1+k downto 0),
                                           result_output => product_signal(k)(size+k downto 0));                                                                    
end generate;
product_out <= product_signal(size-1);
end Behavioral;
