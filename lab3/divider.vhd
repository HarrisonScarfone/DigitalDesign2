library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity divider is
	port(
		Go, Clock, Reset: in std_logic;
		A, B: in std_logic_vector(3 downto 0);
		Done: out std_logic;
		Q, R: out std_logic_vector (3 downto 0)
		);
end entity divider;

architecture behaviour of divider is

	type state is (S0, S1, S2, S3);
	
	signal current_state: state := S0;
	signal next_state: state:= S0;	
	signal RA, RB, RR, RQ, C: std_logic_vector(3 downto 0);
	
	
begin
	process(Clock, Reset)
	begin
		if(Reset = '1') then
			next_state <= S0;
			Done <= '0';
			RA <= A;
			RB <= B;
		elsif(Clock'event and Clock = '1') then
			case current_state is
				when S0 =>
					RQ <= "0000";
					RR <= "0000";
					C <= "0011";
					if(Go = '1') then 
						next_state <= S1;
					else
						RA <= A;
						RB <= B;
						next_state <= S0;
					end if;
				when S1 =>
					RR <= RR(2 downto 0) & RA(3);
					RA <= RA(2 downto 0) & '0';
					next_state <= S2;
				when S2 =>
					C <= C - 1;
					if(RR >= RB) then
						RQ <= RQ(2 downto 0) & '1';
						RR <= RR - RB;
					else
						RQ <= RQ(2 downto 0) & '0';
					end if;
					if(C = "0000") then 
						next_state <= S3;
					else
						next_state <= S1;
					end if;
				when S3 => 
						Done <= '1';
						Q <= RQ;
						R <= RR;
				end case;
		end if;
	end process;
	
	current_state <= next_state;

end architecture;	