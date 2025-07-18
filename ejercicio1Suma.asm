;Ejercicio 1;
.model small
.stack
.code
main PROC
    
    MOV ax,5
    ADD ax,2
    
    
    ADD al, 30h
    MOV dl, al
    MOV ah, 2h
    INT 21h

    ;generico, para mostrar en panatlla estas irq
    MOV AH,4Ch
    int 21h
    

main ENDP
END main



