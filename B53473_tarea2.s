#Tarea 2
#Amy Herrera Mora - B53473

.data
  newLine: .asciiz "\n"
  array1: .asciiz "El arreglo original es:"
  array2: .asciiz "Hola! Como estas?:)"
  array3: .asciiz "El arreglo modificado es:"
  array4: .asciiz ""
.text

main:

	la $s0, array2			# Dir base arreglo original
	la $s1, array4			# Dir base arreglo modificado
	
	addi $s2, $0, 'A' 		# Guarda A en registro fijo
	addi $s3, $0, 'E'		# Guarda E en registro fijo
	addi $s4, $0, 'I'		# Guarda I en registro fijo
	addi $s5, $0, 'O'		# Guarda O en registro fijo
	addi $s6, $0, 'U'		# Guarda U en registro fijo
	jal modificaArreglo		# Funcion que modifica 
  	
  	li $v0, 10 			# Se indica que termine
  	syscall
	
  
modificaArreglo:

	add $t0, $0, $0  		# Inicializando el iterador 1
	add $t1, $0, $0  		# Inicializando el iterador 2
  
  while:

  	add $t2, $t0, $s0			# While 
  	lbu $t3, 0($t2)			# Mantiene fija la casilla
  	beq $t3, $0, endWhile 		# Verifica si el valor es 0 para terminar el ciclo
  
  	addi $t6, $0, 0x40			# @
  	addi $t7, $0, 0x5B			# [
  
  	slt $t4, $t6, $t3			# $t6 < $t3
  	beq $t4, $0, fueraRangoMayus
  
  	slt $t5, $t3, $t7			# $t3 < $t7
  	beq $t5, $0, fueraRangoMayus 
  
  	beq $t3, $s2, fueraRangoCons 		# Compara cada letra con las vocales
  	beq $t3, $s3,	fueraRangoCons		# Rango de solo consonantes
  	beq $t3, $s4, fueraRangoCons
  	beq $t3, $s5, fueraRangoCons
  	beq $t3, $s6, fueraRangoCons
  
  	add $t8, $t1, $s1
  	sb $t3, 0($t8)
  	addi $t1, $t1, 1			# Se aumenta el iterador 2
  
  	addi $t0, $t0, 1			# Se aumenta el iterador 1
  	j while				# Etiqueta para comenzar el ciclo de nuevo y avanzar otra casilla
  
  fueraRangoMayus:
  	
  	addi $t6, $t6, 32		# Letra '
  	addi $t7, $t7, 32		# Letra {
  	
  	slt $t4, $t6, $t3		# $t6 < $t3
  	beq $t4, $0, fueraRangoCons	# Rango de consonantes es el rango deseado
  
  	slt $t5, $t3, $t7		# $t3 < $t7
  	beq $t5, $0, fueraRangoCons 
  	
  	subi $t3, $t3, 32
  	
  	 beq $t3, $s2, fueraRangoCons 	# Rango de consonantes es el deseado para modificar
  	 beq $t3, $s3, fueraRangoCons
  	 beq $t3, $s4, fueraRangoCons
         beq $t3, $s5, fueraRangoCons
         beq $t3, $s6, fueraRangoCons
  	 
  	 addi $t3, $t3, 32		# Se vuelven minusculas de nuevo
  	
  
  	 add $t8, $t1, $s1
  	 sb $t3, 0($t8)			# Guarda caracter original
  	 addi $t1, $t1, 1		# Aumenta iterador 2
  
  	 addi $t0, $t0, 1		# Aumenta iterador 1
  
  	j while				# Vuelve al ciclo
  	
  fueraRangoCons:	
  	
   	addi $t0, $t0, 1
   	j while
  
  
  endWhile: 				# Etiqueta para terminar el ciclo cuando llego al valor cero
  
  jal printArray			# Se llama a printArray
  
End:
 jr $ra					# Termina la funcion

printArray:

	li $v0, 4			# Se indica que imprima
	la $a0, array1			# Se le pasa la dir base por $a0
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall

	li $v0, 4
	la $a0, array2
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	
	li $v0, 4
	la $a0, array3
	syscall
	
	
	li $v0, 4
	la $a0, newLine
	syscall
	

	li $v0, 4
	la $a0, array4
	syscall