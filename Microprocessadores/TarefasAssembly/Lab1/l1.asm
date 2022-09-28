.data

.text
	inicio:  
	  lb $t0, 0x10010000 
	  addi $t0, $t0, 1
	  sb $t0, 0x10010000
      	  j inicio
