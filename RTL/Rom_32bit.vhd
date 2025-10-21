library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Rom_32bit is
	port(
		i_ADDR : in std_logic_vector(31 downto 0);
		o_INST : out std_logic_vector(31 downto 0)
	);
end entity Rom_32bit;

architecture arch of Rom_32bit is

	type T_ROM_ARRAY is array (0 to 255) of std_logic_vector(7 downto 0);
	constant ROM : T_ROM_ARRAY := (
-- 0x00:
"00000000", "11000011", "10000011", "00010011",
-- 0x04:
"00000001", "10001110", "10001110", "00010011",
-- 0x08:
"00000010", "01000100", "10000100", "00010011",
-- 0x0C:
"00000000", "01100000", "00100000", "00100011",
-- 0x10:
"00000000", "00010011", "00000011", "00010011",
-- 0x1C:
"00000000", "00000000", "00100011", "00000011",


		others => x"00"
	);
begin
o_INST <= ROM(to_integer(unsigned(i_ADDR))) &
ROM(to_integer(unsigned(i_ADDR))+1) &
ROM(to_integer(unsigned(i_ADDR))+2) &
ROM(to_integer(unsigned(i_ADDR))+3);
end arch;