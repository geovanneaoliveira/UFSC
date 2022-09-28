.data
	init: 		.asciiz		"\n------------TERMOSTATO DINAMICO------------\nTEMPERATURA ATUAL DETECTADA (Â°C): "
	run: 		.asciiz		"\nTEMPERATURA ATUAL (°C): "
	comandos:	.asciiz		"\nCOMANDOS:\n(0) PARAR EXECUCAO\n(1) FORNECER NOVO VALOR\n(2) TEMPORIZADOR"
	init2: 		.asciiz		"\nINFORME A TEMPERATURA QUE DESEJA ALCANCAR (°C): "
	resfrinit: 	.asciiz		"\n-----------RESFRIAMENTO INICIADO-----------"
	aquecinit: 	.asciiz		"\n-----------AQUECIMENTO  INICIADO-----------"
	temporizador: 	.asciiz		" - TEMPORIZADOR: "
	tempoFinal:	.asciiz		"\n-------------FIM DO TEMPORIZADOR-----------"
	tempAlcancada:  .asciiz		"\nTEMPERATURA ALCANCADA - ECONOMIA DE ENERGIA"
	tempMsg:	.asciiz		"\nINFORME A DURACAO DO TEMPORIZADOR (MINUTOS): "
	interrupcao: 	.asciiz 	"\n----------------DESLIGAMENTO---------------"
	sensorSimul: 	.float 		10.0
	multSimul: 	.float 		50.0
	termOps: 	.float 		0.323573
	ambOps: 	.float 		0.332674
	# f2 - TEMPERATURA INFORMADA
	# f4 - TEMPERATURA AMBIENTE SIMULADA A SER MANIPULADA
.data 0xffff0004
	#VARIAVEL DE 32 BITS NO ENDEREÇO DO TECLADO MMIO
		asc: .word
.text
	#CARREGAR DADOS NO COPROCESSADOR 1
		lwc1 $f6, sensorSimul
		lwc1 $f8, multSimul
		lwc1 $f16, termOps
		lwc1 $f18, ambOps
main:
	#MENSAGEM DISPLAY INICIO
		la $a0, init
		li $v0, 4
		syscall
	#SIMULACAO DE TERMOMETRO
		li $v0, 43
		syscall
		mul.s $f4, $f0, $f8
		sub.s $f4, $f4, $f6
	#MOSTRAR TEMPERATURA DETECTADA
		li $v0, 2
		mov.s $f12, $f4
		syscall
	#MENSAGEM COMANDOS
		la $a0, comandos
		li $v0, 4
		syscall
newTemp:
	#RESETA INPUT KEYBOARD
		li $t1, 0
		sw $t1, asc
	#INPUT USUARIO
		la $a0, init2
		li $v0, 4
		syscall
	#SCAN FLOAT DISPLAY
		li $v0, 6
		syscall
		mov.s $f2, $f0
comparacoes:
	#COMPARACOES
		c.lt.s $f2, $f4
		c.lt.s 1,$f4, $f2
		c.eq.s 2, $f2,$f4
	#FUNCIONAMENTO
		bc1t 0, resfriamento
		bc1t 1, aquecimento
		bc1t 2, iguaisResfT
			
resfriamento:
	#SLEEP
		addi	$v0, $zero, 32	
		addi	$a0, $zero, 3000	
		syscall
	#INICIO DE RESFRIAMENTO
		la $a0, resfrinit
		li $v0, 4
		syscall
resfriamentoGo:
	#INFORMAR ESTAGIO DO CODIGO
		li $s0, 1
		li $s1, 0
		li $s2, 0
		li $s3, 0
	#TESTE INPUT TECLADO MMIO
		lw $t1, asc 
		beq $t1, 48, stop
		beq $t1, 49, newTemp
		beq $t1, 50, temporizadorSet
	#SLEEP
		addi	$v0, $zero, 32
		addi	$a0, $zero, 800
		syscall
	#RESFRIAR
		li $t8, 0
		sub.s $f4, $f4, $f16
	#MOSTRAR TEMPERATURA DETECTADA
		la $a0, run
		li $v0, 4
		syscall
		li $v0, 2
		mov.s $f12, $f4
		syscall
	#SE HOUVER, PRINTAR TEMPORIZADOR
		bgt $t5, 0, printTemporizador
compResfriamentoGo:
	#CONTINUAR A RESFRIAR?
		c.lt.s 4, $f2, $f4
		bc1t 4, resfriamentoGo
	#ENTRAR EM ECONOMIA
		j iguaisResfT
aquecimento:
	#SLEEP
		addi	$v0, $zero, 32	
		addi	$a0, $zero, 3000	
		syscall
	#INICIO DE AQUECIMENTO
		la $a0, aquecinit
		li $v0, 4
		syscall
