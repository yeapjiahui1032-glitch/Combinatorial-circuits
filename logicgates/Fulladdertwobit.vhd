library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity FULLADDER2 is
  port (
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Cin : in STD_LOGIC;
    Cout : out STD_LOGIC;
    SUM : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of FULLADDER2 : entity is "FULLADDER2,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=FULLADDER2,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of FULLADDER2 : entity is "FULLADDER2.hwdef";
end FULLADDER2;

architecture STRUCTURE of FULLADDER2 is
  component FULLADDER2_AND2_gate_0_0 is
  port (
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
  end component FULLADDER2_AND2_gate_0_0;
  component FULLADDER2_XOR2_gate_0_0 is
  port (
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
  end component FULLADDER2_XOR2_gate_0_0;
  component FULLADDER2_AND2_gate_0_1 is
  port (
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
  end component FULLADDER2_AND2_gate_0_1;
  component FULLADDER2_XOR2_gate_0_1 is
  port (
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
  end component FULLADDER2_XOR2_gate_0_1;
  component FULLADDER2_OR2_gate1_0_0 is
  port (
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Y : out STD_LOGIC
  );
  end component FULLADDER2_OR2_gate1_0_0;
  signal AND2_gate_0_Y : STD_LOGIC;
  signal AND2_gate_1_Y : STD_LOGIC;
  signal A_1 : STD_LOGIC;
  signal B_1 : STD_LOGIC;
  signal Cin_1 : STD_LOGIC;
  signal OR2_gate1_0_Y : STD_LOGIC;
  signal XOR2_gate_0_Y : STD_LOGIC;
  signal XOR2_gate_1_Y : STD_LOGIC;
begin
  A_1 <= A;
  B_1 <= B;
  Cin_1 <= Cin;
  Cout <= OR2_gate1_0_Y;
  SUM <= XOR2_gate_1_Y;
AND2_gate_0: component FULLADDER2_AND2_gate_0_0
     port map (
      A => XOR2_gate_0_Y,
      B => Cin_1,
      Y => AND2_gate_0_Y
    );
AND2_gate_1: component FULLADDER2_AND2_gate_0_1
     port map (
      A => A_1,
      B => B_1,
      Y => AND2_gate_1_Y
    );
OR2_gate1_0: component FULLADDER2_OR2_gate1_0_0
     port map (
      A => AND2_gate_0_Y,
      B => AND2_gate_1_Y,
      Y => OR2_gate1_0_Y
    );
XOR2_gate_0: component FULLADDER2_XOR2_gate_0_0
     port map (
      A => A_1,
      B => B_1,
      Y => XOR2_gate_0_Y
    );
XOR2_gate_1: component FULLADDER2_XOR2_gate_0_1
     port map (
      A => XOR2_gate_0_Y,
      B => Cin_1,
      Y => XOR2_gate_1_Y
    );
end STRUCTURE;