library IEEE;
use IEEE.std_logic_1164.all;
entity project_entity is -- should include IEEE.std_logic_1164.all
port(
clk, reset, I1, I2, I3, I4: in std_logic;
I5: in std_logic_vector(7 downto 0);
fdoor, rdoor, buzz, alarm, heat, cool: out std_logic;
disp: out std_logic_vector(2 downto 0)
);
end project_entity;
architecture project_architecture of project_entity is
type states is (start, closeFdoor, closeRdoor, Wbuzz, Salarm, heater, cooler);
signal cur_st, nxt_st: states;
begin
cur_st_pr: process(clk, reset)
begin
if (reset = '1') then
cur_st <= start;
elsif (rising_edge(clk)) then
cur_st <= nxt_st;
end if;
end process cur_st_pr;
nxt_st_pr: process(cur_st, I1, I2, I3, I4, I5)
begin
case cur_st is
when start =>
if (I1 = '1') then
nxt_st <= closeFdoor;
elsif (I2 = '1') then
nxt_st <= closeRdoor;
elsif (I3 = '1') then
nxt_st <= Wbuzz;
elsif (I4 = '1') then
nxt_st <= Salarm;
elsif (I5 < "00110010") then
nxt_st <= heater;
elsif (I5 > "01000110") then
nxt_st <= cooler;
else
nxt_st <= start;
end if;
when closeFdoor =>
10
if (I2 = '1') then
nxt_st <= closeRdoor;
elsif (I3 = '1') then
nxt_st <= Wbuzz;
elsif (I4 = '1') then
nxt_st <= Salarm;
elsif (I5 < "00110010") then
nxt_st <= heater;
elsif (I5 > "01000110") then
nxt_st <= cooler;
else
nxt_st <= start;
end if;
when closeRdoor =>
if (I3 = '1') then
nxt_st <= Wbuzz;
elsif (I4 = '1') then
nxt_st <= Salarm;
elsif (I5 < "00110010") then
nxt_st <= heater;
elsif (I5 > "01000110") then
nxt_st <= cooler;
else
nxt_st <= start;
end if;
when Wbuzz =>
if (I4 = '1') then
nxt_st <= Salarm;
elsif (I5 < "00110010") then
nxt_st <= heater;
elsif (I5 > "01000110") then
nxt_st <= cooler;
else
nxt_st <= start;
end if;
when Salarm =>
if (I5 < "00110010") then
nxt_st <= heater;
elsif (I5 > "01000110") then
nxt_st <= cooler;
else
nxt_st <= start;
end if;
when heater =>
if (I5 > "01000110") then
nxt_st <= cooler;
else
nxt_st <= start;
end if;
when cooler =>
11
nxt_st <= start;
end case;
end process nxt_st_pr;
out_reg_pr: process(clk, reset)
begin
case cur_st is
when start =>
fdoor <= '0';
rdoor <= '0';
buzz <= '0';
alarm <= '0';
cool <= '0';
heat <= '0';
disp <= "000";
when closeFdoor =>
fdoor <= '1';
rdoor <= '0';
buzz <= '0';
alarm <= '0';
cool <= '0';
heat <= '0';
disp <= "001";
when closeRdoor =>
fdoor <= '0';
rdoor <= '1';
buzz <= '0';
alarm <= '0';
cool <= '0';
heat <= '0';
disp <= "010";
when Wbuzz =>
fdoor <= '0';
rdoor <= '0';
buzz <= '1';
alarm <= '0';
cool <= '0';
heat <= '0';
disp <= "011";
when Salarm =>
fdoor <= '0';
rdoor <= '0';
buzz <= '0';
alarm <= '1';
cool <= '0';
heat <= '0';
disp <= "100";
when heater =>
fdoor <= '0';
rdoor <= '0';
12
buzz <= '0';
alarm <= '0';
heat <= '1';
cool <= '0';
disp <= "101";
when cooler =>
fdoor <= '0';
rdoor <= '0';
buzz <= '0';
alarm <= '0';
heat <= '0';
cool <= '1';
disp <= "110";
end case;
end process out_reg_pr;
end project_architecture;