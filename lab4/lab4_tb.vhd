--Lab 4 testbench file
--By: Harrison Scarfone
--		Samantha Bartos
--		Andy Chung

library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
	
entity lab4_tb is
end entity;

architecture bh of lab4_tb is
	component lab4 is
		Port(
		clk, reset, start, response: in std_logic;
		seg7a3, seg7a2, seg7a1, seg7a0, seg7s: out std_logic_vector(6 downto 0);
		done: out std_logic
		);
	End component;
	
	signal clk, reset, start, response: std_logic;
	signal seg7a3, seg7a2, seg7a1, seg7a0, seg7s: std_logic_vector(6 downto 0);
	signal done: std_logic;
	
	constant period 			: time := 20 ns;
	constant TinputDelay 	: time := 1 ns;
	
	
begin
	
	uut:lab4
		Port map(
			clk						=> clk,
			start						=> start,
			reset						=> reset,
			response					=> response,
			
			seg7a3					=> seg7a3,
			seg7a2					=> seg7a2,
			seg7a1					=> seg7a1,
			seg7a0					=> seg7a0,
			seg7s						=> seg7s,
			done						=> done
		);

--handle the internal clock, set at the same speed as the board	
	process	
	begin
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		wait for period/2;
	end process;	
--apply response stimulus in the intervals containing a displayed 7
	process
	begin
--one cylcle time is 562971666 ps
		reset <= '1';
		wait for 20ns;
		reset <= '0';
		wait for 10 ns;
		start <= '1'; 
		wait for 1 ns;
		start <= '0';	
		wait for 37610648 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 124115138 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 62997836 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 55475705 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 21626123 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 60177037 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 97599631 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 103369548 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 100000000 ps;
		reset <= '1';
		wait for 20ns;
		reset <= '0';
		wait for 1000000 ns;
		start <= '1'; 
		wait for 1 ns;
		start <= '0';	
		wait for 37610648 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 124115138 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 62997836 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 55475705 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 21626123 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 60177037 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 97599631 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait for 103369548 ps;
		response <= '1';
		wait for 1 ps;
		response <= '0';
		wait;
	end process;
----handle the reset and start signal application
--	process
--	begin	
--
--		wait;	
--	end process;	
end architecture;