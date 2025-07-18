;Ejercicio 2
.model small
.stack
.code
main PROC
    
    MOV cx,10
    sub cx, 3

    ADD cl, 30h
    MOV dl, cl
    MOV ch, 2h
    INT 21h

    ;generico, para mostrar en panatlla estas irq
    MOV AH,4Ch
    int 21h

main ENDP
END main