.data
	primeiro: .byte 78
	segundo: .byte 30
	terceiro: .byte 6

.text
	lb $t0, primeiro 
	lb $t1, segundo
 	lb $t2, terceiro
	
	bge $t1,$t0,t1
	bge $t0,$t1,t0
	j t01
	 
	igual:
		li $v0,1
		move $a1 , $t0
		syscall
		j fim
	t01:
		beq $t0, $t2, igual
		bge $t2, $t0, p2
		j igual
		
	t1:
		bge $t2,$t1,p2
		j p1
	
	t0:
		bge $t2,$t0,p2
		j p0	
	
	p0:
		li $v0,1
		move $a0 , $t0
		syscall
		j fim

	p1:
		li $v0,1
		move $a0 , $t1
		syscall
		j fim
		
	p2:
		li $v0,1
		move $a0 , $t2
		syscall
		j fim
	
	fim:
	j fim