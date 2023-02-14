.text

main:

  la $t0, array			# $t0 = direccion base del arreglo
  	
  add $t1, $0, $0  		# Inicializando el iterador
  
  while1:
  
  sll $t2, $t1, 2		# Shamt=2 multiplica por 4 el iterador y el resultado lo almacena en $t2
  add $t2, $t2, $t0		# suma el resultado previo con la direccion base del array y lo almacena de nuevo en $t2. (Guarda direcciones)
  lw $t3, 0($t2)		# Mantiene fija la casilla especifica del arreglo para que no se desfase. Guarda el valor de esta en $t3 para hacer uso del valor.
  beq $t3, $0, endWhile1 	# Verifica si el valor es 0 para terminar el ciclo.
  
  addi $t1, $t1, 1		# Se suma 1 al iterador si el valor de la casilla no es cero para entrar de nuevo al ciclo y seguir a la siguiente casilla.
  
  j while1			# Etiqueta para comenzar el ciclo de nuevo y avanzar otra casilla
  
  endWhile1: 			# Etiqueta para terminar el ciclo cuando llego al valor cero
  
  addi $t1, $t1, 1		# Se le suma un 1 mas al iterador para que tome en cuenta el valor cero.
  addi $t2, $t2, 4		# Correr la direccion del segundo array porque queda 4 posiciones atras por la condicion del cero		#Guardar el arreglo en la direccion luego de donde termina el arreglo anterior 
  
  and $t3, $0, $0 		# Incializando el iterador del segundo array en $t3
 
  for1:

  slt $t4, $t3, $t1		# Que el iterador $t3 sea menor a la cantidad de elementos + 1 del primer arreglo. $t4=1 mientras se cumpla
  beq $t4, $0, endFor1   	# Con $t4=0 ya no se cumple y termina el ciclo.
  
  sll $t5, $t3, 2		# Shamt=2 multiplica por 4 el iterador y el resultado lo almacena en $t5
  
  add $t6, $t5, $t0		# Suma en $t5 la direccion base del primer arreglo $t0 mas el resultado en $t5 para formar el tamano de casilla
  lw $t7, 0($t6)		# Mantiene fija la casilla especifica del arreglo para que no se desfase. Guarda el valor de esta en $t7 para hacer uso del valor.
   
  add $t8, $t5, $t2 		# Suma en $t6 el resultado en $t5 + direccion base del segundo arreglo para formar la otra casilla
  sw $t7, 0($t8)		# Se va a la direccion de la casilla del otro array y guarda lo que habia cargado de la memoria del primer array
   
  addi $t3, $t3, 1		# Se suma 1 al iterador si el valor de la casilla no es cero para entrar de nuevo al ciclo y seguir a la siguiente casilla. 
  
  j for1			# Etiqueta para comenzar el ciclo de nuevo y avanzar otra casilla
  
  endFor1: 			# Etiqueta para terminar el ciclo cuando llego al valor limite de cantidad de elementos
  
 				# $t0 tengo la dir base del arreglo original. En $t2 tengo la dir base del segundo arreglo, en $t1 tengo la cantidad de elementos de los arreglos
 
  
  and $t3, $0, $0 		# Iterador for externo                             	                             	                             	                             	                            
                         

externalFor1:			# Primer ciclo para mover todos los numeros pares al inicio a como esta el array original
	
	slt $t4, $t3, $t1 
	beq $t4, $0, endExternalFor1
	
	sll $t5, $t3, 2
	
	add $t6, $t5, $t2 	# En $6 estan mis nuevas direcciones. Con esto muevo mi elemento fijo
	
	lw $t4, ($t6) 		# El elemento fijo 
	
	andi $s6, $t4, 1	# Mascara para saber el LSB. Cero=par. Si $s6=1, el numero es impar y ocupo cambiarlo
	beq $s6, 0, endInternalFor1	# Si el numero es par, no se cambia. Si es impar, lo cambio por el primer par que encuentre
	
	addi $t7, $t3, 1 	# Mi segundo iterador sera iterador externo + 1
	
	internalFor1:
	
		slt $s0, $t7, $t1
		beq $s0, $0, endInternalFor1
		
		sll $s1, $t7, 2
		add $s2, $s1, $t2
		
		lw $s3, ($s2)
		
		andi $s5, $s3, 1	# Hace lo mismo de arriba. Si $s5=0,hay que realizar cambio 
		beq $s5, 1, dontSwap1 	# Si $s5 es 1, es impar y no se quiere cambiar un impar por un impar
		
		sw $t4, ($s2)		# Se realiza el cambio
		sw $s3, ($t6)
		j endInternalFor1
		
		dontSwap1:
		
		addi $t7, $t7, 1
		j internalFor1
		
	endInternalFor1:
	
		addi $t3, $t3, 1
		j externalFor1
