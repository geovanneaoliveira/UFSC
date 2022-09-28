.data
	primeiro: .byte 0
	segundo: .byte 5


.text
	lb $t0, primeiro 
	lb $t1, segundo
	
	beq $t1, $zero , saida0
	beq $t0, $zero , saida0
	
	loop:
		beq $t2 , $t0 , fim	
		add $t3 , $t3 , $t1
		addi $t2 , $t2 , 1
		j loop
	
	fim:
	j fim
	
	saida0:
		sb $t2 , 0
		j fim