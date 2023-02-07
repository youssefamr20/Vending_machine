-- G17 Code --
-- Youssef Amr // Youssef Noaman --

-- Entity declaration for your testbench. Don't declare any ports here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.all;

ENTITY vending_machine_test IS
END ENTITY vending_machine_test;

ARCHITECTURE test_vending OF vending_machine_test IS


-- Component Declaration for the Device Under Test (DUT)
COMPONENT Vending_Machine IS
  port ( ck, rst_n, water_soda  : in bit                            ; 
         vdd, vss               : in bit                            ;
         coin_in                : in bit_vector  (1 downto 0) ;
         coin_out               : out bit_vector (1 downto 0) ;
         drink_out              : out bit_vector (1 downto 0)
       );
END COMPONENT Vending_Machine;

FOR dut: Vending_Machine USE ENTITY WORK.Vending_Machine(behavioral);

-- Declare input signals and initialize them
SIGNAL ck           : bit :=  '0';
SIGNAL vdd          : bit :=  '1';
SIGNAL vss          : bit :=  '0';
SIGNAL rst_n        : bit :=  '1';
SIGNAL water_soda   : bit :=  '0';
SIGNAL drink_out    : bit_vector  (1 downto 0) :="00"  ;
SIGNAL coin_out     : bit_vector  (1 downto 0) :="00"  ;
SIGNAL coin_in    : bit_vector  (1 downto 0) :="00"  ;
-- Constants and Clock period definitions
constant clk_period : time := 1000 ns;   -- as our freq is 1MHz

BEGIN

-- Instantiate the Device Under Test (DUT)
dut:  Vending_Machine PORT MAP ( ck, rst_n, water_soda , vdd, vss,coin_in ,coin_out , drink_out);

-- Clock process definitions( clock with 50% duty cycle )
   clk_process :process
   begin
        ck  <= '0';
        wait for clk_period/2;  
        ck  <= '1';
        wait for clk_period/2;  
   end process;




-- Stimulus process, refer to clock signal
test_proc: PROCESS IS

-- procedure that checks on the exchange --
-- used only when we expect an exchange --

PROCEDURE check_out_drink is
BEGIN
-- Check output against expected result.
if (water_soda='0') then
	Assert drink_out ="01"  Report "drink_our is not water"
	 Severity Error;
else 
	Assert drink_out ="11"  Report "drink_our is not soda"
	Severity Error;
end if ;

END PROCEDURE check_out_drink;


BEGIN
   
   -- test case 1 
   -- testing coin_in = 0.5$ & drink is water 
   wait for clk_period;
	water_soda <= '0';
	coin_in <= "10"  ;
	wait for clk_period;
	coin_in <= "00"  ;
	check_out_drink ;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
	wait for clk_period;

   -- test case 2 
	-- testing reset
   rst_n<='0';
   wait for clk_period;
   assert drink_out = "00" Report "drink out is asserted" Severity Error;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
   wait for (2*clk_period);
   rst_n<='1';


		-- When drink is Soda , Water_Soda=1 --
   -- test case 3
   -- testing water_soda = 1 and user inputs 1.5 => 0.5 then 0.5 then 0.5
   water_soda <= '1';
	coin_in <= "10"  ;  -- 0.5 from user
	wait for clk_period;
	coin_in <= "10"  ;  -- 0.5 from user
	-- trnasition state/ no output expected -- 
	assert drink_out = "00" Report "drink out is asserted" Severity Error;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
	wait for clk_period;
	coin_in <= "10"  ;  -- 0.5 from user
	assert drink_out = "00" Report "drink out is asserted" Severity Error;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
   wait for clk_period;
   coin_in <= "00"  ;
   check_out_drink;
	assert coin_out = "01" Report "coin_out not 0.25$" Severity Error;
	wait for clk_period;

	-- test case 4
	-- testing water_soda =1 and input 1.25 => 1 then 0.25
	water_soda <= '1';
	coin_in <= "11"  ;  -- 1.0 from user
	wait for clk_period;
	coin_in <= "01"  ;  -- 0.25 from user
	assert drink_out = "00" Report "drink out is asserted" Severity Error;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
	wait for clk_period;
	coin_in <= "00"  ;  
	check_out_drink;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
 	wait for clk_period;

	--test case 5 
	-- testing water_soda =1 and input 2 => 1 then 1
	water_soda <= '1';
	coin_in <= "11"  ;  -- 1.0 from user
	wait for clk_period;
	coin_in <= "11"  ;  -- 1.0 from user
	assert drink_out = "00" Report "drink out is asserted" Severity Error;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
	wait for clk_period;
	coin_in <= "00"  ;  
	-- we need to check that it gives exchange 0.75$ as 0.5$ then 0.25 $ -- 
	assert coin_out = "10" Report "coin_out not 0.5$" Severity Error;  -- 0.5$ --
	wait for clk_period ;
 	check_out_drink;
 	assert coin_out = "01" Report "coin_out not 0.25$" Severity Error; -- 0.25$ --
  wait for clk_period ;

  -- testing reset again --
  -- testing reset
  coin_in <= "11"  ;  
   rst_n<='0';
   wait for clk_period;
   assert drink_out = "00" Report "drink out is asserted" Severity Error;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
   wait for (2*clk_period);
   rst_n<='1';


	-- When drink is Water , Water_Soda=0 --
   --test case 6
	-- testing water_soda =0 and input 1 
	water_soda <= '0';
	coin_in <= "11"  ;  -- 1.0 from user
	wait for clk_period;
	coin_in <= "00"  ;  
	check_out_drink;
	assert coin_out = "10" Report "coin_out not 0.5$" Severity Error;
	wait for clk_period ;

   --test case 7
	-- testing water_soda =0 and input 0.5 => 0.25 then 0.25
	water_soda <= '0';
	coin_in <= "01"  ;  -- 0.25 from user
	wait for clk_period;
	coin_in <= "01"  ;  -- 0.25 from user
	assert drink_out = "00" Report "drink out is asserted" Severity Error;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
	wait for clk_period;
	coin_in <= "00"  ;  
	check_out_drink;
	assert coin_out = "00" Report "coin_out not 1$" Severity Error;
	wait for clk_period ;


	--test case 8
	-- testing water_soda =0 and input 0.75 => 0.25 then 0.5
	water_soda <= '0';
	coin_in <= "01"  ;  -- 0.25 from user
	wait for clk_period;
	coin_in <= "10"  ;  -- 0.5 from user
	assert drink_out = "00" Report "drink out is asserted" Severity Error;
	assert coin_out = "00" Report "coin_out not 0$" Severity Error;
	wait for clk_period;
	coin_in <= "00"  ;  
	check_out_drink;
	assert coin_out = "01" Report "coin_out not 0.25$" Severity Error;
	wait for clk_period ;


	-- test case 9 
	-- user inputs 1.25$ => 0.25 then 1 
	water_soda <= '0';
	coin_in <= "01"  ;  -- 0.25 from user
	wait for clk_period;
	coin_in <= "11"  ;  -- 1.0 from user
	wait for clk_period;
	coin_in <= "00"  ; 
	assert drink_out = "00" Report "drink out is asserted" Severity Error;
	assert coin_out = "10" Report "coin_out not 0.5$" Severity Error;
	wait for clk_period; 
	check_out_drink;
	assert coin_out = "01" Report "coin_out not 0.25$" Severity Error;
	wait for clk_period ;



WAIT; -- stop process simulation run

END PROCESS;
END ARCHITECTURE test_vending;

