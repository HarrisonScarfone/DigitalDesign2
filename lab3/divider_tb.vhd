--4-bit divider

--By: Harrison Scarfone

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
	
entity divider_tb is
end entity;

architecture bh of divider_tb is
	component divider is
		Port(
			Go, Clock, Reset: in std_logic;
			A, B: in std_logic_vector(3 downto 0);
			Done: out std_logic;
			Q, R: out std_logic_vector (3 downto 0)
		);
	End component;
	
	type state is (S0, S1, S2, S3);
	
	signal Clock, Reset, Go: std_logic;
	signal A, B: std_logic_vector(3 downto 0);
	signal Done: std_logic;
	Signal Q, R: std_logic_vector(3 downto 0);	
	
	constant period 				: time := 10 ns;
	constant TinputDelay 	: time := 1 ns;
	
	
begin
	
	uut:divider 
		Port map(
			Clock					=> Clock,
			Go						=> Go,
			Reset					=> Reset,
			A						=> A,
			B						=> B,
			
			Done					=> Done,
			Q						=> Q,
			R						=> R
		);

		
	process
	
	begin
		Clock	<= '0';
		wait for period/2;
		Clock	<= '1';
		wait for period/2;
	end process;
	
	
	process
	begin
	
			Reset <= '1';
			A <= "1111";
			B <= "0101";
		wait for 30ns;
			Reset <= '0';
			Go <= '1';
		wait until Done='1';
			Reset <= '1';
			A <= "1110";
			B <= "0111";
		wait for 30ns;
			Reset <= '0';
			Go <= '1';
		wait until Done='1';
			Reset <= '1';
			A <= "1001";
			B <= "0100";
		wait for 30ns;
			Reset <= '0';
			Go <= '1';
		wait until Done='1';
			Reset <= '1';
			A <= "1101";
			B <= "0011";
		wait for 30ns;
			Reset <= '0';
			Go <= '1';
		wait until Done='1';
			Reset <= '1';
			A <= "1111";
			B <= "1111";
		wait for 30ns;
			Reset <= '0';
			Go <= '1';
		wait until Done='1';

			
		
	wait;
	
	end process;
	
end architecture;
