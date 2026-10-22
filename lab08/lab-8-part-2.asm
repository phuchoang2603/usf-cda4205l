# CDA 4205L - Lab 8, Part 2: Read and Display a BMP in RARS

.data
    # Reserve the 256 x 256 x 4-byte display area FIRST, so the
    # pathname/header/pixel-read buffer cannot overwrite visible pixels.
    framebuffer: .space 0x40000

    usfbmp: .string "/Users/felix/repos/school/usf-cda4205l/lab08/usflogo.bmp"
                 .align 2
    header:      .space 0x36
                 .align 2
    buffer:      .space 0x03

.text
.globl main
main:
    # 0 = uncorrected BMP order (T5); 1 = correct vertical orientation (T7).
    li s5, 1

    # Open BMP: a7=1024; a0=path; a1=0 (read-only).
    li a7, 1024
    la a0, usfbmp
    li a1, 0
    ecall

    blt a0, zero, exit_program  # file open error (-1)
    mv s1, a0                   # preserve file descriptor across ecalls

    # Read 54-byte (0x36) BMP header into the provided header buffer.
    # RARS automatically advances the file position after reading.
    mv a0, s1
    la a1, header
    li a2, 0x36
    li a7, 63
    ecall
    li t0, 0x36
    bne a0, t0, close_file     # incomplete/failed header read

    # The provided bitmap is 256 x 256, 24 bpp, uncompressed,
    # with a 54-byte header and no per-row padding.
    li s3, 256                 # rows remaining
    li s2, 0x10010000          # starting frame-buffer row for T5
    beqz s5, row_loop
    li s2, 0x1004FC00          # last screen row for T7

row_loop:
    mv s0, s2                  # current frame-buffer pixel address
    li s4, 256                 # columns remaining

pixel_loop:
    # Read one BMP pixel as B, G, R (3 bytes).
    mv a0, s1                  # descriptor (ALWAYS offset 0)
    la a1, buffer
    li a2, 0x03
    li a7, 63
    ecall
    li t0, 0x03
    bne a0, t0, close_file     # stop on short read or error

    # Convert BGR bytes to RARS display word: 0x00RRGGBB.
    la t0, buffer
    lbu t1, 0(t0)              # B, bits 7:0
    lbu t2, 1(t0)              # G, bits 15:8
    lbu t3, 2(t0)              # R, bits 23:16
    slli t2, t2, 8
    slli t3, t3, 16
    or t1, t1, t2
    or t1, t1, t3
    sw t1, 0(s0)               # write one RARS pixel (4 bytes)

    addi s0, s0, 4             # next column (one display word)
    addi s4, s4, -1
    bnez s4, pixel_loop

    # BMP stores rows from bottom to top, while the display is top to bottom.
    # Choose sequential screen rows (T5) or descending screen rows (T7).
    beqz s5, advance_down
    addi s2, s2, -1024         # correct: previous screen row (256 * 4)
    j next_row

advance_down:
    addi s2, s2, 1024          # uncorrected: next screen row

next_row:
    addi s3, s3, -1
    bnez s3, row_loop

close_file:
    mv a0, s1
    li a7, 57
    ecall

exit_program:
    li a7, 10
    ecall
