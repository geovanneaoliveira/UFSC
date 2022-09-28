.data
	c: .byte  0
.text
	inicio:
	beq $t0, 99, fim
	lb $t0, c
	addi $t1, $t1, 1
	beq $t1, 0x0000000A, soma
	addi $t0, $t0, 1
	sb $t0, c
	j inicio
soma: 
	addi $t0, $t0, 0x00000007
	sb $t0, c
	li $t1, 0	
	j inicio
fim:
	li $v0, 10
	syscall