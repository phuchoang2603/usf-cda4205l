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
	li t0, 9		# number i iterations; change this in step 4.		
	
	li t1, 4205		# number n you want sqrt	
	li t2, 2		# load constant 2
	li t3, 10		# load constant 10
	
	# perform conversions for t1, t2, t3, and store results in ft0, ft2, and ft4 (doubles need two FP registers)
	# [your code here]
	
	jal NewtonRoots		# get sqrt(n) in i iterations
	fmv.d fa0, ft10		# move the function result to fa0. make sure "NewtonRootsLoop" stores the result in ft10.
	
	jal prntNewLine
	jal prntDouble		# Print the result.
	
	jal exit
		
		
NewtonRoots:
	# set up the initial conditions by checking if the input (n) is > 10 (using a FP comparison)
	# [your code here]
	
	# follow the instructions for the initial guess in step 3. (condsider using a branch and adding a label for the else condition)
	# [your code here]


NewtonRootsLoop:
	# perform the actual N-R method computation equation. Store the result in ft10.
	# [your code here]

	# don't forget to adjust your iterator and break out of the loop once i <= 0 (or when result difference < threshold for step 5)
	# [your code here]
	
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