aquecimentoGo:
	#INFORMAR ESTAGIO DO CODIGO
		li $s0, 0
		li $s1, 1
		li $s2, 0
		li $s3, 0
	#TESTE INPUT TECLADO MMIO
		lw $t1, asc 
		beq $t1, 48, stop
		beq $t1, 49, newTemp
		beq $t1, 50, temporizadorSet
	#SLEEP
		addi	$v0, $zero, 32
		addi	$a0, $zero, 800
		syscall
	#AQUECER
		li $t8, 0
		add.s $f4, $f4, $f16
	#MOSTRAR TEMPERATURA DETECTADA
		la $a0, run
		li $v0, 4
		syscall
		li $v0, 2
		mov.s $f12, $f4
		syscall
	#SE HOUVER, PRINTAR TEMPORIZADOR
		bgt $t5, 0, printTemporizador
compAquecimentoGo:
	#CONTINUAR A AQUECER?
		c.lt.s 5,$f4, $f2
		bc1t 5, aquecimentoGo
	#ENTRAR EM ECONOMIA
		j iguaisAquet
iguaisResfT:
	#ECONOMIA DO RESFRIADOR
		la $a0, tempAlcancada
		li $v0, 4
		syscall
iguaisResfTGo:
	#INFORMAR ESTAGIO DO CODIGO
		li $s0, 0
		li $s1, 0
		li $s2, 1
		li $s3, 0
	#SLEEP
		addi	$v0, $zero, 32
		addi	$a0, $zero, 2000
		syscall
	#AQUECIMENTO AMBIENTE
		add.s $f4, $f4, $f18
	#MOSTRAR TEMPERATURA DETECTADA
		la $a0, run
		li $v0, 4
		syscall
		li $v0, 2
		mov.s $f12, $f4
		syscall
		addu $t8, $t8, 1
	#SE HOUVER, PRINTAR TEMPORIZADOR
		bgt $t5, 0, printTemporizador
iguaisResfTGocomp:
	#CONTINUAR EM ECONOMIA?
		blt $t8, 3, iguaisResfTGo
	#VOLTAR A RESFRIAR
		beq $t8, 3, resfriamento 
iguaisAquet:
	#ECONOMIA DO AQUECEDOR
		la $a0, tempAlcancada
		li $v0, 4
		syscall
iguaisAquetGo:
	#ESTAGIO DO CODIGO
		li $s0, 0
		li $s1, 0
		li $s2, 0
		li $s3, 1
	#SLEEP
		addi	$v0, $zero, 32	
		addi	$a0, $zero, 2000	
		syscall
	#RESFRIAMENTO AMBIENTE
		sub.s $f4, $f4, $f18
	#MOSTRAR TEMPERATURA DETECTADA
		la $a0, run
		li $v0, 4
		syscall
		li $v0, 2
		mov.s $f12, $f4
		syscall
		addu $t8, $t8, 1
	#SE HOUVER, PRINTAR TEMPORIZADOR
		bgt $t5, 0, printTemporizador
iguaisAquetGocomp:
	#CONTINUAR EM ECONOMIA?
		blt $t8, 3, iguaisAquetGo
	#VOLTAR A AQUECER
		beq $t8, 3, aquecimento
temporizadorSet:
	#RESETA INPUT KEYBOARD
		li $t1, 0
		sw $t1, asc
	#MENSAGEM DISPLAY TEMPMSG
		la $a0, tempMsg
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		move $t5, $v0
		j comparacoes
printTemporizador:
	#MOSTRAR TEMPORIZADOR
		addi $t5, $t5, -1
		la $a0, temporizador
		li $v0, 4
		syscall
		move $a0, $t5  
		li $v0, 1
		syscall
	#TESTAR ESTAGIO DO CODIGO E VOLTAR AO FUNCIONAMENTO NORMAL
		beq $t5, 0, fimTemporizador
		beq $s0, 1, compResfriamentoGo
		beq $s1, 1, compAquecimentoGo
		beq $s2, 1, iguaisResfTGocomp
		beq $s3, 1, iguaisAquetGocomp
fimTemporizador:
	#PRINTAR FIM DO TEMPORIZADOR
		la $a0, tempoFinal
		li $v0, 4
		syscall
	#BUZZER
		li $a0, 100
		li $a1, 1000
		li $a2, 96
		li $a3, 100
		li $v0, 31
		syscall
	#TESTAR ESTAGIO DO CODIGO E VOLTAR AO FUNCIONAMENTO NORMAL
		beq $s0, 1, compResfriamentoGo
		beq $s1, 1, compAquecimentoGo
		beq $s2, 1, iguaisResfTGocomp
		beq $s3, 1, iguaisAquetGocomp
stop:
	#FIM DE EXECUCAO
		la $a0, interrupcao
		li $v0, 4
		syscall
		li $v0, 10
		syscall
