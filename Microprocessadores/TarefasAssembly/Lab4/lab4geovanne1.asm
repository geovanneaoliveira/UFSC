.data
	t2: .half 0x0
	t0: .half 0x12
	t1: .half 0x5
.text
	lhu $t2, t2
	lhu $t0, t0
	lhu $t1, t1
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
