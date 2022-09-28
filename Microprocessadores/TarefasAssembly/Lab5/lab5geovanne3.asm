.data
	lista1: .space 12
	lista2: .space 12
.text
	li $t0, 0
	la $t1, 0x1
	la $t2, 0x2
	la $t3, 0x3
	la $t4, 0x4
	la $t5, 0x5
	la $t6, 0x6
preencher1:
	sw $t1, lista1($t0)
 	addi $t0, $t0, 4
 	sw $t2, lista1($t0)
 	addi $t0, $t0, 4
 	sw $t3, lista1($t0)
	li $t0, 0
push:	
	sw $t1, 0($sp)
	sw $t2, 4($sp)
	sw $t3, 8($sp)
	sw $t4, 12($sp)
	sw $t5, 16($sp)
	sw $t6, 20($sp)
inverter:
	sw $t4, lista2($t0)
 	addi $t0, $t0, 4
 	sw $t5, lista2($t0)
 	addi $t0, $t0, 4
 	sw $t6, lista2($t0)
	li $t0, 0
	