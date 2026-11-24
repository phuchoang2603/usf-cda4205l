// Verilog code for 4-bit carry look-ahead adder
(* DONT_TOUCH = "true" *)
`include "carry_propagate.v"
`include "carry_generate.v"
`include "look_ahead_carry.v"

module carry_look_ahead_adder(
    input  [3:0] X,
    input  [3:0] Y,
    input  Cin,
    output [3:0] S,
    output Cout
);
    wire [3:0] P;   // propagate
    wire [3:0] G;   // generate
    wire [4:0] C;   // carries: C[0]=Cin, C[4]=Cout

    carry_propagate cp (
        .X(X),
        .Y(Y),
        .P(P)
    );

    carry_generate cg (
        .X(X),
        .Y(Y),
        .G(G)
    );

    look_ahead_carry lac (
        .Cin(Cin),
        .P(P),
        .G(G),
        .C(C)
    );

    // Sum = Propagate XOR carry-in at each bit
    assign S    = P ^ C[3:0];
    assign Cout = C[4];

endmodule
