library IEEE;
use IEEE.std_logic_1164.all;
entity project_entity_TB is
end project_entity_TB;
architecture project_architecture_TB of project_entity_TB is -- should include
IEEE.std_logic_1164.all
--------------------- Component Declaration ----------------------
component project_entity
port(
clk, reset, I1, I2, I3, I4: in std_logic;
I5: in std_logic_vector(7 downto 0);
fdoor, rdoor, buzz, alarm, heat, cool: out std_logic;
disp: out std_logic_vector(2 downto 0)
);
end component;
------------------------------------------------------------------
--------------- Signals and Constants Declarations ---------------
signal clks, I1s, I2s, I3s, I4s: std_logic;
signal I5s: std_logic_vector(7 downto 0);
signal resets: std_logic := '0';
signal fdoors, rdoors, buzzs, alarms, heats, cools: std_logic;
signal disps: std_logic_vector(2 downto 0);
constant clock_period : time := 10 ns;
------------------------------------------------------------------
begin
---------------------------- Port Map ----------------------------
project_entity_pm: project_entity port map(
clk => clks,
reset => resets,
I1 => I1s,
I2 => I2s,
I3 => I3s,
I4 => I4s,
I5 => I5s,
fdoor => fdoors,
rdoor => rdoors,
buzz => buzzs,
alarm => alarms,
heat => heats,
cool => cools,
disp => disps
);
------------------------------------------------------------------
----------------------- (1) clk_PR Process -----------------------
14
clk_PR: process -- the system waits until the process generates on the clock
begin
clks <= '0';
wait for clock_period/2;
clks <= '1';
wait for clock_period/2;
end process clk_PR;
------------------------------------------------------------------
-------------------- (2) stimulus_PR Process ---------------------
stimulus_PR: process -- generates on the outputs and the simulation
begin
--------------------------------- Case(1): Rear Door is closed, Heater is turned on.
I1s <= '0';
I2s <= '1'; -- (close the Rear Door!)
I3s <= '0';
I4s <= '0';
I5s <= "00111001"; -- 57? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "00110000"; -- 48? F (turn on Heater!)
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "00110100"; -- 52? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "00111011"; -- 59? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "01000000"; -- 64? F
wait for clock_period;
--------------------------------- Case(2): Window is closed.
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "00110100"; -- 52? F
wait for clock_period;
I1s <= '0';
15
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "00111001"; -- 57? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '1'; -- (close the Window!)
I4s <= '0';
I5s <= "00111011"; -- 59? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "01000000"; -- 64? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "00111000"; -- 56? F
wait for clock_period;
--------------------------------- Case(3): Smoke Alarm is turned on, Cooler is turned on.
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "00110100"; -- 52? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "00111011"; -- 59? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '0';
I5s <= "01000001"; -- 65? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
I3s <= '0';
I4s <= '1'; -- (turn on Smoke Alarm!)
I5s <= "01000100"; -- 68? F
wait for clock_period;
I1s <= '0';
I2s <= '0';
16
I3s <= '0';
I4s <= '0';
I5s <= "01001011"; -- 75? F (turn on Cooler!)
wait for clock_period;
end process stimulus_PR;
------------------------------------------------------------------
end project_architecture_TB;