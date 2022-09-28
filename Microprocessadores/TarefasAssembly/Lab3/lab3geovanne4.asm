.data 0xffff0010
	DR: .byte 255
	DL: .byte 255
.data 
	mensagem: .asciiz "Coloque o valor de rotação\n" 
	
.text 
	#recebe o valor a ser rotacionado 
	recebe:
 		li $v0 , 4
 		la $a0 , mensagem
 		syscall
 		
		li $v0,5
		syscall
		move $t5 , $v0
		
 		bge $t5, 128 , rotação
 		j recebe
 	#se for maior ou igual a 128 rotaciona a diferenca com 128
 	#zera a chave 8 para comecar a rotacionar
 	#se entrar um numero menor que 128 (nao contendo a chave 8 ligada irá pedir novamente
 	
	rotação: #0 para 1
		inicio: 
		li $t0, 1
		li $t1, 0
		andi $t5, $t5, 127
	repete: 
		sb $t0, DR
		sll $t0, $t0, 1
		addiu $t1, $t1 , 1
		subiu $t5, $t5, 1
		beq $t1, 8, inicio
		j repete

