.data

.text
	li $t0, 1062
	sh $t0, 0x10010000
	repete:
	  lhu $t0, 0x10010000
	  addi $t0, $t0, 1
	  sh $t0, 0x10010000
	  j repete
