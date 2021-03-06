----------------------------------------------------------------------------------
-- Company: 
-- Engineers: Vlad Marian Cimpeanu | Danilo Castiglia
-- 
-- Create Date: 01.02.2021 18:40:57
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

component DataPath is
    Port 
    (    
    i_clk : in std_logic;
    i_rst : in std_logic;
    i_data : in std_logic_vector(7 downto 0);
    o_address : out std_logic_vector(15 downto 0);
    o_data : out std_logic_vector (7 downto 0);
    r_sel:  in std_logic;
    r_load: in std_logic;
    r_done: out std_logic;
    rmax_load: in std_logic;
    row_zero: out std_logic;
    c_sel: in std_logic;
    c_load: in std_logic; 
    c_done: out std_logic; 
    cmax_load: in std_logic;
    column_zero: out std_logic; 
    a_sel: in std_logic; 
    a_load: in std_logic;
    e_load: in std_logic; 
    o_sel: in std_logic_vector(1 downto 0); 
    bool_end: out std_logic; 
    a_sel2: in std_logic;
    a_load2: in std_logic;
    p_load: in std_logic; 
    init: in std_logic;
    s_load: in std_logic;
    old_load: in std_logic
    );
end component;

signal r_sel: std_logic;
signal r_load: std_logic;
signal r_done: std_logic;
signal rmax_load: std_logic;
signal row_zero: std_logic;
signal c_sel: std_logic;
signal c_load: std_logic; 
signal c_done: std_logic; 
signal cmax_load: std_logic;
signal column_zero: std_logic; 
signal a_sel: std_logic; 
signal a_load: std_logic;
signal e_load: std_logic; 
signal o_sel: std_logic_vector(1 downto 0); 
signal bool_end: std_logic; 
signal a_sel2: std_logic;
signal a_load2: std_logic;
signal p_load: std_logic; 
signal init: std_logic;
signal s_load: std_logic;
signal old_load: std_logic;

type S is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14);
signal cur_state, next_state : S;

begin

    DATAPATH0: DataPath port map
    (    
    i_clk ,
    i_rst ,
    i_data,
    o_address,
    o_data ,
    r_sel,
    r_load,
    r_done,
    rmax_load,
    row_zero,
    c_sel,
    c_load, 
    c_done, 
    cmax_load,
    column_zero, 
    a_sel, 
    a_load,
    e_load, 
    o_sel, 
    bool_end, 
    a_sel2,
    a_load2,
    p_load, 
    init,
    s_load,
    old_load
    );

    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            cur_state <= S0;
        elsif rising_edge(i_clk) then
            cur_state <= next_state;
        end if;
    end process;
    
    --  NEXT STATE FUNCTION FSM  --
    
    process(cur_state, i_start, c_done, r_done, bool_end, row_zero, column_zero)
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
                next_state <= S3;
             when S3 =>
                next_state <= S4;
             when S4 =>
                next_state <= S5;
             when S5 =>
                if column_zero = '1' or row_zero = '1' then
                    next_state <= S14;
                else
                    next_state <= S6;
                end if;
             when S6 =>
                if c_done = '0' then
                    next_state <= S7;
                else
                    next_state <= S8;
                end if;
             when S7 =>
                next_state <= S6;
             when S8 =>
                if r_done = '0' then
                    next_state <= S7;
                else
                    next_state <= S9;
                end if;
             when S9 =>
                next_state <= S10;
             when S10 =>
                if bool_end = '0' then
                    next_state <= S11;
                else 
                    next_state <= S14;
                end if;
             when S11 =>
                next_state <= S12;
             when S12 =>
                next_state <= S13;
             when S13 =>
                next_state <= S10;
             when S14 =>
                if i_start = '0' then 
                    next_state <= S0;
                end if;            
        end case;
    end process;
    
    --  OUTPUT FUNCTION FSM  --
          
    process(cur_state)
    begin
        r_sel <= '1';
        r_load <= '0';
        rmax_load <= '0';
        c_sel <= '1';
        c_load <= '0';
        cmax_load <= '0';
        a_sel <= '1';
        a_load <= '0';
        e_load <= '0';
        o_sel <= "00";
        a_sel2 <= '1';
        a_load2 <= '0';
        p_load <= '0';
        init <= '0';
        s_load <= '0';
        old_load <= '0';
        o_en <= '0';
        o_we <= '0';
        o_done <= '0';
        case cur_state is
            when S0 =>
            when S1 =>
                o_en <= '1';
                o_sel <= "10";
            when S2 =>
                cmax_load <= '1';
                o_sel <= "11";
                o_en <= '1';
                a_sel <= '0';
                a_load <= '1';
                r_sel <= '0';
                r_load <= '1';
                c_sel <= '0';
                c_load <= '1';   
            when S3 =>
                rmax_load <= '1'; 
                o_en <= '1';
            when S4 =>
                p_load <= '1';
            when S5 =>
                init <= '1';
                o_en <= '1';
            when S6 =>
                c_sel <= '1';
                c_load <= '1';
                a_sel <= '1';
                a_load <= '1';
                p_load <= '1'; 
            when S7 =>
                o_en <= '1';
            when S8 =>
                r_sel <= '1';
                r_load <= '1';
                c_sel <= '0';
                c_load <= '1';
            when S9 =>
                s_load <= '1';
                e_load <= '1';
                a_sel2 <= '0';
                a_load2 <= '1';
            when S10 =>
                o_en <= '1';
                o_sel <= "01";
            when S11 =>
                old_load <= '1';
            when S12 =>
            when S13 =>
                o_en <= '1';
                o_we <= '1';
                a_sel <= '1';
                a_load <= '1';
                a_sel2 <= '1';
                a_load2 <= '1';
                o_sel <= "00";
            when S14 =>
                o_done <= '1';     
        end case;
    end process;   
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity DataPath is
  Port 
  (
    i_clk : in std_logic;
    i_rst : in std_logic;
    i_data : in std_logic_vector(7 downto 0);
    o_address : out std_logic_vector(15 downto 0);
    o_data : out std_logic_vector (7 downto 0);
    r_sel:  in std_logic;
    r_load: in std_logic;
    r_done: out std_logic;
    rmax_load: in std_logic;
    row_zero: out std_logic; 
    c_sel: in std_logic;
    c_load: in std_logic; 
    c_done: out std_logic; 
    cmax_load: in std_logic;
    column_zero: out std_logic; 
    a_sel: in std_logic; 
    a_load: in std_logic;
    e_load: in std_logic; 
    o_sel: in std_logic_vector(1 downto 0); 
    bool_end: out std_logic; 
    a_sel2: in std_logic;
    a_load2: in std_logic;
    p_load: in std_logic; 
    init: in std_logic;
    s_load: in std_logic;
    old_load: in std_logic
   );
