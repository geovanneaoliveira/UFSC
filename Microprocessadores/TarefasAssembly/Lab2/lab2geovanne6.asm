.data
 	inicio: .byte 0
 	cnttmp: .byte 48
 
.text
 	lbu $t1, inicio
 	lb $t3 , cnttmp
 	
 	condicional:
 		beq $t1, 48, condicional2
 		beq $t1, 65, condicional2
 		beq $t1, 97, condicional2
 		beq $t1, 255, fim
 	
 	cont:
 		li $v0 , 11
		move $a0 , $t1
		syscall
 		
		sb $t1, inicio
		addiu $t1, $t1, 1
		
		j condicional
		
	condicional2:
		li $v0 , 11
		move $a0 , $t1
		syscall
	
		addiu $t1, $t1, 1
		subiu $t3, $t3 , 10
		beq $t1, 57, condicional
		blt $t1, 57, tempo
 		beq $t1, 90, condicional
 		blt $t1, 90, tempo
  		beq $t1, 122, condicional
 		blt $t1, 122, tempo
 		
	tempo:
		addiu $t3, $t3, 1
		beq $t3, $t1 , condicional2
		j tempo


	fim:
		li $v0, 10
		syscall