endExternalFor1:


 and $t3, $0, $0 #iterador for externo                             	                             	                             	                             	                            
                         

externalFor2:	# Con este ciclo se ordenan de forma ascendente solamente los numeros pares
	slt $t4, $t3, $t1 
	beq $t4, $0, endExternalFor2
	
	sll $t5, $t3, 2
	
	add $t6, $t5, $t2 		# En $6 estan mis nuevas direcciones. Con esto muevo mi elemento fijo
	
	lw $t4, ($t6) 			# El elemento fijo 
	
	addi $t7, $t3, 1 		# Mi segundo iterador sera iterador externo + 1.
	
	internalFor2:
	
		slt $s0, $t7, $t1
		beq $s0, $0, endInternalFor2
		
		sll $s1, $t7, 2
		add $s2, $s1, $t2
		
		lw $s3, ($s2)
		
		andi $s5, $s3, 1 	# Mascara para obtener LSB para solo aplicarle la condicion a los pares	
		beq $s5, 1, dontSwap2	# Los numeros impares quedan intactos
		
		slt $s4, $s3, $t4 	# $t4 mayor a $s3 
		beq $s4, $0, dontSwap2 	# Ascendente
		
		sw $t4, ($s2)		# Se cambian las posiciones
		sw $s3, ($t6)
		
		lw $t4, ($t6)
		
		dontSwap2:
		
		addi $t7, $t7, 1
		j internalFor2
		
	endInternalFor2:
	
		addi $t3, $t3, 1
		j externalFor2
endExternalFor2:


 and $t3, $0, $0 			#iterador for externo                             	                             	                             	                             	                            
                         

externalFor3:				# Ciclo para finalmente ordenar solamente los numeros impares de forma descendente

	slt $t4, $t3, $t1 
	beq $t4, $0, endExternalFor3
	
	sll $t5, $t3, 2
	
	add $t6, $t5, $t2 		# En $6 estan mis nuevas direcciones. Con esto muevo mi elemento fijo
	
	lw $t4, ($t6) 			# El elemento fijo 
	
	andi $s5, $t4, 1		# Mascara para obtener el LSB y revisar que sea impar
	beq $s5, 0, endInternalFor3  
	
	addi $t7, $t3, 1 		# Mi segundo iterador sera iterador externo + 1.
	
	internalFor3:
	
		slt $s0, $t7, $t1
		beq $s0, $0, endInternalFor3
		
		sll $s1, $t7, 2
		add $s2, $s1, $t2
		
		lw $s3, ($s2)
		
		slt $s4, $t4, $s3 	# $s3 mayor a $t4 para que sea un ordenamiento descendente 
		beq $s4, $1, dontSwap3  # Descendente
		
		sw $t4, ($s2)		# Se cambian las posiciones
		sw $s3, ($t6)
		
		lw $t4, ($t6)
		
		dontSwap3:
		
		addi $t7, $t7, 1
		j internalFor3
		
	endInternalFor3:
	
		addi $t3, $t3, 1
		j externalFor3
endExternalFor3:


  li $v0, 10            	# Finaliza el programa.
  syscall
 

.data

array:
      .word 87, 216, -54, 751, 1, 36, 1225, -446, -6695, -8741, 101, 9635, -9896, 4, 2008, -99, -6, 1, 544, 6, 7899, 74,-42, -9, 0               # Declaracion e Inicializacion del arreglo.
