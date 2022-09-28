.data
	li $t0, 0
	li $t1, 0
	AH: .half 0
	AL: .half 0
.text
inicio: 
	sh $t1, AL
	sh $t0, AH 
	beq $t0, 9, decimal    
	addi $t0, $t0, 1
	j inicio
decimal:
	beq $t1, 9, exit
	addi $t1, $t1, 1
	li $t0, 0
	j inicio
parada:
	li $v0, 10
	syscall
