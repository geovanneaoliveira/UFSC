.data
	sequencia: .byte 0x81,0x42,0x24,0x18,0x0,0xFF,0x0
.data 0xFFFF0010
	DR: .byte 0
	DL: .byte 0
.text
	li $t0, 0
	
	loop:
		lb $t1, sequencia($t0)
		sb $t1, DR
		addi $t0, $t0, 1
		bne $t0, 12, loop
		jal setar
		j loop

	setar:
		li $t0, 0
		jr $ra
