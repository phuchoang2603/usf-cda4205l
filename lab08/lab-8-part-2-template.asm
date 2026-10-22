.data
 		usfbmp: 	.string 	"C:\\Path\\to\\the\\file.bmp"
				.align 	2
		header:	.space	0x36
				.align	2
		buffer:	.space	0x03
.text
		# your code here
		# load file
	li a7, 1024
	la a0, usfbmp 
	ecall	
	
	mv t5, a0 # store file descriptor
		
	# read header
	la a1, header # target buffer
	li a2, 0x36 # how many bytes to read
	li a7, 63
	ecall	
	
	# close file
	mv a0, t5 # load file descriptor
	li a7, 57
	ecall		
		
	# exit
	li a7, 10
	ecall
