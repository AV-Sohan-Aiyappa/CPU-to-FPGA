// Fill.asm
// created by sohan on 11-05-20205
// Continuously fills screen with black if key is pressed, or white otherwise

(START)
@KBD
D=M            
@BLACK
D;JNE          
@WHITE
0;JMP         


(BLACK)
@SCREEN
D=A
@ADDR
M=D            
@8192
D=A
@COUNT
M=D            

(BLACK_LOOP)
@COUNT
D=M
@START
D;JEQ         
@ADDR
A=M
M=-1           

@ADDR
M=M+1          
@COUNT
M=M-1          
@BLACK_LOOP
0;JMP


(WHITE)
@SCREEN
D=A
@ADDR
M=D            

@8192
D=A
@COUNT
M=D            

(WHITE_LOOP)
@COUNT
D=M
@START
D;JEQ          

@ADDR
A=M
M=0            

@ADDR
M=M+1          
@COUNT
M=M-1          
@WHITE_LOOP
0;JMP
