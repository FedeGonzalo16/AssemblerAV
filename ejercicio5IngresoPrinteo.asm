.model small
.stack 100h
.data
 saltoLinea db 10, 13, '$'
.code
main:  
 mov ax,@data
 mov ds, ax
 xor ax, ax
 
 ;ingreso de un digito
 mov dl, al
 mov ah, 1H
 int 21h
 
 ;copio lo ingresado a una nueva var
 mov cl, al
 
 ;salto de linea
 mov dx, offset saltoLinea
 mov ah, 9
 int 21h
 
 ;add cl, 30h esto no va pq ya se ingresa num en hexa
 mov dl, cl
 mov ah, 2
 int 21h
 
 ;corte
 mov ah, 4Ch
 int 21h

end main




