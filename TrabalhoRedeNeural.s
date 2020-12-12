.data		#Cabeçalho do Programa
	msg0: .asciiz "\n\t           Trabalho de Redes Neurais em Assembly       \n"
	msg4: .asciiz "\t        O programa fará a leitura somente de um número       \n"
	msg5: .asciiz "        já que para somar 2 numeros iguais basta somar um nº com ele mesmo.       \n"
	msg1:	.asciiz "\n\tDigite um número: "
	msg2:	.asciiz "º linha - Peso 1 e Peso 2: "	
	msg3:	.asciiz " e "
	msg7:	.asciiz "\n"
	msg10:	.asciiz "\n\tDigite outro número: "
	
.text
main:
	#Inicia variáveis
	li $t0, 1					#inicia o contador	
	li.s $f7, 0.05				#inicia a taxa de aprendizado 
	li.s $f8, 0.0				#inicia o peso 1
	li.s $f9, 0.8				#inicia o peso 2
	
	li.s $f18, 0.0				#variável auxiliar para ajudar na soma	
	
	li.s $f23, 1.0				#inicia elemento 1	para ajudar nas operações
	li.s $f24, 2.0				#inicia elemento 2	para ajudar nas operações
	li.s $f11, 2.0				#inicia elemento 3	para ajudar nas operações
		
	#Mostrar msg0				#exibe o cabeçalho
	li $v0, 4
	la $a0, msg0
	syscall
	
	#Mostrar msg4				#exibe o cabeçalho
	li $v0, 4
	la $a0, msg4
	syscall
	
	#Mostrar msg5				#exibe o cabeçalho
	li $v0, 4
	la $a0, msg5
	syscall
	
	#Mostrar msg1				#exibe mensagem para digitar um valor qualquer
	li $v0, 4
	la $a0, msg1
	syscall
	
	#Leitura de um real do console para f2
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	repete:
		#calculo do erro
		mul.s $f15, $f2, $f8	#peso 1
		mul.s $f16, $f2, $f9	#peso 2
		add.s $f20, $f15, $f16	#soma dos pesos		
		sub.s $f3, $f11, $f20	#acha o valor do erro
		
		#atualiza pesos
		mul.s $f21, $f7, $f2	#f21 recebe TaxaAp+Entrada
		mul.s $f22, $f3, $f21	#f22 recebe f21+erro
		add.s $f8, $f8, $f22	#atualiza peso 1
		add.s $f9, $f9, $f22	#atualiza peso 2					
	
		li $v0, 1				#exibe o contador para identificar a linha
		add $a0, $t0, $zero		
		syscall
	
		li $v0, 4				#exibe os valores dos pesos para a linha atual
		la $a0, msg2
		syscall
	
		li $v0, 2		
		mov.s $f12, $f8			#exibe o valor do peso 1 para a linha atual
		syscall
		
		li $v0, 4
		la $a0, msg3
		syscall	
		
		li $v0, 2		
		mov.s $f12, $f9			#exibe o valor do peso 2 para a linha atual
		syscall
		
		li $v0, 4
		la $a0, msg7
		syscall	
	
		add.s $f2, $f2, $f23	#incrementa o valor digitado em 1 unidade
		add.s $f11, $f11, $f24	#incrementa o valor auxiliar "f11" em 2 unidades

		
		add $t0, $t0, 1			#incrementa o contador
		
	
	ble $t0, 5, repete			#repete o loop 5 vezes
	
	#Testar pra ver se o programa aprendeu a somar
	li $v0, 4			#Pede pra digitar outro nº
	la $a0, msg10
	syscall
	
	li $v0, 6			#Carrega o valor digitado para $f2
	syscall
	mov.s $f2, $f0
	
	#gera a saida
	mul.s $f25, $f2, $f8
	mul.s $f26, $f2, $f9
	add.s $f27, $f25, $f26
		
	li $v0, 2
	mov.s $f12, $f27
	syscall
	
	jr $ra
	
	
	
	