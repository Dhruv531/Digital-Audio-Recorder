library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------

entity ram_fsm is
port(	
   Clk:		in std_logic;	
   Address: in std_logic_vector(14 downto 0);
   data: inout std_logic_vector(7 downto 0);
   WE, CS, OE: in std_ulogic
   );
end ram_fsm;

--------------------------------------------------------------

architecture behave of ram_fsm is

component read_ram is
generic(	sampling_bits:	integer:=8;
		rows:	integer:=2**15;
		address_bits:	integer:=15);
port(	
   Clock:		in std_logic;	
	Enable:		in std_logic;   
	Read_enable: in std_logic;      
	Read_Address:	in std_logic_vector(address_bits-1 downto 0);
	Data_out: 	out std_logic_vector(sampling_bits-1 downto 0)  --Output to DAC
   );
end component;


component write_ram is
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
end component;

signal En,Read_en,Write_en: std_logic;

begin	
		En <= (not CS) ;
	   Read_en <= (not OE)and(not CS) ;
      Write_en <= (not WE)and(not CS) ;
Read_logic : read_ram port map (Clock => clk	,Enable => En, Read_enable => Read_En, Read_Address=> Address, Data_out => data) ;
Write_logoc : Write_ram port map (Clock => clk	,Enable => En, Write_enable => Write_En, Write_Address=> Address, Data_in => data) ;  


end behave;
----------------------------------------------------------------
