.data
	chooseprompt: .asciiz "Press 1 to convert decimal to other, 2 to convert other to decimal:\n"
	promptBase: .asciiz "Enter the current system: "
	promptNumber: .asciiz "Enter the number: "
	promptNewBase: .asciiz "Enter the new system: "
	resultMessage: .asciiz "The result is:\n"
	errorMessage: .asciiz "Error: Invalid input for the specified base.\n"
	buffer: .space 1000 
	
.text

main:
	# part 1
	
	# print: Enter the current system 
	li $v0, 4
	la $a0, promptBase
	syscall
	# move $t0, $v0
	
	# enter input
	li $v0, 5
	syscall
	move $s0, $v0
	
	# part 2
	
	# print: Enter the number
	li $v0, 4
	la $a0, promptNumber
	syscall
	
	# enter user input
	
	li $v0, 8
	la $a0, buffer
	li $a1, 1000 # max length of the buffer
	syscall
	move $s1, $a0 # array base address
		      
	
	
	# part 3
	
	# Enter the new system: message
	li $v0, 4
	la $a0, promptNewBase
	syscall
	
	li $v0, 5
	syscall
	move $s2, $v0
	
countSize:
	li $s3, 0 # count for the size of the array
	lb $t4, 0($s1)  # first element in the array
loopStart:
	beq $t4, $zero, loopEnd
	addi $s3, $s3, 1
	addi $s1, $s1, 1
	lb $t4, 0($s1)
	j loopStart
loopEnd:
	
	li $v0, 1
	addi $s3, $s3, -1
	move $a0, $s3
	# syscall
	
	move $s3, $a0
	
	# array base address
	la $a0, buffer
	# current system
	add $a2, $s0, $zero
	jal validate_number
	
	move $s4, $v0
	li $v0, 1
	move $a0, $s4
	syscall
	
	j exist

# validate number function
validate_number:
	
	
	
	# for validation 
	# zero : not validate number
	# one: valide number
	lb $t0, 0($a0) # first element
	li $t7, 1
	VLoopStart:
		beq $t0, $zero, VLoopEnd
		li $t2, 0     # digitt value as integer
		sge $t3, $t0, '0'  # num[i] >= '0'
		sle $t4, $t0, '9'  # num[i] <= '9'
		beq $t3, $zero, VElse # else condition
		beq $t4, $zero,VElse 
		sub $t2, $t0, '0'   # if condition case: char - '0'
	
		j Vcheckdigit
		VElse:  # else condition case: (char - 'A') + 10
			sub $t2, $t0, 'A'   # if condition case
			addi $t2, $t2, 10
		Vcheckdigit: # if digit >= current system
			sge $t3, $t2,$a2
			beq $t3, $t7, notValidate
			# increase count and get next element
			addi $a0, $a0, 1
			lb $t0, 0($a0) # first element
			j VLoopStart
			notValidate:
				li $v0, 0
				jr $ra
	VLoopEnd:
		li $v0, 1
		jr $ra

exist:
