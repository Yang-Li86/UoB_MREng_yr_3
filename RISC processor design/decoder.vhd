----------------------------------------------------------
--This component is part of micro.vhd					--
--Component Name: decoder  							    --
--Inputs: 2												--
--Outputs: 4											--
--File Name: decoder.vhd                                --
--Written by: Yang Li                                   --
--Last Reviewed: 16 Nov. 2021							--
----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY decoder IS
	PORT(
	decoder_clk_in:      IN std_logic;
	decoder_instruction: IN std_logic_vector(31 DOWNTO 0);
	decoder_opcode:      OUT std_logic_vector(5 DOWNTO 0);
	decoder_addr1:       OUT std_logic_vector(4 DOWNTO 0);
	decoder_addr2:       OUT std_logic_vector(4 DOWNTO 0);
	decoder_addr3:       OUT std_logic_vector(4 DOWNTO 0));
END ENTITY decoder;

ARCHITECTURE data_decode OF decoder IS
BEGIN
	PROCESS(decoder_clk_in)
	BEGIN
		IF rising_edge(decoder_clk_in) THEN
	        decoder_opcode <= decoder_instruction(31 DOWNTO 26);
	        decoder_addr1 <= decoder_instruction(25 DOWNTO 21);
	        decoder_addr2 <= decoder_instruction(20 DOWNTO 16);
	        decoder_addr3 <= decoder_instruction(15 DOWNTO 11);
		END IF;
	END PROCESS;
	
END ARCHITECTURE data_decode;