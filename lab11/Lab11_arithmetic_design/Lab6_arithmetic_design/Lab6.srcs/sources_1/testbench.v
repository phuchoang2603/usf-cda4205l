`timescale 1ns / 1ps

module testbench;
    // Inputs
    reg  [3:0] X; // 4-bit input
    reg  [3:0] Y; // 4-bit input
    reg  Cin;     // 1-bit input carry in
    
    // Outputs
    wire [3:0] S; // 4-bit output sum
    wire Cout;    // 1-bit output carry out
    
    // Correct (True) Expected Output
    /* These will show you the correct results that you should get (for testing only) */
    wire [3:0] true_S; // 4-bit output sum
    wire true_Cout;    // 1-bit output carry out
    
    // Tracks number of correct results compare to the expected true S and Cout
    integer score = 0;
    
    // uncomment to: instantiate 4-bits ripple-carry adder in Verilog
    //ripple_carry_adder RC_ADD0(.X(X), .Y(Y), .Cin(Cin), .S(S), .Cout(Cout));
    
    // uncomment to: instantiate 4-bits carry look-ahead adder in Verilog
     carry_look_ahead_adder CLA_ADD0(.X(X), .Y(Y), .Cin(Cin), .S(S), .Cout(Cout));
    
    
    // Simulation Test True Results (Expected)
    assign true_S    = (X+Y+Cin);             /* shows the true S value (4 LSB of the true sum) */
    assign true_Cout = ((X+Y+Cin)>15)? 1 : 0; /* shows the true Cout value (1 MSB of the true sum = carry out) */
    
    
    // Simulation Tests
    initial begin
        // Test #1
        X   <= 0;
        Y   <= 0;
        Cin <= 0;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Test #2
        X   <= 7;
        Y   <= 2;
        Cin <= 1;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Test #3
        X   <= 3;
        Y   <= 9;
        Cin <= 0;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Test #4
        X   <= 14;
        Y   <= 11;
        Cin <= 0;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Test #5
        X   <= 7;
        Y   <= 13;
        Cin <= 1;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Test #6
        X   <= 12;
        Y   <= 5;
        Cin <= 0;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Test #7
        X   <= 13;
        Y   <= 13;
        Cin <= 1;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Test #8
        X   <= 0;
        Y   <= 15;
        Cin <= 0;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Test #9
        X   <= 15;
        Y   <= 0;
        Cin <= 1;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Test #10
        X   <= 15;
        Y   <= 15;
        Cin <= 1;
        
        #50; /* Wait 50 ns */
        if((Cout == true_Cout) & (S == true_S)) begin
            score <= score + 1; /* increase score if correct outputs */
        end
        #50; /* Wait 50 ns */
        
        // Display Score
        $display("\n\n\n---------------------------");
        $display("Final Score = %2d / 10", score);
        $display("---------------------------\n\n\n");
    end
endmodule
