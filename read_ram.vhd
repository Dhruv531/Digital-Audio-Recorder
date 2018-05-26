library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------

entity read_ram is
generic(	sampling_bits:	integer:=8;
		rows:	integer:=2**15;
		address_bits:	integer:=15);
port(	
   clock:		in std_logic;	
	Enable:		in std_logic;   
	Read_enable: in std_logic;   
	Read_Address:	in std_logic_vector(address_bits-1 downto 0);
	Data_out: 	out std_logic_vector(sampling_bits-1 downto 0)  --Output to DAC
   );
end read_ram;

--------------------------------------------------------------

architecture behave of read_ram is

-- use array to define the bunch of internal temporary signals

type ram_type_read is array (0 to rows-1) of 
	std_logic_vector(sampling_bits-1 downto 0);
signal tmp_ram_read: ram_type_read;

begin	
			   
    -- Read Functional Section
    process(clock, Read_enable)
    begin
	if (clock'event and clock='1') then
	    if Enable='1' then
		if Read_enable='1' then
		    -- buildin function conv_integer change the type
		    -- from std_logic_vector to integer
		    Data_out <= tmp_ram_read(conv_integer(Read_Address)); 
		else
		    Data_out <= (Data_out'range => 'Z');
		end if;
	    end if;
	end if;
    end process;
	

end behave;
----------------------------------------------------------------
