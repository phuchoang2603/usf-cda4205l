// Verilog code for 1-bit full adder
(* DONT_TOUCH = "true" *)
module fulladder(
    input  X,   // 1-bit input
    input  Y,   // 1-bit input
    input  Cin, // 1-bit input carry in
    output S,   // 1-bit output sum
    output Cout // 1-bit output carry out
);
    
    // --- enter your code here
    wire wire1, wire2, wire3;

    assign wire1 = X ^ Y;
    assign wire2 = wire1 & Cin;  
    assign wire3 = X & Y;
    
    assign S    = wire1 ^ Cin;
    assign Cout = wire2 | wire3;
    
    // --- end your code here
endmodule

