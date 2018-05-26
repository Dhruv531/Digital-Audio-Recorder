library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------

entity write_ram is
generic(	sampling_bits:	integer:=8;
		rows:	integer:=2**15;
		address_bits:	integer:=15);
port(	
   Clock:		in std_logic;	
	Enable:		in std_logic;   
	Write_enable: in std_logic;   
	Write_Address: 	in std_logic_vector(address_bits-1 downto 0); 
	Data_in: 	in std_logic_vector(sampling_bits-1 downto 0)  --Input from ADC 
   );
end write_ram;

--------------------------------------------------------------

architecture behave of write_ram is

-- use array to define the bunch of internal temporary signals

type ram_type is array (0 to rows-1) of 
	std_logic_vector(sampling_bits-1 downto 0);
signal tmp_ram: ram_type;

begin	
    -- Write Functional Section
    process(Clock, Write_enable)
    begin
	if (Clock'event and Clock='1') then
	    if Enable='1' then
		if Write_enable='1' then
		    tmp_ram(conv_integer(Write_Address)) <= Data_in;
		end if;
	    end if;
	end if;
    end process;

end behave;
----------------------------------------------------------------