end DataPath;

architecture Behavioral of DataPath is
signal row: std_logic_vector(7 downto 0);
signal mux_row: std_logic_vector(7 downto 0);
signal sum_row: std_logic_vector(7 downto 0);
signal row_max: std_logic_vector(7 downto 0);
signal column: std_logic_vector(7 downto 0);
signal mux_column: std_logic_vector(7 downto 0);
signal sum_column: std_logic_vector(7 downto 0);
signal column_max: std_logic_vector(7 downto 0);
signal address: std_logic_vector(15 downto 0);
signal mux_address: std_logic_vector(15 downto 0);
signal sum_address: std_logic_vector(15 downto 0);
signal end_img: std_logic_vector(15 downto 0);
signal address2: std_logic_vector(15 downto 0);
signal mux_address2: std_logic_vector(15 downto 0);
signal sum_address2: std_logic_vector(15 downto 0);
signal pixel: std_logic_vector(7 downto 0);
signal min: std_logic_vector(7 downto 0);
signal max: std_logic_vector(7 downto 0);
signal bool_max: std_logic;
signal bool_min: std_logic;
signal max_load: std_logic;
signal min_load: std_logic;
signal sub_delta: std_logic_vector(7 downto 0);
signal log_in: std_logic_vector(8 downto 0);     
signal log_out: std_logic_vector(3 downto 0);      
signal sub_shift: std_logic_vector(3 downto 0);     
signal shift_level: std_logic_vector(3 downto 0);
signal old: std_logic_vector(7 downto 0);
signal sub_old: std_logic_vector(7 downto 0);
signal shifted: std_logic_vector(15 downto 0);
signal sel_pixel: std_logic;

