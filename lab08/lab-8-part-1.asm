# CDA 4205L - Lab 8, Part 1: Bitmap Display

.data

.text
.globl main
main:
    li s0, 0x10010000      # base address of bitmap display

    li t0, 0x00FFFFFF      # white, top-left
    sw t0, 0(s0)

    li t0, 0x00FF0000      # red, top-right
    sw t0, 4(s0)

    li t0, 0x0000FF00      # green, bottom-left
    sw t0, 8(s0)

    li t0, 0x000000FF      # blue, bottom-right
    sw t0, 12(s0)

    li a7, 10              # exit
    ecall
