library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity Vending_Machine is 
  
  port ( ck, rst_n, water_soda : in bit                       ; 
         vdd, vss               : in bit                      ;
         coin_in                : in bit_vector  (1 downto 0) ;
         coin_out, drink_out    : out bit_vector (1 downto 0)
       );
end Vending_Machine;

-- Archtecture behavioral -- 
architecture behavioral of Vending_Machine is 

-- Enumerated type for states -- 
type state_type is (idle, s0_25, s0_5, s0_75, s1, s1_25, s1_5, s1_75, s2); 
  
-- internal signals declaration -- 
signal CS: state_type;
signal NS: state_type;

-- pragma current_state CS
-- pragma next_state NS
-- pragma clock ck

begin 
-- State transitions process -- 
state_transition : process (ck)
begin 
  
  if (ck = '1' and not ck' stable)
    then CS <= NS; 
  end if;
  
end process;
-- next state logic process -- 
next_state_logic : process (ck, rst_n, coin_in, water_soda, CS)
begin 
  
  if (rst_n = '0') then     
      NS <= idle;     
  else    
    case CS is 
      when idle  => 
        if    ( coin_in = "01") then NS <= s0_25 ; 
        elsif ( coin_in = "10") then NS <= s0_5  ;
        elsif ( coin_in = "11") then NS <= s1    ;
        else                         NS <= idle  ;
        end if;
                    
      when s0_25 =>
        if    ( coin_in = "01") then NS <= s0_5   ; 
        elsif ( coin_in = "10") then NS <= s0_75  ;
        elsif ( coin_in = "11") then NS <= s1_25  ;
        else                         NS <= s0_25  ;
        end if;    
            
      when s0_5  =>
        if     ( coin_in = "01") then NS <= s0_75  ; 
        elsif  ( coin_in = "10") then NS <= s1     ;
        elsif  ( coin_in = "11") then NS <= s1_5   ;
        elsif  ( water_soda = '1') then NS <= s0_5 ; -- want soda so wait for another money input --
        else                            NS <= idle ; -- want water so give him water and exchange then go back to idle --
        end if;    
            
      when s0_75 =>
        if     ( coin_in = "01") then NS <= s1     ; 
        elsif  ( coin_in = "10") then NS <= s1_25  ;
        elsif  ( coin_in = "11") then NS <= s1_75  ;
        elsif  ( water_soda = '1') then NS <= s0_75; -- want soda so wait for another money input --
        else                            NS <= idle ; -- want water so give him water and exchange then go back to idle --
        end if ;    
            
      when s1    =>
        if     ( coin_in = "01") then NS <= s1_25  ; 
        elsif  ( coin_in = "10") then NS <= s1_5   ;
        elsif  ( coin_in = "11") then NS <= s2     ;
        elsif  ( water_soda = '1') then NS <= s1   ; -- want soda so wait for another money input --
        else                            NS <= idle ; -- want water so give him water and exchange then go back to idle --      
        end if ;    
            
      when s1_25 =>
        if      ( water_soda = '1') then NS <= idle ;
        else                             NS <= s1_5 ; -- wants water -- 
        end if;
        
      when s1_5  =>
        NS <= idle;
            
      when s1_75 =>
        NS <= idle;

      when s2 =>
        NS <= s1_5;
                
      when others => 
        NS <= idle;
              
    end case;

     -- output logic -- 

     case CS is 
      when idle  => 
          coin_out  <= "00";
          drink_out <= "00";   
              
      when s0_25 =>
          coin_out  <= "00";
          drink_out <= "00";   
              
      when s0_5  =>
        if ( water_soda = '1' ) then
          coin_out  <= "00";
          drink_out <= "00";   
        else
          coin_out  <= "00";
          drink_out <= "01";             
        end if;
                  
      when s0_75 =>
        if ( water_soda = '1' ) then
          coin_out  <= "00";
          drink_out <= "00";   
        else
          coin_out  <= "01";
          drink_out <= "01";      
        end if;
                         
      when s1    =>
        if ( water_soda = '1' ) then
          coin_out  <= "00";
          drink_out <= "00";   
        else
          coin_out  <= "10";
          drink_out <= "01";    
        end if;
                   
      when s1_25 =>
        if ( water_soda = '1' ) then
          coin_out  <= "00";
          drink_out <= "11";   
        else
          coin_out  <= "10"; -- return half and no output then quarter with output -- 
          drink_out <= "00";    
        end if;    
                    
      when s1_5  =>
        if (  water_soda = '1' ) then
          coin_out  <= "01";
          drink_out <= "11";   
        else
          coin_out  <= "01"; -- give him the other quarter -- 
          drink_out <= "01";      
        end if;        
                  
      when s1_75 =>
        if ( water_soda = '1' ) then
          coin_out  <= "10";
          drink_out <= "11";   
        else
          coin_out  <= "00";
          drink_out <= "00";      
        end if;   
        
       when s2 =>
        if ( water_soda = '1' ) then
          coin_out  <= "10"; -- output is 0.5 and it will return 0.25 in the next clk cycle with the soda --
          drink_out <= "00";   
        else
          coin_out  <= "00";
          drink_out <= "00";      
        end if; 
                 
      when others => 
          coin_out  <= "00";
          drink_out <= "00";  
           
    end case;  

  end if    ;
end process;
    
end behavioral;
