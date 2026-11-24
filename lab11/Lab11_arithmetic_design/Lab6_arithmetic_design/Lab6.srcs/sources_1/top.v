// Verilog Testbench for 4-bits Adder
(* DONT_TOUCH = "true" *)
module top(
    input  [8:0] SW,
    output [4:0] LED
);
    wire [3:0] X; // 4-bit input
    wire [3:0] Y; // 4-bit input
    wire Cin;     // 1-bit input carry in
    wire [3:0] S; // 4-bit output sum
    wire Cout;
    
    assign X   = SW[3:0];
    assign Y   = SW[7:4];
    assign Cin = SW[8];
    assign LED[3:0] = S;
    assign LED[4] = Cout;
    
    // uncomment to: instantiate 4-bits ripple-carry adder in Verilog
    //ripple_carry_adder RC_ADD0(.X(X), .Y(Y), .Cin(Cin), .S(S), .Cout(Cout));
    
    // uncomment to: instantiate 4-bits carry look-ahead adder in Verilog
    carry_look_ahead_adder CLA_ADD0(.X(X), .Y(Y), .Cin(Cin), .S(S), .Cout(Cout));
    
    
endmodule
