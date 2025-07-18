;ej mensaje personalizado
.model small
.stack 100h
.data
  saltoLinea db 10, 13, '$'
  input db 'Presione una tecla: $'
.code
main:
 mov ax, @data
 mov ds, ax
 xor ax, ax
 
 ;printeo del input
 mov dx, offset input
 mov ah, 9
 int 21h
 
 ;solicitamos ingreso
 mov dl, al
 mov ah, 1H
 int 21h
 
 mov cl, al
 
 ;salto linea
 mov dx, offset saltoLinea
 mov ah, 9
 int 21h
 
 ;print salida
 mov dl, cl
 mov ah, 2
 int 21h
 
 mov ah, 4Ch
 int 21h

end main



