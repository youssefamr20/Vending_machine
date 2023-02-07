library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.all;

ENTITY vending_machine_test_sc IS
END ENTITY vending_machine_test_sc;

ARCHITECTURE test_vending_sc OF vending_machine_test_sc IS


-- Component Declaration for the Device Under Test (DUT)
COMPONENT Vending_Machine IS
  port ( ck, rst_n, water_soda  : in bit                            ; 
         vdd, vss               : in bit                            ;
         coin_in                : in bit_vector  (1 downto 0) ;
         coin_out               : out bit_vector (1 downto 0) ;
         drink_out              : out bit_vector (1 downto 0)
       );
END COMPONENT Vending_Machine;

component vending_machinej_b_l_sc is
   port (
      ck         : in      bit;
      rst_n      : in      bit;
      water_soda : in      bit;
      vdd        : in      bit;
      vss        : in      bit;
      coin_in    : in      bit_vector(1 downto 0);
      coin_out   : out     bit_vector(1 downto 0);
      drink_out  : out     bit_vector(1 downto 0);
      scanin     : in      bit;
      test       : in      bit;
      scanout    : out     bit
 );
end COMPONENT vending_machinej_b_l_sc;


FOR dut: Vending_Machine USE ENTITY WORK.Vending_Machine(behavioral);
FOR dut_sc: vending_machinej_b_l_sc USE ENTITY WORK.vending_machinej_b_l_sc(structural);

-- Declare input signals and initialize them
SIGNAL ck           : bit :=  '0';
SIGNAL vdd          : bit :=  '1';
SIGNAL vss          : bit :=  '0';
SIGNAL rst_n        : bit :=  '1';
SIGNAL water_soda   : bit :=  '0';

SIGNAL coin_in    : bit_vector  (1 downto 0) :="00"  ;
-- Constants and Clock period definitions
SIGNAL scanin           : bit :=  '0';
SIGNAL test             :  bit :=  '0';
SIGNAL  scanout         : bit :=  '0';

SIGNAL drink_out    : bit_vector  (1 downto 0) :="00"  ;
SIGNAL coin_out     : bit_vector  (1 downto 0) :="00"  ;

SIGNAL drink_out_sc    : bit_vector  (1 downto 0):="00" ;
SIGNAL coin_out_sc    : bit_vector  (1 downto 0)  :="00" ;

constant clk_period : time := 1000 ns;   -- as our freq is 1MHz
constant sequence : bit_vector := "0101";

BEGIN

-- Instantiate the Device Under Test (DUT)
dut:  Vending_Machine PORT MAP ( ck, rst_n, water_soda , vdd, vss,coin_in ,coin_out , drink_out);
dut_sc : vending_machinej_b_l_sc PORT MAP ( ck, rst_n, water_soda , vdd, vss , coin_in  ,coin_out_sc , drink_out_sc , scanin ,test , scanout );

-- Clock process definitions( clock with 50% duty cycle )
   clk_process :process 
   begin
        ck  <= '0';
        wait for clk_period/2;  
        ck  <= '1';
        wait for clk_period/2;  
   end process;



test_proc: PROCESS IS
BEGIN
   
   -- test case 1 
   -- testing coin_in = 0.5$ & drink is water 
   wait for clk_period;
   test <= '0';
  water_soda <= '0';
  coin_in <= "11"  ;
  wait for clk_period;
 coin_in <= "00"  ;
   assert coin_out_sc=coin_out Report "coin_out isnt equal" Severity Error;
  assert drink_out_sc=drink_out Report "drink_out isnt equal" Severity Error;
  wait for clk_period;
  assert coin_out_sc=coin_out Report "coin_out isnt equal" Severity Error;
  assert drink_out_sc=drink_out Report "drink_out isnt equal" Severity Error;

   wait for clk_period;
   test <= '0';
  water_soda <= '1';
  coin_in <= "11"  ;
  wait for clk_period;
 coin_in <= "00"  ;
   assert coin_out_sc=coin_out Report "coin_out isnt equal" Severity Error;
  assert drink_out_sc=drink_out Report "drink_out isnt equal" Severity Error;
  wait for clk_period;

   wait for clk_period;
   test <= '0';
  water_soda <= '0';
  coin_in <= "10"  ;
  wait for clk_period;
 coin_in <= "00"  ;
   assert coin_out_sc=coin_out Report "coin_out isnt equal" Severity Error;
  assert drink_out_sc=drink_out Report "drink_out isnt equal" Severity Error;
  wait for clk_period;

   test <= '1';

   for i In 0 to sequence'length-1 loop
   scanin <= sequence(i); -- Assign values to circuit inputs.
   wait for clk_period; -- Wait to "propagate" values
  -- Check output against expected result.
    if i>=4 then -- 4 registers in the scan chain

  Assert scanout=sequence(i-4)
  Report "scanout does not follow scan in"
  Severity error;

end if;
end loop;

WAIT; -- stop process simulation run

END PROCESS;
END ARCHITECTURE test_vending_sc;