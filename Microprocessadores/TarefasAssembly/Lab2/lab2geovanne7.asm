.data
 	inicio: .byte 47
 	cnttmp: .byte 48
 
.text
 	lbu $t1, inicio
 	lb $t3 , cnttmp	
	
	condicional:
		addiu $t1, $t1, 1
		subiu $t3, $t3 , 10
	
		li $v0 , 11
		move $a0 , $t1
		syscall
	
		beq $t1, 57, condicional2
		blt $t1, 57, tempo
 		beq $t1, 90, condicional3
 		blt $t1, 90, tempo
  		beq $t1, 122, fim
 		blt $t1, 122, tempo
 		
 	condicional2:
		addiu $t1, $t1 , 7
		addiu $t3, $t3 , 7
		j condicional
		
	condicional3:
		addiu $t1, $t1 , 6
		addiu $t3, $t3 , 6
		j condicional	
 		
	tempo:
		addiu $t3, $t3, 1
		beq $t3, $t1 , condicional
		j tempo

	fim:
		li $v0, 10
		syscall