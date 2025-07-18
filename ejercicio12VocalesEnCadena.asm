;Vocales
.model small
.stack 100h
.data
  saltoLinea DB 13, 10, '$'
  msg1 db 'Ingrese una cadena de hasta 20 caracteres $'
  msg5 db 'La cantidad de vocales son: $' 
  arreglo db 20 dup(?); vector con 20 elem
  contador db 0
  res db ?
.code
main:
  mov ax, @data
  mov ds, ax

  xor ax, ax
  
  ; Mostrar mensaje de ingreso
  mov dx, offset msg1
  mov ah, 9
  int 21h
  
  ;hasta los 20 caracteres
  xor cx, cx; contador elem
  xor si, si; indice elem
  
  ENTRADAS:

   ; ingresar caracter
   mov ah, 1
   int 21h
  
   ;corte si toca enter
   cmp al, 13                  
   je FIN_ENTRADA
  
   ;guardamos el caracter en el arreglo
   mov arreglo[si], al   
   inc si; pasa al sig elemento a cargar 
   inc cx
   cmp cx, 20; si no se ingresaron 20
   jne ENTRADAS 
  
  FIN_ENTRADA:
   ;contar vocales minus 
   xor si, si ; si = indice
   xor bl, bl ; bl = contador de vocales
  
  CALCULOS:
   ;comparo indice con contador
   cmp si, cx
   jae FIN_CONTEO ;si no hay mas elem a contar
   mov al, arreglo[si]
  
   cmp al, 'a'
   je SUMAR        
   cmp al, 'e'
   je SUMAR 
   cmp al, 'i'
   je SUMAR 
   cmp al, 'o'
   je SUMAR
   cmp al, 'u'
   je SUMAR; si es =, lo cuento
   
  CONTINUAR:
   inc si; sigo al sig elemento
   jmp CALCULOS; y vuelvo a comparar 
       
  SUMAR:
   inc bl;incremento contador
   jmp CONTINUAR ;sigue con lo q queda
                                    
  FIN_CONTEO:
   ;guardo el contador en resultado
   mov res, bl
  
  IMPRESION:
  
  ; Mostrar salto de linea
  mov dx, offset saltoLinea
  mov ah, 9
  int 21h
  
  ;Impresion del vector ordenado
  mov dx, OFFSET msg5
  mov ah, 09h
  int 21h
  
  ;Convertir numero a ascii, el contador
  mov al, res
  add al, 30h
  mov dl, al
  mov ah, 2
  int 21h
    
  FIN:  
    mov ah, 4Ch
    int 21h 

end main




                    