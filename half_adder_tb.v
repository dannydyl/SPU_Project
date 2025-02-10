`timescale 1ns / 1ps

module half_adder_tb;
    reg a, b;         // Testbench input signals
    wire sum, carry;  // Output wires

    // Instantiate the half adder module
    half_adder uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        // Display header
        $display("Time | A B | Sum Carry");
        $monitor("%0t | %b %b |  %b    %b", $time, a, b, sum, carry);

        // Test all possible input combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        // Finish simulation
        $finish;
    end
endmodule
