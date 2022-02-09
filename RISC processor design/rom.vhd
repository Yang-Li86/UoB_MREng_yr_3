----------------------------------------------------------
--This component is part of micro.vhd					--
--Component Name: rom									--
--Inputs: 5												--
--Outputs: 2											--
--File Name: rom.vhd                                    --
--Written by: Yang Li                                   --
--Last Reviewed: 16 Nov. 2021							--
----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY rom IS
	PORT(rom_addr1: IN std_logic_vector(4 DOWNTO 0);
	rom_addr2:      IN std_logic_vector(4 DOWNTO 0);
	rom_addr3:      IN std_logic_vector(4 DOWNTO 0);
	rom_data_out1:  OUT std_logic_vector(31 DOWNTO 0);
	rom_data_out2:  OUT std_logic_vector(31 DOWNTO 0);
	rom_data_in:    IN std_logic_vector(31 DOWNTO 0);
	rom_clk_in:     IN std_logic);
END ENTITY rom;

ARCHITECTURE arch OF rom IS

    TYPE rom_type IS ARRAY (0 TO 31) OF std_logic_vector(31 DOWNTO 0);
    
    SIGNAL rom_reg : rom_type := (
	X"0000_0000",	 --0
    X"0000_0000",	 --1
	X"0000_0000",	 --2
	X"0000_C485",	 --3
    X"0000_9014",	 --4
    X"0000_8D68",	 --5
    X"0000_B936",	 --6
    X"0001_04DF",	 --7
    X"0000_246E",	 --8
    X"0000_5959",	 --9
    X"0001_8162",	 --10
    X"0000_778A",	 --11
    X"0000_819F",	 --12
    X"0000_60AA",	 --13
    X"0000_68DA",	 --14
    X"0000_D655",	 --15
    X"0000_EE78",	 --16
    X"0000_0F80",	 --17
    X"0000_5E53",	 --18
    X"0000_4654",	 --19
    X"0000_17D7",	 --20
    X"0000_B6E8",	 --21
    X"0000_18C2",	 --22
    X"0001_6685",	 --23
    X"0000_CC86",	 --24
    X"0001_657E",	 --25
    X"0001_7672",	 --26
    X"0001_2E32",	 --27
    X"0000_4D1E",	 --28
    X"0001_4D7E",	 --29
    X"0001_5BE0",	 --30
    X"0000_063E");	 --31
BEGIN
    rom_data_out1 <= rom_reg(conv_integer(rom_addr1));			   -- Data out are not clocked
    rom_data_out2 <= rom_reg(conv_integer(rom_addr2));
	PROCESS(rom_clk_in)
	BEGIN
	    IF rising_edge(rom_clk_in) THEN
            rom_reg(conv_integer(rom_addr3)) <= rom_data_in;	   -- Data in is clocked
	    END IF;
	END PROCESS;
END arch;

