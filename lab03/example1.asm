# Implement a RISC-V program 
start:
    lw   t2, 0(s1) 
    addi a0, zero, 10 # store 10 in a0 
    addi a1, zero, 20 # store 20 in a1 
    bge  a0, a1, done   
    add  a2, a1, zero  
    jal  ra, exit 
done: 
    add a2, a0, zero  
    jal ra, exit 
exit: 
    sw  a0, 0(s1) 