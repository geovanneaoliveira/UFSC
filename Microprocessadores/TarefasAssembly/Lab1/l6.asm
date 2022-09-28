.data
.text
inicio:	
	beq $t3, 0x00009999, fim
	addi $t2,$t2,0x00000001
	beq $t2, 0x000003e8, centena
	addi $t1,$t1,0x00000001
	beq $t1, 0x00000064, dezena
	addi $t0,$t0,0x00000001
	beq $t0, 0x0000000A, unidade
	addi  $t3,$t3,1
	j inicio
	
unidade:
	addi $t3,$t3, 0x00000007
	li $t0, 0
	j inicio
		
dezena:
	addi $t3,$t3,0x00000067
	li $t0, 0
	li $t1, 0
	j inicio
	
centena:
	addi $t3,$t3,0x00000667
	li $t0, 0
	li $t1, 0
	li $t2, 0
	j inicio

fim:
	li $v0, 10
	syscall