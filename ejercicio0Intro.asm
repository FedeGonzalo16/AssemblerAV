;Ejercicio 1;
.model small
.stack
.code
main PROC
    MOV AX,15
    MOV BX, 10
    ADD AX,BX

    ;generico, para mostrar en panatlla estas irq
    MOV AH, 9Ch
    INT 21h
main ENDP
END main
