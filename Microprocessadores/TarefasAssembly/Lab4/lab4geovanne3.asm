.data
	sequencia: .byte 0,2,4,6,8,64,12,14,16,18
	
.data 0xFFFF0010
	DR: .byte 0
	DL: .byte 0
.text
	li $t0, 0
	lb $t2, sequencia($t0)
	addi $t0, $t0, 1
	
	loop:
		bgt $t1, $t2, maior
		
		retorna:
			addi $t0, $t0, 1
			lb $t1, sequencia($t0)
			beq $t0, 10, acender
			j loop
	maior:
		move $t2, $t1
		j retorna
		
	acender:
		sb $t2, DR