.data
	chooseprompt: .asciiz "Press 1 to convert decimal to other, 2 to convert other to decimal:\n"
	promptBase: .asciiz "Enter the current system: "
	promptNumber: .asciiz "Enter the number: "
	promptNewBase: .asciiz "Enter the new system: "
	errorMessage: .asciiz "does not belong to the "
	resultMessage : .asciiz "The number in the new system: "
	conErrorMessage: .ascii " System"
	newLine: .asciiz "\n"
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
	
	# array base address
	la $a0, buffer
	# current system
	add $a2, $s0, $zero
	jal validate_number
	
	
	# print validation result: zero: not validate & 1: validate number
	move $s4, $v0

	
	li $s5, 0
	la $a0, buffer      # base address
	add $a2, $s0, $zero # current system
	beq $s4, $zero, notValideMessage
	jal OtherToDecimal
	
	
	# ------------> number after converted to integer <---------------------
	move $s5, $v1
	
	
	# count Reminders
	add $a0, $s5,$zero
	add $a2, $s2, $zero
	jal countReminders
	
	# number of reminders
	move $s6, $v0 # countreminders(num, new_sys)
	
	
	# Decimal To other systems function
	
	add $a0, $s5, $zero
	add $a2, $s2, $zero
	jal DecimalToOther
	
	# print new Line
	li $v0, 4
	la $a0, newLine
	syscall
	
	la $v0, 4
	la $a0, resultMessage
	syscall
	
	jal printResult
	
	
	j exist
	
	notValideMessage:
	
	
	li $v0, 4
	la $a0, buffer
	syscall
	
	
	li $v0, 4
	la $a0, errorMessage
	syscall 
	
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	la $v0, 4
	la $a0, conErrorMessage
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
			subi $t2, $t0, 'A'   # if condition case
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
		

OtherToDecimal:
	
	# a0, a2, s3
	add $a0, $a0, $s3
	addi $a0, $a0, -1
	lb $t0, 0($a0)
	li $v1, 0 # result
	
	li $t6, 0
	OLoopStart:
	bge $t6, $s3, OLoopEnd
	# beq $t0, $zero, OLoopEnd
	li $t1, 0     # digitt value as integer
	sge $t2, $t0, '0'  # num[i] >= '0'
	sle $t3, $t0, '9'  # num[i] <= '9'
	beq $t2, $zero, OElse # else condition
	beq $t3, $zero,OElse 
	subi $t1, $t0, '0'   # if condition case: char - '0'
	j ToDecimal
	OElse:  # else condition case: (char - 'A') + 10
		subi $t1, $t0, 'A'   # if condition case
		addi $t1, $t1, 10
	ToDecimal: # convert number to decimal
		add $a3, $t6, $zero # b: current index
		
		# save return addreess
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $t0, 4($sp)
		sw $t1, 8($sp)
		
		jal pow             # pow(a, b)
		lw $ra, 0($sp) 
		lw $t0, 4($sp)
		lw $t1, 8($sp)
		add $sp, $sp, 8
		addi $sp, $sp, 12
		
		move $t4, $v0       # result
		mul  $t4, $t4, $t1  #  a * a
		add $v1, $v1, $t4   # a += a * a
		
		addi $t6, $t6, 1   

		addi $a0, $a0, -1
		# add $t5, $s3, -1
		lb $t0, 0($a0)
		j OLoopStart
	OLoopEnd:
		jr $ra
		
	
	
# s3: a, a3: b
pow:
	li $t0, 0
	li $t1, 1 
	pwLoopStart: 
		beq $t0, $a3, pwoopEnd
		mul $t1, $t1, $s0
		addi $t0, $t0, 1
		j pwLoopStart
pwoopEnd:

	move $v0, $t1
	jr $ra


countReminders: # a0: number, $a2: new system
	
	li $t0, 0  			   # counter count number of reminders
	CLoopStart:
		beq $a0,$zero, CLoopEnd    
		div $a0, $a2              # num/new_sys
		mflo $a0                  # quotient
		addi $t0, $t0, 1          # reminder
		j CLoopStart             
	CLoopEnd:
	move $v0, $t0                     # result number of reminder
	jr $ra                            # return result
	
	
	
DecimalToOther: # a0; integer number, a2: new system, s6: number of reminders

	sub $sp, $sp, $s6
	add $t0, $s6, $zero                    # the size of the number as string
	li $t1, 0 # index in stack 
	DLoopStart:
		beq $t0, $zero, DLoopEnd        # we finished converting number to string
		div $a0, $a2 
		mflo $a0 			# num = num / new_sys
		mfhi $t3 			# reminder = num % new_sys
		
		bgt $t3, 9, DGreaterthan9
		addi $t3, $t3, '0'   		# reminder + 'A'
		j addElement
		
		DGreaterthan9: 			# reminder - 10 + 'A'
		addi $t3, $t3, -10
		addi $t3, $t3, 'A'
		
		addElement: 
		add $t4, $sp, $t1 		# base address + i
		sb $t3, 0($t4)                  # gets the value inside that address
		addi $t1, $t1, 1                # i++
		addi $t0, $t0, -1               # j-- : it's the size of the number as string
		j DLoopStart
	DLoopEnd:
	li $v0, 0
	jr $ra
	
	
printResult: #sp: act as array, s6: number of reminders as array size

	add $t0, $s6, $zero 	    # use it as index => i
	li $t1, -1        	    # use it as end point
	printLoopStart:
	beq $t0, $t1, printLoopEnd  # i == -1 => end for loop
	add $t2, $sp, $t0           # add current index to base address => base address + i
	lb $t3, 0($t2)		    # gets the value	
	
	# print the character or the digit of the number
	li $v0, 11
	move $a0, $t3
	syscall
	
	addi $t0, $t0,-1 	  # i--
	j printLoopStart
	printLoopEnd:
	j exist
	
exist:
