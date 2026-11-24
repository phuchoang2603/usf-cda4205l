// Verilog code for 4-bit carry generate
(* DONT_TOUCH = "true" *)
module carry_generate(
    input  [3:0] X, // 4-bit input
    input  [3:0] Y, // 4-bit input
    output [3:0] G  // 4-bit output carry generate
);
    assign G = X & Y;
endmodule
