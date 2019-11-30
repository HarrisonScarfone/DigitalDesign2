library ieee;
use ieee.std_logic_1164.all;

entity orgate is
	port(
	SW0, SW1 : in std_logic;
	led : out std_logic 
	);
end entity;

architecture behave of orgate is
begin
	led <= (SW0) or (SW1);
end architecture;