begin
  
    -- ROW COUNTER MODULE --
  
    with r_sel select
    mux_row <= "00000001" when '0',
               sum_row when '1',
               "XXXXXXXX" when others;
                
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                row <= "00000000";
            elsif rising_edge(i_clk) then
                if(r_load = '1') then
                    row <= mux_row;
                end if;
            end if;
    end process;
    
    sum_row <= row + "00000001";
    r_done <= '1' when (row = row_max) else '0';
    row_zero <= '1' when (row_max = "00000000") else '0';
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                row_max <= "00000000";
            elsif rising_edge(i_clk) then
                if(rmax_load = '1') then
                    row_max <= i_data;
                end if;
            end if;
    end process;
    
    --COLUMN COUNTER MODULE --
    
    with c_sel select
    mux_column <= "00000001" when '0',
               sum_column when '1',
               "XXXXXXXX" when others;
                
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                column <= "00000000";
            elsif rising_edge(i_clk) then
                if(c_load = '1') then
                    column <= mux_column;
                end if;
            end if;
    end process;
    
    sum_column <= column + "00000001"; 
    c_done <= '1' when (column = column_max) else '0';
    column_zero <= '1' when (column_max = "00000000") else '0';
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                column_max <= "00000000";
            elsif rising_edge(i_clk) then
                if(cmax_load = '1') then
                    column_max <= i_data;
                end if;
            end if;
    end process;

    -- ADDRESS COUNTER MODULE --
    
    with a_sel select
    mux_address <= "0000000000000010" when '0',
               sum_address when '1',
               "XXXXXXXXXXXXXXXX" when others;
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                address <= "0000000000000000";
            elsif rising_edge(i_clk) then
                if(a_load = '1') then
                    address <= mux_address;
                end if;
            end if;
    end process;           
           
    sum_address <= address +  "0000000000000001";
    
    with a_sel2 select
    mux_address2 <= "0000000000000010" when '0',
               sum_address2 when '1',
               "XXXXXXXXXXXXXXXX" when others;
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                address2 <= "0000000000000000";
            elsif rising_edge(i_clk) then
                if(a_load2 = '1') then
                    address2 <= mux_address2;
                end if;
            end if;
    end process;           
           
    sum_address2 <= address2 +  "0000000000000001";  
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                end_img <= "0000000000000000";
            elsif rising_edge(i_clk) then
                if(e_load = '1') then
                    end_img <= address;
                end if;
            end if;
    end process;
     
    bool_end <= '1' when (end_img = address2) else '0';
    
    with o_sel select
    o_address <= address when "00",
               address2 when "01",
               "0000000000000000" when "10",
               "0000000000000001" when "11",
               "XXXXXXXXXXXXXXXX" when others;
               
    -- MAX/MIN DETECTOR MODULE --
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                pixel <= "00000000";
            elsif rising_edge(i_clk) then
                if(p_load = '1') then
                    pixel <= i_data;
                end if;
            end if;
    end process;
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                max <= "00000000";
            elsif rising_edge(i_clk) then
                if(max_load = '1') then
                    max <= pixel;
                end if;
            end if;
    end process;
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                min <= "00000000";
            elsif rising_edge(i_clk) then
                if(min_load = '1') then
                    min <= pixel;
                end if;
            end if;
    end process;
    
    bool_max <= '1' when (pixel > max) else '0';
    bool_min <= '1' when (pixel < min) else '0';
    max_load <= bool_max or init;
    min_load <= bool_min or init;
    
    -- NEW PIXEL VALUE MODULE --
    
    sub_delta <= max - min;
    log_in <= '0' & sub_delta  + "000000001";
    log_out <= "0000" when log_in = "000000001" else           -- LOGARITHM
               "0001" when log_in = "000000010" or log_in = "000000011" else
               "0010" when log_in >= "000000100" and log_in <= "000000111" else
               "0011" when log_in >= "000001000" and log_in <= "000001111" else 
               "0100" when log_in >= "000010000" and log_in <= "000011111" else
               "0101" when log_in >= "000100000" and log_in <= "000111111" else
               "0110" when log_in >= "001000000" and log_in <= "001111111" else
               "0111" when log_in >= "010000000" and log_in <= "011111111" else
               "1000" when log_in >= "010000000" else 
               "XXXX";
    sub_shift <= "1000" - log_out;
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                shift_level <= "0000";
            elsif rising_edge(i_clk) then
                if(s_load = '1') then
                    shift_level <= sub_shift;
                end if;
            end if;
    end process;
    
    process(i_clk, i_rst)
        begin
            if(i_rst = '1') then
                old <= "00000000";
            elsif rising_edge(i_clk) then
                if(old_load = '1') then
                    old <= i_data;
                end if;
            end if;
    end process;
    
    sub_old <= old - min;
    shifted <= std_logic_vector(shift_left(unsigned("00000000" & sub_old), to_integer(unsigned(shift_level)))); --SHIFTER
    sel_pixel <= '1' when (shifted < "0000000011111111") else '0';
    
    with sel_pixel select
    o_data <=  "11111111" when '0',
               shifted(7 downto 0) when '1',
               "XXXXXXXX" when others;
end Behavioral;
