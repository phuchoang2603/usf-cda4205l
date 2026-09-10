# Template for CDA4205L Lab #2
# This file should target the microarchitecture WITHOUT the dedicated multiplication circuit

.globl __main

.data


.text
	__main:
		li a7, 1		# pre-load the PrintInt ecall

		li a0, 550		# load the first operand
		li a1, 21		# load the second operand
		jal _multiply	# call the "_multiply" function
		
		ecall			# _multiply returns the result in a0, and we already loaded ecall 1 into a7,
					# so we can simply perform the ecall to print the result

		li 	a7, 10	# load the exit ecall
		ecall			# exit the program

	# multiply function
	# inputs: a0, a1
	# output: a0 = a0 * a1
	_multiply:
		#---- your code here
    mv   t0, a0               # Save original multiplicand (a0) into t0
    mv   t1, a1               # Copy multiplier (a1) into t1 to use as a counter
    li   a0, 0                # Clear a0 to use as the running total

    mul_loop:
    add  a0, a0, t0           # Add multiplicand to total
    addi t1, t1, -1           # Decrement loop counter
    bnez t1, mul_loop         # Repeat until counter hits 0
		
		
		#---- end of your code
		jr ra
