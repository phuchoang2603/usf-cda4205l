//Verilog code for 4-bit carry propagate
(* DONT_TOUCH = "true" *)
module carry_propagate(
    input  [3:0] X, // 4-bit input
    input  [3:0] Y, // 4-bit input
    output [3:0] P  // 4-bit output carry propagate
);
    
    // --- enter your code here
    
    assign P = X ^ Y;
    // --- end your code here
endmodule
