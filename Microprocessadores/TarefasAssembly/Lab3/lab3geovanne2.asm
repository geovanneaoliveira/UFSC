.data 0xffff0010
	DR: .byte 0
	DL: .byte 256
	
.text 

	inicio: 
		li $t0, 1
		li $t1, 0
	repete: 
		sb $t0, DR
		mul $t0, $t0, 2
		bgt $t0 , 255 , inicio
		addiu $t1, $t1 , 1
		beq $t1, 1, soma
		j repete
	soma:
		li $t1 , 80
		j atraso
		
	atraso: 
		subiu $t1, $t1 , 1
		bnez $t1 , atraso
		j repete