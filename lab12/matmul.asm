.data
A:
        .word  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99
B:
        .word  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99
C:
        .zero   100

.text
main:
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        addi    s0,sp,32
        li      a5, 10		# = m = number of rows and columns (m x m matrices)
        sw      a5,-20(s0)
        lui     a5,%hi(C)
        addi    a3,a5,%lo(C)
        lui     a5,%hi(B)
        addi    a2,a5,%lo(B)
        lui     a5,%hi(A)
        addi    a1,a5,%lo(A)
        lw      a0,-20(s0)
        call    matmul
        li      a5,0
        mv      a0,a5
        lw      ra,28(sp)
        lw      s0,24(sp)
        addi    sp,sp,32
        li 	a7, 10
	   ecall 

matmul:
        addi    sp,sp,-48
        sw      s0,44(sp)
        addi    s0,sp,48
        sw      a0,-36(s0)
        sw      a1,-40(s0)
        sw      a2,-44(s0)
        sw      a3,-48(s0)
        sw      zero,-20(s0)
        j       .L2
.L7:
        sw      zero,-24(s0)
        j       .L3
.L6:
        lw      a4,-24(s0)
        lw      a5,-36(s0)
        mul     a4,a4,a5
        lw      a5,-20(s0)
        add     a5,a4,a5
        slli    a5,a5,2
        lw      a4,-48(s0)
        add     a5,a4,a5
        lw      a5,0(a5)
        sw      a5,-28(s0)
        sw      zero,-32(s0)
        j       .L4
.L5:
        lw      a4,-32(s0)
        lw      a5,-36(s0)
        mul     a4,a4,a5
        lw      a5,-20(s0)
        add     a5,a4,a5
        slli    a5,a5,2
        lw      a4,-40(s0)
        add     a5,a4,a5
        lw      a4,0(a5)
        lw      a3,-24(s0)
        lw      a5,-36(s0)
        mul     a3,a3,a5
        lw      a5,-32(s0)
        add     a5,a3,a5
        slli    a5,a5,2
        lw      a3,-44(s0)
        add     a5,a3,a5
        lw      a5,0(a5)
        mul     a5,a4,a5
        lw      a4,-28(s0)
        add     a5,a4,a5
        sw      a5,-28(s0)
        lw      a5,-32(s0)
        addi    a5,a5,1
        sw      a5,-32(s0)
.L4:
        lw      a4,-32(s0)
        lw      a5,-36(s0)
        blt     a4,a5,.L5
        lw      a4,-24(s0)
        lw      a5,-36(s0)
        mul     a4,a4,a5
        lw      a5,-20(s0)
        add     a5,a4,a5
        slli    a5,a5,2
        lw      a4,-48(s0)
        add     a5,a4,a5
        lw      a4,-28(s0)
        sw      a4,0(a5)
        lw      a5,-24(s0)
        addi    a5,a5,1
        sw      a5,-24(s0)
.L3:
        lw      a4,-24(s0)
        lw      a5,-36(s0)
        blt     a4,a5,.L6
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
.L2:
        lw      a4,-20(s0)
        lw      a5,-36(s0)
        blt     a4,a5,.L7

        lw      s0,44(sp)
        addi    sp,sp,48
        jr      ra
