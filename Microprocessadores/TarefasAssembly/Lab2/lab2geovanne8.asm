.data
	dividendo: .byte 78
	divisor: .byte 5
	resultado: .byte 0
	resto: .byte 0
	resu: .asciiz " O resultado da divisao foi: "
	res: .asciiz " O resto foi: "

.text
	lb $t0, dividendo
	lb $t1, divisor
 	lb $t2, resultado
 	lb $t3, resto
 	
 	div $t2, $t0 , $t1
 	mul $t4 , $t1 , $t2
 	sub $t3, $t0 , $t4
 	
 	li $v0 , 4
 	la $a0 , resu
 	syscall
 	
 	li $v0,1
	move $a0 , $t2
	syscall
 	
 	li $v0 , 4
 	la $a0 , res
 	syscall
 	
 	li $v0,1
	move $a0 , $t3
	syscall
	
	fim:
		j fim