// Verilog code for 4-bit ripple-carry adder
(* DONT_TOUCH = "true" *)
`include "fulladder.v"
module ripple_carry_adder(
    input  [3:0] X,
    input  [3:0] Y,
    input  Cin,
    output [3:0] S,
    output Cout
);
    wire C1, C2, C3;  //declare intermediate carry wires

    fulladder fulladder1 (.X(X[0]), .Y(Y[0]), .Cin(Cin), .S(S[0]), .Cout(C1));
    fulladder fulladder2 (.X(X[1]), .Y(Y[1]), .Cin(C1),  .S(S[1]), .Cout(C2));
    fulladder fulladder3 (.X(X[2]), .Y(Y[2]), .Cin(C2),  .S(S[2]), .Cout(C3));
    fulladder fulladder4 (.X(X[3]), .Y(Y[3]), .Cin(C3),  .S(S[3]), .Cout(Cout));

endmodule