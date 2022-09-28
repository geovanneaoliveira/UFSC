.data
	texto1: .asciiz "Digite o primeiro numero:"
	texto2: .asciiz "Digite o segundo numero:"
	N1: .word 0
	N2: .word 0
	RESULT: .word 0

.text
	li $v0, 4 			
	la $a0, texto1			
	syscall
	li $v0, 5			
	syscall	
	sw $v0, N1
	li $v0, 4 			
	la $a0, texto2			
	syscall
	li $v0, 5			
	syscall	
	sw $v0, N2
	lw $t0, N1
	lw $t1, N2
	add $t2, $t0, $t1
	sw $t2, RESULT
	li $v0, 1 			
	lw  $a0, RESULT			
	syscall
fim:
	li $v0, 10
	syscall
	
	