.data
	chooseprompt: .asciiz "Press 1 to convert decimal to other, 2 to convert other to decimal:\n"
	promptNumber: .asciiz "Enter the number to convert:\n"
	promptBase: .asciiz "Enter the current base:\n"
	promptNewBase: .asciiz "Enter the new base:\n"
	resultMessage: .asciiz "The result is:\n"
	errorMessage: .asciiz "Error: Invalid input for the specified base.\n"

.text
        main:
        
	li $v0, 4
	la $a0, chooseprompt
	syscall

	# Read user choice
	li $v0, 5
	syscall
	move $t0, $v0


	beq $t0, 1, ConvertFromDecimalMenu
	beq $t0, 2, ConvertToDecimalMenu
	j invalidChoice

ConvertFromDecimalMenu:
	
	li $v0, 4
	la $a0, promptNumber
	syscall

	
	li $v0, 5
	syscall
	move $t0, $v0  

	
	li $v0, 4
	la $a0, promptNewBase
	syscall

	
	li $v0, 5
	syscall
	move $t1, $v0  

	# Call DecimalToOther function
	move $a0, $t0
	move $a1, $t1
	jal DecimalToOther
	move $t2,$v0
	
	li $v0, 4
	la $a0, resultMessage
	syscall

	move $a0, $t2
	li $v0, 1
	syscall
	j Exit

ConvertToDecimalMenu:
	
	li $v0, 4
	la $a0, promptNumber
	syscall

	# Read the number
	li $v0, 5
	syscall
	move $t0, $v0  

	# Prompt for the current base
	li $v0, 4
	la $a0, promptBase
	syscall

	# Read the current base
	li $v0, 5
	syscall
	move $t1, $v0  

	# Call OtherToDecimal function
	move $a0, $t0
	move $a1, $t1
	jal OtherToDecimal

	# Display the result
	li $v0, 4
	la $a0, resultMessage
	syscall

	move $a0, $v0
	li $v0, 1
	syscall
	j Exit

DecimalToOther:
	
	move $t0, $a0  # $t0 holds the number to convert
	move $t1, $a1  
	li $t4, 0      
	li $t5, 1      

loopDecimalToOther:
	beq $t0, 0, endDecimalToOther
	div $t0, $t1
	mflo $t0  # Update number with quotient
	mfhi $t2  # Get the remainder

	# Add remainder to result
	mul $t2, $t2, $t5
	add $t4, $t4, $t2
	mul $t5, $t5, 10
	j loopDecimalToOther

endDecimalToOther:
	move $v0, $t4
	jr $ra

OtherToDecimal:
	# Convert a number from another base to decimal
	move $t0, $a0  
	move $t1, $a1  
	li $t2, 0      
	li $t3, 1     

loopOtherToDecimal:
	beq $t0, 0, endOtherToDecimal
	li $t5, 10
	div $t0, $t5
	mflo $t0  
	mfhi $t4
	
	
	bge $t4, $t1, InvalidInput

	
	mul $t4, $t4, $t3
	add $t2, $t2, $t4
	mul $t3, $t3, $t1
	j loopOtherToDecimal

endOtherToDecimal:
	move $v0, $t2
	jr $ra

invalidChoice:
	li $v0, 4
	la $a0, errorMessage
	syscall
	j Exit

InvalidInput:
	li $v0, 4
	la $a0, errorMessage
	syscall
	j Exit

Exit:
	li $v0, 10
	syscall
