#TODO: add switch statement for doing either decimal to other or other to decimal
.data
	chooseprompt: .asciiz "press 1 to convert decimal to other, 2 to convert other to decimal"
	prompt1: .asciiz "enter number to convert:"
	prompt2: .asciiz "to base:"
.text
	main:
	#menu for choosing which to activate
	
	#li $v0, 4
	#la $a0,prompt1
	#syscall
	#li $v0,5
	#syscall
	#move $t0,$v0
	#beq $t0,1, ConvertFromDecimalMenu
	#beq $t0,2, ConvertToDecimalMenu
	
	
	#pint prompt1 asking user for number
	li $v0, 4
	la $a0,prompt1
	syscall
	#take user input number and store in $t0
	li $v0,5
	syscall
	move $t0,$v0
	#pint prompt2 asking user for base
	li $v0, 4
	la $a0,prompt2
	syscall
	#take user input base and store in $t1
	li $v0,5
	syscall
	move $t1,$v0
	move $a0,$t0
	move $a1,$t1
	jal ConvertDecimalToOther
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	


ConvertDecimalToOther:
	# parameters are passed in $a0 , $a1
	move $t0,$a0
	move $t1,$a1
	li $t4,0
	li $t5, 1
loopstart:
	beq $t0,0,endconvert
	li $t6,0
	#divide by base, update number to quotient and add remainder to result
	div $t0,$t1
	mflo $t0
	mfhi $t2
	mul $t2,$t2,$t5
	add $t4,$t4,$t2
	mul $t5,$t5,10
	j loopstart
endconvert:
move $v0,$t4
jr $ra
	
