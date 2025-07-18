;ej mensaje personalizado
.model small
.stack 100h
.data
  saltoLinea db 10, 13, '$'
  input1 db 'Ingrese un decimal: $'
  input2 db 'Ingrese otro decimal: $'
.code
main:
 mov ax, @data
 mov ds, ax
 xor ax, ax
 
 ;printeo del input 1
 mov dx, offset input1
 mov ah, 9
 int 21h
 
 ;solicito decimal 1
 mov ah, 1H
 int 21h
 
 ;pasarlo y restarle 30
 mov cl, al
 sub cl, 30h

 xor ax, ax
 
 ;salto linea
 mov dx, offset saltoLinea
 mov ah, 9
 int 21h
 
 ;printeo del input 2
 mov dx, offset input2
 mov ah, 9
 int 21h
 
 ;solicito decimal 2
 mov ah, 1H
 int 21h
 
 ;pasarlo y restarle 30 
 mov ch, al
 sub ch, 30h
  
 xor ax, ax
 
 add cl, ch
 ;necesario para divir
 mov bl, 10
 mov al, cl
 div bl
 
 mov cl, al
 mov ch, ah
 
 ;salto linea
 mov dx, offset saltoLinea
 mov ah, 9
 int 21h
 
 ;imprimir 
 add cl, 30h
 mov dl, cl    
 mov ah, 2
 int 21h
 
 ;imprimir  
 add ch, 30h
 mov dl, ch    
 mov ah, 2
 int 21h
 
 mov ah, 4Ch
 int 21h
end main




