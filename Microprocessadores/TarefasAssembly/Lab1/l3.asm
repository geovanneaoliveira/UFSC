.data	
.text
	repete:
	  lb $t0, 0x10010000
	  beq $t0, 9, parada
	  addi $t0, $t0, 1
	  sb $t0, 0x10010000
	  j repete	
parada:
	li $v0, 10 			
	syscall