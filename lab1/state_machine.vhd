library ieee;
use ieee.std_logic_1164.all;
entity state_machine is
port (
clk, reset : in std_logic;
 led_out : out std_logic_vector(3 downto 0)
 );
end entity state_machine;
architecture sequential of state_machine is
type state_type is (S0, S1, S2, S3);
signal state, next_state : state_type;
signal divided_clk : std_logic := '0';
begin
clock_divider: process (clk)
variable clk_count: integer:=0;
begin
if(clk'event and clk = '1') then
--Change clk_count value to 2 or 4 for simulation in Modelsim
if clk_count = 12500000 then
divided_clk <= not divided_clk;
clk_count := 0;
else
clk_count := clk_count + 1;
end if;
end if;
end process;
process (divided_clk, reset)
begin
if (reset = '0') then
state <= S0;
elsif (divided_clk'event and divided_clk = '1') then
case state is
when s0=>
state <= s1;
when s1=>
state <= s2;
when s2=>
state <= s3;
when s3=>
state <= s0;
end case;
end if;
end process;
process (state)
begin
case state is
when s0=> led_out <= "1000";
when s1=> led_out <= "0100";
when s2=> led_out <= "0010";
when s3=> led_out <= "0001";
end case;
end process;
end architecture sequential;