# Implement a RISC-V program to multiply two numbers using loop adder
main:
    lw   t3, 0(s1)
    addi a0, zero, 550   # load first operand
    addi a1, zero, 20    # load second operand
    addi t0, zero, 0   
    beq  a0, zero, done  # if the first operand is equal to 0, then goto done
    beq  a1, zero, done  # if the second operand is equal to 0, then goto done
loop:
    add  t0, a0, t0      
    addi a1, a1, -1
    bne  a1, zero, loop
done:
    add  a0, t0, zero
    sw   a0, 0(s1)
