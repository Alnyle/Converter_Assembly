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