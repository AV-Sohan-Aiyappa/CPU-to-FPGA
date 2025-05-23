//basic_gates_module
//made by Sohan on 10-03-2025
//USAGE:
// basic_gates is a circuit that has two input AND,OR,NOT,NAND,NOR,XOR logic gates
//a,b : single inputs 
// y0,y1,y2,y3,y4,y5 :  outputs 

module basic_gates(
    input a,
    input b,
    output y0,
    output y1,
    output y2,
    output y3,
    output y4,
    output y5
    );
    
    assign y0=a&b;
    assign y1=a|b;
    assign y2=~a;
    assign y3=~(a&b);
    assign y4=~(a|b);
    assign y5=a^b;
endmodule
