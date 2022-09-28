.data
	sequencia: .byte 0,2,4,6,8,64,12,14,16,18
.text
	li $t0, 0 
	lb $t2, sequencia($t0) 
	
	loop:
		lb $t1, sequencia($t0)  
		bge $t1, $t2, maior  
	
		jal mover
	
		addi $t0, $t0, 1
		beq $t0, 10, mostra  
		j loop
		
	maior:
		move $t2, $t1 
		move $t3, $t0 
		addi $t0, $t0, 1
		j loop
		
	mover:
	
		lb $t5, sequencia($t3)
	
		sb $t1, sequencia($t3)
		sb $t5, sequencia($t0)
	
		move $t3, $t0 
	
		jr $ra

	mostra:
		li $t4, 0
	
	retorna:
		lb $a0, sequencia($t4)
		li $v0, 1
		syscall
	
		addi $t4, $t4, 1
		beq $t4, 10, fim
		j retorna

	fim:
		li $v0, 10
		syscall
	