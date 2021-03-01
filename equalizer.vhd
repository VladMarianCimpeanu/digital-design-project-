----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.03.2021 18:40:57
-- Design Name: 
-- Module Name: project_reti_logiche - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_reti_logiche is
  Port 
  (
    i_clk : in std_logic;
    i_rst : in std_logic;
    i_start : in std_logic;
    i_data : in std_logic_vector(7 downto 0);
    o_address : out std_logic_vector(15 downto 0);
    o_done : out std_logic;
    o_en : out std_logic;
    o_we : out std_logic;
    o_data : out std_logic_vector (7 downto 0)
   );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
signal r_sel: std_logic;
signal r_load: std_logic;
signal r_done: std_logic;
signal rmax_load: std_logic;
signal c_sel: std_logic;
signal c_load: std_logic; 
signal c_done: std_logic; 
signal cmax_load: std_logic; 
signal a_sel: std_logic; 
signal a_load: std_logic;
signal e_load: std_logic; 
signal o_sel: std_logic; 
signal bool_end: std_logic; 
signal a_sel2: std_logic;
signal a_load2: std_logic;
signal p_load: std_logic; 
signal init: std_logic;
signal s_load: std_logic;
signal old_load: std_logic;

type S is (S0, S1, S2, Si, Si2, S3, Sg, S4, S5, S6, S7, S8);
signal cur_state, next_state : S;

begin

    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            cur_state <= S0;
        elsif rising_edge(i_clk) then
            cur_state <= next_state;
        end if;
    end process;
    process(cur_state, i_start, c_done, r_done, bool_end)
    begin
        next_state <= cur_state;
        case cur_state is    
             when S0 =>
                 if i_start = '1' then
                    next_state <= S1;
                 end if;
             when S1 =>
                next_state <= S2;
             when S2 =>
                next_state <= Si;
             when Si =>
                next_state <= Si2;
             when Si2 =>
                next_state <= S3;
             when S3 =>
                if c_done = '0' then
                    next_state <= Sg;
                else
                    next_state <= S4;
                end if;
             when Sg =>
                next_state <= S3;
             when S4 =>
                if r_done = '0' then
                    next_state <= Sg;
                else
                    next_state <= S5;
                end if;
             when S5 =>
                next_state <= S6;
             when S6 =>
                if bool_end = '0' then
                    next_state <= S7;
                else 
                    next_state <= S8;
                end if;
             when S7 =>
                next_state <= S6;
             when S8 =>
                if i_start = '0' then 
                    next_state <= S0;
                end if;            
        end case;
    end process;
    
    process(cur_state)
    begin
        r_sel <= '1';
        r_load <= '0';
        --r_done <= '';
        rmax_load <= '0';
        c_sel <= '1';
        c_load <= '0';
        --c_done <= 
        cmax_load <= '0';
        a_sel <= '1';
        a_load <= '0';
        e_load <= '0';
        o_sel <= '0';
        --bool_end <= '';
        a_sel2 <= '1';
        a_load2 <= '0';
        p_load <= '0';
        init <= '0';
        s_load <= '0';
        old_load <= '0';
        o_address <= "0000000000000000";
        o_en <= '0';
        o_we <= '0';
        o_data <= "00000000";
        o_done <= '0';
        case cur_state is
            when S0 =>
            when S1 =>
                o_en <= '1';
                cmax_load <= '1';
            when S2 =>
                o_address <= "0000000000000001";
                o_en <= '1';
                rmax_load <= '1';
                a_sel <= '0';
                a_load <= '1';
                r_sel <= '0';
                r_load <= '1';
                c_sel <= '0';
                c_load <= '0';   
            when Si =>
                o_en <= '1';
                p_load <= '1';
            when Si2 =>
                init <= '1';
            when S3 =>
                c_sel <= '1';
                c_load <= '1';
                a_sel <= '1';
                a_load <= '1';
            when Sg =>
                p_load <= '1';
                o_en <= '1';
            when S4 =>
                r_sel <= '1';
                r_load <= '1';
                c_sel <= '0';
                c_load <= '1';
            when S5 =>
                s_load <= '1';
                e_load <= '1';
                a_sel2 <= '0';
                a_load2 <= '1';
                o_sel <= '1'; ----BLU ?????
            when S6 =>
                o_en <= '1';
                old_load <= '1';
                o_sel <= '0'; ----- BLUU ???
            when S7 =>
                o_en <= '1';
                o_we <= '1';
                a_sel <= '1';
                a_load <= '1';
                a_sel2 <= '1';
                a_load2 <= '1';
                o_sel <= '1'; -----BLU ???
            when S8 =>
                o_done <= '1';     
        end case;
    end process;   
end Behavioral;
