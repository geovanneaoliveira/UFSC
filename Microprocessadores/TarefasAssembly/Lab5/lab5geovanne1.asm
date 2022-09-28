.data
	v1: .word 0xB1B2
      	v2: .word 0xD1D2
.text
	lw $t1, v1
	lw $t2, v2
	li $t0, 0
push:	
	sub $sp, $sp, $t0
	sw $t1, 0($sp)
	sw $t2, 4($sp)
pop:
	addi $sp, $sp, 4
	addi $sp, $sp, 4
fim:
	li $v0, 10
	syscall