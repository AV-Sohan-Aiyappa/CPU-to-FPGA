//tb_basic_gates
//created by Sohan on 10-03-2025 
//USAGE:
//It is a testbench for the basic_gates module , it consists of all the inputs for a 2 input truth table , with 10 time units delay , and also displays the values with $monitor function 
//a,b:single inputs 
//y0,y1,y2,y3,y4,y5:outputs


module tb;
    reg a;
    reg b;
    wire y0,y1,y2,y3,y4,y5;
    
    basic_gates dut(
        .a(a),
        .b(b),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3),
        .y4(y4),
        .y5(y5)
    );
    
    initial begin
        a=0;b=0;#10;
        a=0;b=1;#10;
        a=1;b=0;#10;
        a=1;b=1;#10;
        $finish;
    end 
    
    initial begin
        $monitor("Time=%0t | a=%b | b=%b | y0=%b | y1=%b | y2=%b | y3=%b | y4=%b | y5=%b ",$time,a,b,y0,y1,y2,y3,y4,y5);
    end
endmodule
