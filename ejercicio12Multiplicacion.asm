.model small
.stack
.data
.code
main PROC

    mov ax, 5
    add ax, 2
    mov cx, 3
    xor dx, dx
    mul cx

    mov bx, 10

    div bx

    mov cl, al
    mov ch, dl

    add cl, 30h
    mov dl, cl
    mov ah, 2
    int 21h

    add ch, 30h
    mov dl, ch
    mov ah, 2
    int 21h

    mov ah, 4Ch
    int 21h

main ENDP
END main





