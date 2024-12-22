debugPrintBuffer:
    li $t6, 0       # Index counter
debugLoop:
    lb $t7, 0($t1)  # Load the current byte
    beq $t7, $zero, debugEnd # Exit if null terminator
    li $v0, 11      # Print character syscall
    move $a0, $t7   # Load character to print
    syscall
    addi $t1, $t1, 1 # Move to the next byte
    j debugLoop
debugEnd:
    li $v0, 11      # Print newline
    li $a0, 10
    syscall

<!--  -->


countSize:
	li $t4, 0 # count for the size of the array
	lb $t5, 0($t1)  # first element in the array
loopStart:
	beq $t5, $zero, loopEnd
	addi $t4, $t4, 1
	addi $t5, $t5, 1
	lb $t5, 0($t1)
	j loopStart
loopEnd:
	
	li $v0, 1
	li $a0, 12
	syscall
	
--------------------------------------
    #print string 
    li $v0, 4
	la $a0, buffer
	syscall
-------------------------------
print int


--------------

DecimalToOther: # a0; integer number, a2: new system, s6: number of reminders

	sub $sp, $sp, $s6
	add $t0, $s6, $zero
	li $t1, 0 # index in stack 
	DLoopStart:
		beq $t0, $zero, DLoopEnd
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
		add $t4, $sp, $t1 		# current index in stack
		sb $t3, 0($t4)
		addi $t1, $t1, 1
		addi $t0, $t0, -1
		j DLoopStart
	DLoopEnd:
	li $v0, 0
	jr $ra
	
	
printResult: #sp: act as array, s6: number of reminders as array size

	add $t0, $s6, $zero # size
	li $t1, 0 # index in stack 
	printLoopStart:
	beq $t0, $zero, printLoopEnd
	add $t3, $sp, $t1
	lb $t4, 0($t3)
	#addi $sp, $sp, -1
	
	# print the character or the digit of the number
	li $v0, 11
	move $a0, $t4
	syscall
	
	addi $t1, $t1, 1 
	addi $t0, $t0,-1 
	j printLoopStart
	printLoopEnd:
	j exist
	
	
	
	
exist:
