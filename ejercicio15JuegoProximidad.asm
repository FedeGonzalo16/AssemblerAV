.model small
.stack 100h
.data
  saltoLinea DB 13, 10, '$'
  msg1 db 'Ingrese un numero: $'
  msgMenor db 'El numero secreto es menor $'
  msgMayor db 'El numero secreto es mayor $'
  msgIgual db 'Sos la pesadilla, adivinaste, el numero es:  $'  
  res db 5
  COND1 db 1
  buffer db 4 dup(?); buffer para impresion 2 digito
.code
main:
 mov ax, @data
 mov ds, ax
 
 ENTRADA:
 
 ;mensaje
 mov dx, offset msg1
 mov ah, 9
 int 21h
                                                                               
 ;leer primer caracter
 mov ah, 1
 int 21h
 sub al, '0' ;convertir ASCII al numero
 mov bl, al  ;guardar decena provisional
 mov bh, 0   ;limpiar parte alta

 ;ver si viene otro caracter
 mov ah, 1
 int 21h
 cmp al, 13          ; Enter 
 je UN_DIGITO

 ;si no es enter, es otro digito
 sub al, '0'
 mov bh, al ;BH segundo digito
 mov al, bl ;BL primer digito
 mov bl, 10
 mul bl     ; al = al * 10
 add al, bh ; al = al + segundo digito
 jmp WHILE ;salta al while

 UN_DIGITO:
 mov al, bl ;si es 1 digito, se usa tal cual estaba
 
 ;Imprimir salto de lnea
 mov dx, offset saltoLinea
 mov ah, 9
 int 21h
  
 mov cl, COND1
 xor bh, bh 
  
 WHILE:
   cmp COND1, 1
   jnz FIN
   
   ;si el num ingresado es menor
   cmp al, res
   ;si es igual 
   je IGUAL
   jb MENOR ;salta si es menor  
   ;sino, es MAYOR   
   ;mensaje 
   mov dx, offset msgMayor
   mov ah, 9
   int 21h
   jmp ENTRADA
 
  MENOR: 
   ;mensaje  
   mov dx, offset msgMenor
   mov ah, 9
   int 21h
   jmp ENTRADA
  
  IGUAL:
   ;mensaje  
   mov dx, offset msgIgual
   mov ah, 9
   int 21h
   
   ;mensaje  
   mov dx, offset res
   mov ah, 9
   int 21h   
   jmp FIN
   
  IMPRIMIR:
  
  mov ax, bx
  xor si, si
  xor bx, bx

  CARGAR_BUFFER:
   xor dx, dx
   mov bx, 10d
   div bx

   add dx, 30h
   mov buffer[si], dl

   inc si

   cmp ax, 0d 
   je IMPRIMIR_BUFFER

   jmp CARGAR_BUFFER

  IMPRIMIR_BUFFER:
   
   dec si
   mov dl, buffer[si]
   mov ah, 02h
   int 21h

   cmp si, 0d 
   je FIN ;si no quedan mas salta al fin
   jmp IMPRIMIR_BUFFER  
   
 FIN:
  mov ah, 4Ch
  int 21h

end main




