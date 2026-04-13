library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity 7SEGMENTDISPLAY is
--  Port ( );
end 7SEGMENTDISPLAY;

architecture Behavioral of 7SEGMENTDISPLAY is

begin
// 4-bit adder/subtractor
module add_sub_4bit (
  input  [3:0] a, b,
  input        cin,      // 0 = add, 1 = sub (invert B)
  output [3:0] sum,
  output       cout
);

  wire [3:0] b_inv = cin ? ~b : b;
  wire       cin_final = cin;   // +1 for 2's-complement

  ripple_adder_4bit adder (.a(a), .b(b_inv), .cin(cin_final), .s(sum), .cout(cout));

endmodule

module mult_4bit (
  input  [3:0] a, b,
  output [7:0] p
);

  assign p = a * b;

endmodule
module div_4bit (
  input  [3:0] a, b,
  input        en,          // guard against /0
  output [3:0] q,
  output [3:0] r
);

  assign q = (b == 0) ? 4'd0 : (en ? a / b : 4'd0);
  assign r = (b == 0) ? a  : (en ? a % b : 4'd0);

endmodule
module bcd_2_7seg (
  input  [3:0] bcd,
  output [6:0] seg    // CA, CB, CC, CD, CE, CF, CG (active-low)
);

  always @(*) begin
    case (bcd)
      4'd0: seg = 7'b1000000;
      4'd1: seg = 7'b1111001;
      4'd2: seg = 7'b0100100;
      4'd3: seg = 7'b0110000;
      4'd4: seg = 7'b0011001;
      4'd5: seg = 7'b0010010;
      4'd6: seg = 7'b0000010;
      4'd7: seg = 7'b1111000;
      4'd8: seg = 7'b0000000;
      4'd9: seg = 7'b0010000;
      default: seg = 7'b1111111; // blank
    endcase
  end

endmodule
module seg7_ctrl (
  input        clk_100m,
  input  [15:0] hex_in,   // 16-bit hex value (Yours: 8-bit result, upper 8 = 0)
  output [3:0]  anode,
  output [6:0]  seg
);
module top (
  input        clk_100m,
  input  [15:0] sw,
  input  [4:0]  btn,
  output [15:0] led,
  output [3:0]  anode,
  output [6:0]  seg
);

  wire [3:0] a = sw[3:0];
  wire [3:0] b = sw[7:4];

  wire [3:0] op_sel = btn[3:2];   // 2 bits: 0=add, 1=sub, 2=mul, 3=div

  // ALU outputs
  wire [3:0] alu_add_sub;
  wire [7:0] alu_mul;
  wire [3:0] alu_div_q;
  wire [3:0] alu_div_r;

  wire [7:0] result;   // 0-9 for add/sub, 0-16 for mul, 0-15 for div

  add_sub_4bit addsub (
    .a(a), .b(b),
    .cin(op_sel[0] & (op_sel[1]==0)), // when op_sel=1 (sub), cin=1
    .sum(alu_add_sub),
    .cout()
  );

  mult_4bit mult (
    .a(a), .b(b), .p(alu_mul)
  );

  div_4bit div (
    .a({2'b00, a}),
    .b({2'b00, b}),
    .en(op_sel[1:0] == 2'b11),
    .q(alu_div_q),
    .r(alu_div_r)
  );

  // choose operation output
  always @(*) begin
    case (op_sel)
      2'b00: result = {4'd0, alu_add_sub};   // 0-15
      2'b01: result = {4'd0, alu_add_sub};   // 0-15 (sub gives 4-bit unsigned)
      2'b10: result = alu_mul;               // 0-16
      2'b11: result = {4'd0, alu_div_q};     // 0-15
      default: result = 8'd0;
    endcase
  end

  // 7-seg driver on 8-bit result
  wire [15:0] hex_to_display = {8'd0, result};   // upper 8 zero

  seg7_ctrl disp (
    .clk_100m(clk_100m),
    .hex_in(hex_to_display),
    .anode(anode),
    .seg(seg)
  );

  assign led[7:0] = result;   // optional: show binary on LEDs

endmodule

end Behavioral;
