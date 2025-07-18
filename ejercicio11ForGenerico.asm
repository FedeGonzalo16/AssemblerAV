.model small
.stack 100h
.data
 saltoLinea db 10, 13, '$'
 letra db 'a $'
.code
main:
 mov ax, @data
 mov ds,ax
 xor ax,ax
 
 mov dl,letra 
 
 xor si,si
 FOR:
  cmp si, 5d
  je EXIT; menor y 0
  
  mov dx, offset letra
  mov ah, 9
  int 21h
   
  inc si
  jmp FOR
 
 EXIT:
 mov dx, offset saltoLinea
 mov ah, 9
 int 21h
 
 mov ah,4Ch
 int 21h            
              
end main




