.data
.text
	li $t0, 0x0
	li $t1, 0x0
unidade:
	add $t0, $t0, 0x1
	add $t1, $t1, 0x1
	beq $t0, 0xa, dezena
	beq $t1, 0x9999, fim
	j unidade
dezena:
	add $t1, $t1, 0x6
	li $t0, 0x0
	j unidade
fim:
	li $v0,10
	syscall	