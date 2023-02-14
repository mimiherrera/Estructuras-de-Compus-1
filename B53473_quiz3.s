#Quiz 3 Repo
#Amy Herrera Mora - B53473

.data

  array1: .asciiz "Ingenieria Electrica"

.text


main:

	addi $a0, $0, 0x2000
	addi $a1, $0, 'e' 					# Guarda e y la pasa como parametro a la funcion
  	
  	jal BUSCARCARACTER
	
	li $v0, 10 			# Se indica que termine
  	syscall
	    
 BUSCARCARACTER:
 
	add $t1, $0, $0  					# Inicializando el iterador 1
	add $t2, $0, $0 					# Contador de vocal e

  	while:


		addi $sp, $sp, -4 				# Guarda el espacio para stack pointer
 		sw $s0, 0($sp) 					# Se guarda en s0 para almacenar mascara
 		addi $s0, $0, 0x20  				# Mascara para convertir minusculas
		
  		add $t3, $t1, $a0		
  		lb $t4, 0($t3)		
  		beq $t4, $0, endWhile 	
  		
  		or $t5, $t4, $s0
  		sb $t5, 0($t3)
  		beq $t5, $a1, hayVocal
  	
  		addi $t1, $t1, 1
  		lw $s0, ($sp)
  		
  		addi $sp, $sp, 4
  		
  		j while
  
  	hayVocal:
  
  		addi $t1, $t1, 1
  		addi $t2, $t2, 1
  		add $v0, $t2, $0
  		
  		lw $s0, 0($sp) 					# Devuelve del stack pointer $s0
		addi $sp, $sp, 4
  	
  		j while
  	
  	endWhile:
  	
  	#jr $ra
