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
	move $t0, $v0
	
	# part 2
	
	# print: Enter the number
	li $v0, 4
	la $a0, promptNumber
	syscall
	
	# enter user input
	
	li $v0, 8
	la $a0, buffer
	li $a1, 1000
	syscall
	move $t1, $t0 # array base address
	move $s0, $a1
	
	
	# part 3
	
	# Enter the new system: message
	li $v0, 4
	la $a0, promptNewBase
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	
