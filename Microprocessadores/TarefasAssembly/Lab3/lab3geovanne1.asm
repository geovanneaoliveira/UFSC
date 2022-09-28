.data 0xffff0010
	DR: .byte 0
	DL: .byte 256
	
.text 
	inicio: 
		li $t0, 1
	repete: 
		sb $t0, DR
		mul $t0, $t0, 2
		bgt $t0 , 255 , inicio
		j repete 
	