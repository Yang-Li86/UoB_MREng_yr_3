---------------------------------------
--File name: micro_testbench_rf.vhd  --
--                                   --
--This is a testbench for the design --
--written in micro_advanced.vhd      --
--                                   --
--Written by: Yang Li                --
--Last Reviewed: 15th Jan 2022       --
---------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY micro_testbench_rf IS
END ENTITY micro_testbench_rf;

ARCHITECTURE microtest_rf OF micro_testbench_rf IS
SIGNAL in_instruction: std_logic_vector(31 DOWNTO 0);

BEGIN
	test1: ENTITY work.micro_advanced(archi_advanced)
		   PORT MAP(
		   micro_instruction => in_instruction);
		
	in_instruction <= B"000001_00011_00100_00001_00000000000",		   -- r1 <- r3 + r4
	B"000001_00101_00110_00010_00000000000" AFTER 2 ns,			       -- r2 <- r5 + r6
	B"000001_00001_00111_00001_00000000000" AFTER 3 ns,			       -- r1 <- r1 + r7
	B"000001_00001_01000_00001_00000000000" AFTER 4 ns,			       -- r1 <- r1 + r8
	B"000001_00010_01001_00010_00000000000" AFTER 5 ns,			       -- r2 <- r2 + r9
	B"000001_00010_01010_00010_00000000000" AFTER 6 ns,			       -- r2 <- r2 + r10
	B"000001_00001_01011_00001_00000000000" AFTER 7 ns,			       -- r1 <- r1 + r11
	B"000001_00001_01100_00001_00000000000" AFTER 8 ns,			       -- r1 <- r1 + r12
	B"000001_00010_01101_00010_00000000000" AFTER 9 ns,			       -- r2 <- r2 + r13
	B"000001_00010_01110_00010_00000000000" AFTER 10 ns,			   -- r2 <- r2 + r14
	B"000001_00001_01111_00001_00000000000" AFTER 11 ns,			   -- r1 <- r1 + r15
	B"000001_00001_10000_00001_00000000000" AFTER 12 ns,			   -- r1 <- r1 + r16
	B"000001_00010_10001_00010_00000000000" AFTER 13 ns,			   -- r2 <- r2 + r17
	B"000001_00010_10010_00010_00000000000" AFTER 14 ns,			   -- r2 <- r2 + r18
	B"000001_00001_10011_00001_00000000000" AFTER 15 ns,			   -- r1 <- r1 + r19
	B"000001_00001_10100_00001_00000000000" AFTER 16 ns,			   -- r1 <- r1 + r20
	B"000001_00010_10101_00010_00000000000" AFTER 17 ns,			   -- r2 <- r2 + r21
	B"000001_00010_10110_00010_00000000000" AFTER 18 ns,			   -- r2 <- r2 + r22
	B"000001_00001_10111_00001_00000000000" AFTER 19 ns,			   -- r1 <- r1 + r23
	B"000001_00001_11000_00001_00000000000" AFTER 20 ns,			   -- r1 <- r1 + r24
	B"000001_00010_11001_00010_00000000000" AFTER 21 ns,			   -- r2 <- r2 + r25
	B"000001_00010_11010_00010_00000000000" AFTER 22 ns,			   -- r2 <- r2 + r26
	B"000001_00001_11011_00001_00000000000" AFTER 23 ns,			   -- r1 <- r1 + r27
	B"000001_00001_11100_00001_00000000000" AFTER 24 ns,			   -- r1 <- r1 + r28
	B"000001_00010_11101_00010_00000000000" AFTER 25 ns,			   -- r2 <- r2 + r29
	B"000001_00010_11110_00010_00000000000" AFTER 26 ns,			   -- r2 <- r2 + r30
	B"000001_00001_11111_00001_00000000000" AFTER 27 ns,			   -- r1 <- r1 + r31
	B"001010_00001_00010_00001_00000000000" AFTER 28 ns,			   -- r1 <- r1 - r2
	B"000001_00000_00000_00001_00000000000" AFTER 29 ns;			   -- no-op
	
END ARCHITECTURE microtest_rf;