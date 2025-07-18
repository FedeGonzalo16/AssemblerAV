.model small
.stack 100h
.data
 COND1 db 1
 saltoLinea DB 13, 10, '$'
 num db 'Ingrese numeros positivos: $'
 msg db 'La suma es: $'
 n db ?
.code
main:
 mov ax, @data
 mov ds, ax
 
 ;pedir nums
 mov dx, offset num
 mov ah, 9
 int 21h  
  
 mov cl, COND1
     
 ;acumulador nums 
 xor bh, bh
  
  WHILE:
   cmp COND1, 1
   jnz EXIT
   
   ;num 
   mov ah, 1
   int 21h       
   sub al, 30h
    
   ;corta el cilo con 0, calculando la suma
   cmp al, 0 
   je EXIT                     
              
    ;si no es
    NOES:
    ;calculo
     add n, al
     
     jmp WHILE 
    
   EXIT:   
    ;mensaje
    mov dx, offset msg
    mov ah, 9
    int 21h
        
    ;Imprimir salto de linea
    mov dx, offset saltoLinea
    mov ah, 9
    int 21h
    
    ;imprimir 2
    xor bx, bx
    xor cx, cx
    xor ax, ax
    xor dx, dx
    
    mov al, n
    mov bl, 10 
    div bl
     
    mov cl, al
    mov ch, ah
    
    add ch, 30h
    mov dl, ch
    mov ah, 2
    int 21h
    
    add cl, 30h
    mov dl, cl
    mov ah, 2
    int 21h          

    mov ah, 4Ch
    int 21h
    
end main




