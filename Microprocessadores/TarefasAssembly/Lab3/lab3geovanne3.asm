.data 0xffff0010
	DR: .byte 255
	DL: .byte 255
	
.text 
	#recebe a direção
	li $t5, 0
 	
 	#mascara de bit
 	andi $t5, $t5, 1
 	beq $t5, 1 , baixopcima	
		
	cimapbaixo: #1 para 0
	
	inicio1: 
		li $t2, 256
		li $t3, 0
	repete1: 
		sb $t2, DL
		srl $t2, $t2, 1
		addiu $t3, $t3 , 1
		beq $t3, 9, inicio1
		j repete1
		
	baixopcima: #0 para 1
		inicio: 
		li $t0, 1
		li $t1, 0
	
	repete: 
		sb $t0, DR
		sll $t0, $t0, 1
		addiu $t1, $t1 , 1
		beq $t1, 8, inicio
		j repete