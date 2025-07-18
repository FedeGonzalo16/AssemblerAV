.model small
.stack 

.data
    ;salto linea 
    saltoLinea DB 13, 10, '$'
    ; segemento de codigo    
.code

    ; procedimiento principal main
 main PROC
    mov ax,@data
    mov ds,ax
   xor ax,ax
    
    mov al, 2
    mov bl, 9

    xchg al,bl  
  
  add al, 30h
  mov dl, al
  mov ah, 2
  int 21h   
  
    ;impresion por pantalla del salto de linea
  mov dx, offset saltoLinea
  mov ah, 9
  int 21h
     
  
  add bl, 30h
  mov dl, bl
  mov ah, 2
  int 21h   
   

 main ENDP   

end main





