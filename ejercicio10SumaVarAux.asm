.model small
.stack
.data
    ;declaracion de vars
    num1 db 5
    num2 db 3
    res db  ?
.code
main PROC
    ;llamada de vars
    mov ax, @data
    mov ds,ax
    xor ax,ax
    
    ;opcion 1
    mov al, num1
    add al, num2    
    mov res, al
    
    ;convertir a ascii y mostar
    impresion:   
    add al, 30h
    mov dl, al
    mov ah, 2h
    int 21h
    
    ;salida del programa 
    mov ah,4Ch
    int 21h
    
main ENDP       
END main




