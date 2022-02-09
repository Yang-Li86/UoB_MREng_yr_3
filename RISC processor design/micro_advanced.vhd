---------------------------------------------------------------------
--File Name: micro_advanced.vhd                                    --
--															       --
--This design consists of:			     					       --
--    decoder.vhd											       --
--    opcode_checker.vhd								           --
--	  rom.vhd												       --
--    alu_without_clk.vhd                                          --
--															       --
--The testbench for this design is                                 --
--    micro_testbench_advanced.vhd                                 --
--															       --
--Instruction Fetch (IF) cycle synchronisation is realised         --
--by adding clked control to the decoder					       --
--															       --
--Register forwarding hardware method used in this file            --
--															       --
--Input: 1                                                         --
--Output: None                                                     --
--Clock: Internal 1 GHz                                            --
--Written by: Yang Li                                              --
--Last Reviewed: 16 Nov. 2021							           --
---------------------------------------------------------------------
	
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY micro_advanced IS
	PORT(
	micro_instruction: IN std_logic_vector(31 DOWNTO 0));
END ENTITY micro_advanced;

ARCHITECTURE archi_advanced OF micro_advanced IS

--Define registers
SIGNAL OF_decoder_rom_addr3:             std_logic_vector(4 DOWNTO 0);
SIGNAL rom_alu_data1_1, rom_alu_data1_2: std_logic_vector(31 DOWNTO 0);
SIGNAL rom_alu_data2_1, rom_alu_data2_2: std_logic_vector(31 DOWNTO 0);
SIGNAL decoder_rom_addr1:                std_logic_vector(4 DOWNTO 0);
SIGNAL decoder_rom_addr2:                std_logic_vector(4 DOWNTO 0);
SIGNAL EX_alu_rom_result_1, EX_alu_rom_result_2:   std_logic_vector(31 DOWNTO 0);
SIGNAL EX_decoder_rom_addr3_1,EX_decoder_rom_addr3_2,EX_decoder_rom_addr3_3: std_logic_vector(4 DOWNTO 0);
SIGNAL decoder_checker_opcode, checker_alu_opcode: std_logic_vector(5 DOWNTO 0);
SIGNAL micro_addr3_setzero: std_logic;
SIGNAL one_cyc_reg_forwarding1, one_cyc_reg_forwarding2: std_logic_vector(31 DOWNTO 0);
SIGNAL two_cyc_reg_forwarding1, two_cyc_reg_forwarding2: std_logic_vector(31 DOWNTO 0);

--Define clock signal
SIGNAL micro_clk: std_logic;

BEGIN
	--Internal Clock
	PROCESS
		BEGIN
			micro_clk <= '1';
			WAIT FOR 0.5 ns;
			micro_clk <= '0';
			WAIT FOR 0.5 ns;
		END PROCESS;
	
	--Wire up the ports and add registers when neccessary
	micro_decoder: ENTITY work.decoder(data_decode)
		PORT MAP(
		decoder_instruction => micro_instruction,
		decoder_opcode => decoder_checker_opcode,
		decoder_addr1 => decoder_rom_addr1,
		decoder_addr2 => decoder_rom_addr2,
		decoder_addr3 => OF_decoder_rom_addr3,
		decoder_clk_in => micro_clk);
		
	micro_opcode_checker: ENTITY work.opcode_checker(checking)
		PORT MAP(
		checker_clk_in => micro_clk,
		checker_opcode_in => decoder_checker_opcode,
		checker_opcode_out => checker_alu_opcode,
		checker_addr3_setzero => micro_addr3_setzero);
		
	micro_rom: ENTITY work.rom(arch)
		PORT MAP(
		rom_addr1 => decoder_rom_addr1,
		rom_addr2 => decoder_rom_addr2,
		rom_addr3 => EX_decoder_rom_addr3_2,
		rom_data_in => EX_alu_rom_result_2,
		rom_data_out1 => rom_alu_data1_1,
		rom_data_out2 => rom_alu_data2_1,
		rom_clk_in => micro_clk);
		
	micro_alu: ENTITY work.alu_without_clk(dataflow)
	    PORT MAP(
	    alu_data_in_a => rom_alu_data1_2,
	    alu_data_in_b => rom_alu_data2_2,
	    alu_opcode => checker_alu_opcode,
	    alu_result => EX_alu_rom_result_1);
			
	--Connect the registers, info is passed on at rising clk edges
	PROCESS(micro_clk, micro_addr3_setzero, decoder_rom_addr1, EX_decoder_rom_addr3_1, decoder_rom_addr2, EX_decoder_rom_addr3_2)
	BEGIN
		--For invalid opcode, write result to 0
		IF micro_addr3_setzero = '1' THEN
			EX_decoder_rom_addr3_1 <= "00000";						     --2nd cyc
		END IF;
		
		--Register forwarding hardware
	    IF (decoder_rom_addr1 = EX_decoder_rom_addr3_1 
			AND EX_decoder_rom_addr3_1 /= "U" 
			AND EX_decoder_rom_addr3_1 /= "0") THEN				 --cyc 2 addr1 = cyc 1 addr3
			one_cyc_reg_forwarding1 <= EX_alu_rom_result_1;
			IF rising_edge(micro_clk) THEN
				rom_alu_data1_2 <= one_cyc_reg_forwarding1;
			END IF;
		ELSIF (decoder_rom_addr1 = EX_decoder_rom_addr3_2 
			AND EX_decoder_rom_addr3_2 /= "U" 
			AND EX_decoder_rom_addr3_2 /= "0") THEN              --cyc 3 addr1 = cyc 1 addr3
			two_cyc_reg_forwarding1 <= EX_alu_rom_result_2;
			IF rising_edge(micro_clk) THEN
				rom_alu_data1_2 <= two_cyc_reg_forwarding1;
			END IF;
		ELSE
			IF rising_edge(micro_clk) THEN
				rom_alu_data1_2 <= rom_alu_data1_1;
			END IF;
	    END IF;
		
	    IF (decoder_rom_addr2 = EX_decoder_rom_addr3_1 
			AND EX_decoder_rom_addr3_1 /= "U" 
			AND EX_decoder_rom_addr3_1 /= "0") THEN     	     --cyc 2 addr2 = cyc 1 addr3
		    one_cyc_reg_forwarding2 <= EX_alu_rom_result_1;
			IF rising_edge(micro_clk) THEN
				rom_alu_data2_2 <= one_cyc_reg_forwarding2;
			END IF;
		ELSIF (decoder_rom_addr2 = EX_decoder_rom_addr3_2 
			AND EX_decoder_rom_addr3_2 /= "U" 
			AND EX_decoder_rom_addr3_2 /= "0") THEN              --cyc 3 addr2 = cyc 1 addr3
			two_cyc_reg_forwarding2 <= EX_alu_rom_result_2;
			IF rising_edge(micro_clk) THEN
				rom_alu_data2_2 <= two_cyc_reg_forwarding2;
			END IF;
		ELSE
			IF rising_edge(micro_clk) THEN
				rom_alu_data2_2 <= rom_alu_data2_1;
			END IF;
	    END IF;
				
		IF rising_edge(micro_clk) THEN
			--OF and EX registering
			EX_decoder_rom_addr3_1 <= OF_decoder_rom_addr3;				     --2nd cyc
			EX_decoder_rom_addr3_2 <= EX_decoder_rom_addr3_1;	             --3rd cyc
			EX_alu_rom_result_2 <= EX_alu_rom_result_1;						 --3rd cyc
		END IF;
	END PROCESS;
			
END ARCHITECTURE;