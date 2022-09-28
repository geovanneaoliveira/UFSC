.data
.text
	la $t2, 0x0
	la $t0, 0x12
	la $t1, 0x5
soma:
	addu $t2, $t2, $t1
	bge $t2, 0xa, dezena
	subiu $t0, $t0, 1
	beqz $t0, fim
	j soma
dezena:
	add $t2, $t2, 0x6
	j soma
fim:
	li $v0,10
	syscall	
