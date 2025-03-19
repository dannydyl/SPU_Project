`timescale 1ns / 1ps

module adder_tb;
    reg [3:0] A, B;
    reg Cin;
    wire [3:0] Sum;
    wire Cout;

    // Instantiate the adder module
    adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        // Monitor the outputs
        $monitor("Time = %0t | A = %b | B = %b | Cin = %b | Sum = %b | Cout = %b", 
                 $time, A, B, Cin, Sum, Cout);
        
        // Apply test vectors
        A = 4'b0000; B = 4'b0000; Cin = 0; #10;
        A = 4'b0001; B = 4'b0010; Cin = 0; #10;
        A = 4'b0110; B = 4'b0011; Cin = 1; #10;
        A = 4'b1001; B = 4'b0110; Cin = 0; #10;
        A = 4'b1111; B = 4'b0001; Cin = 1; #10;
        
        // Finish simulation
        $finish;
    end
endmodule
