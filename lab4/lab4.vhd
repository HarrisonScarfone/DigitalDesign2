--Lab 4 hardware description file
--By: Harrison Scarfone

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity lab4 is
	port(
		clk, reset, start, response: in std_logic;
		seg7a3, seg7a2, seg7a1, seg7a0, seg7s: out std_logic_vector(6 downto 0);
		done: out std_logic
		);
end entity;

architecture behaviour of lab4 is

	type NumberSequence is array(29 downto 0) of Integer range 0 to 9;

	constant sequence: NumberSequence := (9,7,8,9,1,2,7,9,6,8,2,7,2,5,7,7,3,1,7,8,1,7,5,6,3,1,8,7,0,9);

	signal sequenceNumber: integer;
	signal divided_clk: std_logic := '0';
	signal response_clk: std_logic := '0';
	signal totalResponseTime: integer := 0;
	signal firstDigit: integer;
	signal secondDigit: integer;
	signal thirdDigit: integer;
	signal fourthDigit: integer := 0;
	signal finished: std_logic;
	signal await_response: std_logic;
	signal start_counting: std_logic;

	shared variable display_num: integer := 0;

begin
--divided clock process for use on board
	div_clk:process(clk)
		variable clk_count: integer:= 0;
	begin
		if(clk'event and clk='1') then
			if clk_count = 25000000 then 
				divided_clk <= not divided_clk;
				clk_count := 0;
			else
				clk_count := clk_count + 1;
			end if;
		end if;
	end process;
--divided clock process for use in test bench sim
--	div_clk:process(clk)
--		variable clk_count: integer := 0;
--	begin
--		if(clk'event and clk = '1') then
--			if clk_count = 500 then
--				divided_clk <= not divided_clk;
--				clk_count := 0;
--			else
--				 clk_count := clk_count + 1;
--			end if;
--		end if;
--	end process;
--response clock for use on the board	
	resp_clk:process(clk)
		variable clk_count: integer:= 0;
	begin
		if(clk'event and clk='1') then
			if clk_count = 25000 then 
				response_clk <= not response_clk;
				clk_count := 0;
			else
				clk_count := clk_count + 1;
			end if;
		end if;
	end process;
--response clock for use in the test bench sim	
--	resp_clk:process(clk)
--	begin
--		response_clk <= clk;
--	end process;
--driving process, handles logic flow and triggers helper processes
	driving_process:process(RESET, divided_clk, start, response)
	begin
		if(response='0') then
			await_response <= '0';
			sequenceNumber <= sequenceNumber;
		elsif(RESET = '1') then
			display_num := 0;
			finished <= '0';
			start_counting <= '0';
			firstDigit <= 10;
			secondDigit <= 10;
			thirdDigit <= 10;
			fourthDigit <= 10;
		elsif(start = '0') then
			start_counting <= '1';
		elsif(divided_clk'event and divided_clk = '1') then
			if(start_counting = '1') then
				if(display_num = 29) then
					firstDigit <= (totalResponseTime/8)/1000;
					secondDigit <= ((totalResponseTime/8)/100) mod 10;
					thirdDigit <= ((totalResponseTime/8)/10) mod 10;
					fourthDigit <= (totalResponseTIme/8) mod 10;
					finished <= '1';
					start_counting <= '0';
				elsif(sequence(display_num + 1) = 7) then 
					await_response <= '1';
					display_num := display_num + 1;
					finished <= '0';
					sequenceNumber <= sequence(display_num);
				else
					await_response <= '0';
					display_num := display_num + 1;
					sequenceNumber <= sequence(display_num);	
					finished <= '0';
				end if;
			end if;
		end if;
	end process;
--helper process triggered by driving_process to count the total response time
	response_timer:process(response_clk, response, await_response, sequenceNumber, RESET)
		variable timer_counter: integer := 0;
	begin
		if(RESET = '1') then
			totalResponseTime <= 0;
		elsif(response = '0' and await_response = '1' and sequenceNumber = 7) then
				totalResponseTime <= totalResponseTime + timer_counter;
				timer_counter := 0;
		elsif(response_clk'event and response_clk = '1') then
			if(sequenceNumber = 7 and await_response = '1') then
				timer_counter := timer_counter + 1;
				totalResponseTime <= totalResponseTime;
			elsif(timer_counter = 1000 and await_response = '1') then
				totalResponseTime <= totalResponseTime + timer_counter;
				timer_counter := 0;
			end if;
		end if;
	end process;	
--helper process that displays the current number in the sequence on the board	
	current_num_display:process(sequenceNumber)
	begin
		case sequenceNumber is
			when 0 =>
				seg7s <= "1000000";
			when 1 => 
				seg7s <= "1111001";
			when 2 =>
				seg7s <= "0100100";
			when 3 =>
				seg7s <= "0110000";
			when 4 => 
				seg7s <= "0011001";
			when 5 =>
				seg7s <= "0010010";
			when 6 => 
				seg7s <= "0000010";
			when 7 =>
				seg7s <= "1111000";
			when 8 =>
				seg7s <= "0000000";
			when 9 =>
				seg7s <= "0011000";
			when others => 
				seg7s <= "0000110";
		end case;
	end process;
--helper process to handle finishing the sequence	
	finishing_seqeunce:process(finished, firstDigit)	
	begin
		if(finished = '1' or firstDigit = 10) then
			done <= '1';			
			case firstDigit is
				when 0 =>
					seg7a3 <= "1000000";
				when 1 => 
					seg7a3 <= "1111001";
				when 2 =>
					seg7a3 <= "0100100";
				when 3 =>
					seg7a3 <= "0110000";
				when 4 => 
					seg7a3 <= "0011001";
				when 5 =>
					seg7a3 <= "0010010";
				when 6 => 
					seg7a3 <= "0000010";
				when 7 =>
					seg7a3 <= "1111000";
				when 8 =>
					seg7a3 <= "0000000";
				when 9 =>
					seg7a3 <= "0011000";
				when 10 =>
					seg7a3 <= "1111111";
				when others => 
					seg7a3 <= "0000110";
			end case;
			
			case secondDigit is
				when 0 =>
					seg7a2 <= "1000000";
				when 1 => 
					seg7a2 <= "1111001";
				when 2 =>
					seg7a2 <= "0100100";
				when 3 =>
					seg7a2 <= "0110000";
				when 4 => 
					seg7a2 <= "0011001";
				when 5 =>
					seg7a2 <= "0010010";
				when 6 => 
					seg7a2 <= "0000010";
				when 7 =>
					seg7a2 <= "1111000";
				when 8 =>
					seg7a2 <= "0000000";
				when 9 =>
					seg7a2 <= "0011000";
				when 10 =>
					seg7a2 <= "1111111";
				when others => 
					seg7a2 <= "0000110";
			end case;
			
			case thirdDigit is
				when 0 =>
					seg7a1 <= "1000000";
				when 1 => 
					seg7a1 <= "1111001";
				when 2 =>
					seg7a1 <= "0100100";
				when 3 =>
					seg7a1 <= "0110000";
				when 4 => 
					seg7a1 <= "0011001";
				when 5 =>
					seg7a1 <= "0010010";
				when 6 => 
					seg7a1 <= "0000010";
				when 7 =>
					seg7a1 <= "1111000";
				when 8 =>
					seg7a1 <= "0000000";
				when 9 =>
					seg7a1 <= "0011000";
				when 10 =>
					seg7a1 <= "1111111";
				when others => 
					seg7a1 <= "0000110";
			end case;
			
			case fourthDigit is
				when 0 =>
					seg7a0 <= "1000000";
				when 1 => 
					seg7a0 <= "1111001";
				when 2 =>
					seg7a0 <= "0100100";
				when 3 =>
					seg7a0 <= "0110000";
				when 4 => 
					seg7a0 <= "0011001";
				when 5 =>
					seg7a0 <= "0010010";
				when 6 => 
					seg7a0 <= "0000010";
				when 7 =>
					seg7a0 <= "1111000";
				when 8 =>
					seg7a0 <= "0000000";
				when 9 =>
					seg7a0 <= "0011000";
				when 10 =>
					seg7a0 <= "1111111";
				when others => 
					seg7a0 <= "0000110";
			end case;				
		end if;		
	end process;
end architecture;			
