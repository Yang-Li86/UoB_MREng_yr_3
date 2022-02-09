----------------------------------------------------------
--This component is part of micro.vhd					--
--Component Name: opcode_checker					    --
--Inputs: 2												--
--Outputs: 2											--
--File Name: opcode_checker.vhd                         --
--Checks the legality of the opcode          			--
--If legal: returns 0                                   --
--If illegal: returns 1                                 --
--Written by: Yang Li                                   --
--Last Reviewed: 16 Nov. 2021							--
----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY opcode_checker IS
	port(checker_clk_in:   IN  std_logic;
	checker_opcode_in:     IN  std_logic_vector(5 DOWNTO 0);
	checker_opcode_out:    OUT std_logic_vector(5 DOWNTO 0);
	checker_addr3_setzero: OUT std_logic);
END ENTITY opcode_checker;

ARCHITECTURE checking OF opcode_checker IS
BEGIN
	PROCESS(checker_clk_in)
	BEGIN
		IF rising_edge(checker_clk_in) THEN
			checker_opcode_out <= checker_opcode_in;
		    IF    checker_opcode_in="000001" THEN checker_addr3_setzero <= '0';  	    
            ELSIF checker_opcode_in="001010" THEN checker_addr3_setzero <= '0'; 
            ELSIF checker_opcode_in="001000" THEN checker_addr3_setzero <= '0';  	                
            ELSIF checker_opcode_in="000110" THEN checker_addr3_setzero <= '0';  		             
            ELSIF checker_opcode_in="001110" THEN checker_addr3_setzero <= '0'; 
            ELSIF checker_opcode_in="000010" THEN checker_addr3_setzero <= '0';  
            ELSIF checker_opcode_in="001101" THEN checker_addr3_setzero <= '0';  	  
            ELSIF checker_opcode_in="001111" THEN checker_addr3_setzero <= '0';  	                
            ELSIF checker_opcode_in="001011" THEN checker_addr3_setzero <= '0';  
            ELSIF checker_opcode_in="000011" THEN checker_addr3_setzero <= '0';  
            ELSIF checker_opcode_in="000101" THEN checker_addr3_setzero <= '0';  
	        ELSE checker_addr3_setzero <= '1';                                                       
		    END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE checking;		