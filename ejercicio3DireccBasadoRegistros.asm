.model small
.stack 100h
.data
 num db 4
 resultado db ?
 saltoLinea db 13, 10, '$'
.code
main:
 ;traemos la data
 mov ax, @data
 mov ds,ax
 
 lea si, num; carga la direcc del num
 mov al, [si]; al = direcc del num, el valor de esa direcc de memo
 add al, al; multi 4 x 4
 
 mov resultado, al ; guardo result

 mov al, resultado
 add al, 30h
 mov dl, al
 mov ah, 2
 int 21h
 
 mov dx, offset saltoLinea
 mov ah,9
 int 21h
 
 mov ah, 4Ch
 int 21h
 
 end main 
 


