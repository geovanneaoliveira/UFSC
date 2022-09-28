.data
	lista: .space 16 
.text
	la $t1, 0x1111
	la $t2, 0x2222
	la $t3, 0x3333
	la $t4, 0x4444
	la $t0, 0
preencher:
	sw $t1, lista($t0)
 	addi $t0, $t0, 4
 	sw $t2, lista($t0)
 	addi $t0, $t0, 4
 	sw $t3, lista($t0)
 	addi $t0, $t0, 4
	sw $t4, lista($t0)
	li $t0, 0
push:	
	sw $t1, 0($sp)
	sw $t2, 4($sp)
	sw $t3, 8($sp)
	sw $t4, 12($sp)
inverter:
	li $t0, 12
	sw $t1, lista($t0)
 	subi $t0, $t0, 4
 	sw $t2, lista($t0)
 	subi $t0, $t0, 4
 	sw $t3, lista($t0)
 	subi $t0, $t0, 4
	sw $t4, lista($t0)
	li $t0, 0
fim:
	li $v0, 10
	syscall
