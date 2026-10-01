.data


.text
	li t0, 4205		# load a value
	
	# 2a. Convert the value to a single-precision floating point. Store the result in fa0 (floating point argument register). 
	fcvt.s.w fa0, t0
	
	jal prntFloat		# print it to be sure the conversion works
	
	# 2b. Perform the square root operation on the conversion result.
	fsqrt.s fa0, fa0
	
	jal prntFloat		# Print the result.

	# 2c. Square the result by multiplying it by itself.
	fmul.s fa0, fa0, fa0
	
	jal prntFloat		# Print the result again.
	jal prntNewLine


	# 2d. (repeating 2a, 2b, and 2c, except with double precision)
	# * Convert the value to a double-precision floating point. Store the result in fa0 (floating point argument register). 
	fcvt.d.w fa0, t0
	
	jal prntDouble		# Print the result.
	
	# * Perform the square root operation on the conversion result.
	fsqrt.d fa0, fa0
	
	jal prntDouble		# Print the result.

	# * Square the result by multiplying it by itself, and print the result again.
	fmul.d fa0, fa0, fa0
	
	jal prntDouble
	jal prntNewLine
	
	
	# now test Newton-Raphson method	
	
	#test with different i values in step 4.		
	li s0, 3		# number i iterations: 3, 5, 7, 9
	li s1, 9		# last i to test
	
	li t1, 4205		# number n you want sqrt	
	li t2, 2		# load constant 2
	li t3, 10		# load constant 10
	
	# perform conversions for t1, t2, t3, and store results in ft0, ft2, and ft4 (doubles need two FP registers)
	fcvt.d.w ft0, t1
	fcvt.d.w ft2, t2
	fcvt.d.w ft4, t3
	
testLoop:
	mv t0, s0		# t0 = i; NewtonRoots counts it down
	jal NewtonRoots		# get sqrt(n) in i iterations
	fmv.d fa0, ft10		# move the function result to fa0. make sure "NewtonRootsLoop" stores the result in ft10.
	
	jal prntNewLine
	mv a0, s0		# print i
	li a7, 1
	ecall
	jal prntNewLine
	jal prntDouble		# Print the result.
	
	addi s0, s0, 2
	ble s0, s1, testLoop
	
	jal exit
		
		
NewtonRoots:
	# set up the initial conditions by checking if the input (n) is > 10 (using a FP comparison)
	flt.d t4, ft0, ft4	# t4 = (n < 10)
	
	# follow the instructions for the initial guess in step 3. (condsider using a branch and adding a label for the else condition)
	beqz t4, guessDiv10
	fdiv.d ft10, ft0, ft2	# n < 10: x0 = n / 2
	j NewtonRootsLoop
guessDiv10:
	fdiv.d ft10, ft0, ft4	# else: x0 = n / 10


NewtonRootsLoop:
	# perform the actual N-R method computation equation. Store the result in ft10.
	# x = x - (x*x - n) / (2*x)
	fmul.d ft6, ft10, ft10	# x^2
	fsub.d ft6, ft6, ft0	# f(x)  = x^2 - n
	fmul.d ft8, ft2, ft10	# f'(x) = 2x
	fdiv.d ft6, ft6, ft8	# f(x) / f'(x)
	fsub.d ft10, ft10, ft6	# next guess

	# don't forget to adjust your iterator and break out of the loop once i <= 0 (or when result difference < threshold for step 5)
	addi t0, t0, -1
	bgtz t0, NewtonRootsLoop
	
	jr ra 


# helper functions

# prints a float and newline, assuming float already moved to fa0
prntFloat:
	li a7, 2
	ecall
	li a0, '\n'
	li a7, 11
	ecall
	jr ra

# prints a double and newline, assuming double already moved to fa0
prntDouble:
	li a7, 3
	ecall
	li a0, '\n'
	li a7, 11
	ecall
	jr ra
	
prntNewLine:
	li a0, '\n'
	li a7, 11
	ecall
	jr ra

exit:
	li a7, 10
	ecall
