.data 0xffff0010
	DR: .byte 0
	DL: .byte 255
	
	#elevador: .byte 1 t0
	#andarinicial: .byte 1 #00000001 t1
	#andar1: .byte 16 #00010000
	#andarintermediario1: .byte 18 #00010010
	#andar2: .byte 2 #00000010
	#andarintermediario2: .byte 66 #01000010
	#andar3: .byte 64 #01000000
	#andar4: .byte 1 #00000001
	#andar terreo é o bit 1
.text
	li $t0, 1
	li $t1, 1
	li $t2, 16
	li $t3, 18
	li $t4, 2
	li $t5, 66
	li $t6, 64
	li $t7, 1	
	
	#verificar se esta no terreo
	and $t8, $t1, 255 #ira verificar quais chaver estao acesas
	beq $t8, 1, terreo #se nao for nenhuma o elevador vai ao terreo
	
	#leva p terreo
	sb $t0, DR
	beq $t6, $t0, final
	div $t0, $t0, 2
	
	terreo:
		sb $t1, DR
		
	pric:
		sb $t1, DR
		beq $t1, $t2, segc
		mul $t1, $t1, 2
		j pric
		
	segc:
		sb $t3, DR  #pedida de andar
		sgc:
			sb $t0, DR
			bgt $t0, $t4, spc
			beq $t4, $t0, terc
			mul $t0, $t0, 2
			j sgc
		
	spc:
		sb $t0, DR
		beq $t4, $t0, terc
		div $t0, $t0, 2
		j spc
		
	terc:
		sb $t5, DR  #pedida de andar
		tgc:
			sb $t0, DR
			bgt $t0, $t6, tpc
			beq $t6, $t0, final
			mul $t0, $t0, 2
			j tgc
		
	tpc:
		sb $t0, DR
		beq $t6, $t0, final
		div $t0, $t0, 2
		j tpc
		
	
	final:
		j final
