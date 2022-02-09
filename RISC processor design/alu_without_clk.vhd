----------------------------------------------------------
--This component is part of micro.vhd					--
--Component Name: alu_without_clk						--
--Inputs: 3												--
--Outputs: 3											--
--Buffer: 1												--
--File Name: alu.vhd                                    --
--Written by: Yang Li                                   --
--Last Reviewed: 16 Nov. 2021							--
----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY alu_without_clk IS
	PORT(alu_data_in_a, alu_data_in_b: IN  std_logic_vector(31 DOWNTO 0);
	alu_opcode:                        IN  std_logic_vector(5 DOWNTO 0);
	alu_result:                        OUT std_logic_vector(31 DOWNTO 0);
	alu_Z:                             OUT std_logic;
	alu_N:                             OUT std_logic); 
END ENTITY alu_without_clk;

ARCHITECTURE dataflow OF alu_without_clk IS
SIGNAL alu_buffer:std_logic_vector(31 DOWNTO 0);

BEGIN
    alu_buffer <= alu_data_in_a + alu_data_in_b WHEN alu_opcode="000001" 	     
    ELSE alu_data_in_a - alu_data_in_b          WHEN alu_opcode="001010" 
    ELSE ABS(alu_data_in_a)                     WHEN alu_opcode="001000"  	                 
    ELSE -alu_data_in_a                         WHEN alu_opcode="000110"		                 
    ELSE ABS(alu_data_in_b)                     WHEN alu_opcode="001110"
    ELSE -alu_data_in_b                         WHEN alu_opcode="000010" 
    ELSE alu_data_in_a OR alu_data_in_b         WHEN alu_opcode="001101" 	      
    ELSE NOT alu_data_in_a                      WHEN alu_opcode="001111"  	                  
    ELSE NOT alu_data_in_b                      WHEN alu_opcode="001011"  
    ELSE alu_data_in_a AND alu_data_in_b        WHEN alu_opcode="000011"  
    ELSE alu_data_in_a XOR alu_data_in_b        WHEN alu_opcode="000101"
    ELSE X"00000000";                                                       

	alu_Z <= '1' WHEN alu_buffer = X"0000_0000"						   
	ELSE '0';
		
	alu_N <= '1' WHEN alu_buffer<0							
	ELSE '0';
	
	alu_result <= alu_buffer;
	
END ARCHITECTURE dataflow;