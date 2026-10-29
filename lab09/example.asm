load_use1:
lw t1, 12(t1)
add t5, t1, t7
sub t8, t6, t7
or t9, t6, t7

load_use2:
lw t1, 12(t1)
add t5, t1, t7
sub t1, t6, t7
or t9, t6, t7

no_dep:
lw  t0, 12(t1)
add t5, t6, t7
sub t2, t0, s1
or s5, s6, t6

alu_then_branch:
sub t3, t4, t5
sub s3, s3, t0
add t0, t1, t2
beq t0, t5, loop

load_then_branch:
add t4, t6, t7
sub t2, t3, s1
lw t0, 0(t1)
beq t0, t5, loop

fix_no_steal:
lw  t0, 12(t1)
add t5, t0, t7
sub t2, t4, t6
or s5, t0, t6
add s3, s5, s6

handshake:
lw  t0, 12(t1)
add t5, t0, t7
sub s5, t4, t6
or s5, t7, t6
add s3, s5, s6
