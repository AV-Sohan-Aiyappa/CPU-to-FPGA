// Mult.asm
// Created by Sohan o 11-05-2025
// Computes R0 * R1 and stores result in R2

@R0
D=M              
@MULTIPLICAND
M=D              

@R1
D=M              
@COUNTER
M=D              

@0
D=A              
@R2
M=D              

(LOOP)
@COUNTER
D=M
@END
D;JEQ            

@MULTIPLICAND
D=M
@R2
M=D+M            

@COUNTER
M=M-1            

@LOOP
0;JMP            

(END)
@END
0;JMP            
