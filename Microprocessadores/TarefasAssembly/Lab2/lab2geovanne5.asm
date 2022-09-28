.data
 	inicio: .byte 48 
 
.text
 	lbu $t1, inicio
 	
 	condicional:
 		beq $t1, 58, maiusculas
 		beq $t1, 91, minuscula
 		beq $t1, 123, fim
 	
 	cont:
 		li $v0 , 11
		move $a0 , $t1
		syscall
 		
		sb $t1, inicio
		addiu $t1, $t1, 1
		
		j condicional
		

	maiusculas:
		li $t1, 65
		j cont
 
	minuscula:
		li $t1, 97
		j cont

	fim:
		li $v0, 10
		syscall