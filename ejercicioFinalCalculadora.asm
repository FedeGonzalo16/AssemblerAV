.model small
.stack
.data
    ;carga vars
    saltoLinea db 13, 10, '$'
    buffer DB 8 dup(?) ;hasta 8 digitos
    aux DW 0
    esNegativo db 0

    msjI DB 'CALCULADORA ASSEMBLER $'
    msj0 DB 'Operaciones disponibles: Suma, Resta, divison o multiplicacion: $'
    mensajeN1 DB 'Ingrese el primer numero: $'
    mensajeOp DB 'Ingrese el operador (+ - * /): $'
    mensajeN2 DB 'Ingrese el segundo numero: $'
    msj2 DB 'Error: no se puede dividir por 0 $'
    msj3 DB 'El resultado en decimal es: $'
    msj4 DB 'El resultado en hexadecimal es: $'
    msj5 DB 'El resultado en binario es: $'
    msj6 DB 'El resultado en octal es: $'

    menos db '-'         ; para imprimir el signo negativo
    punto db '.'         ; para imprimir el punto decimal
    operador DB ?
    igual DB '=$'
    espacio DB ' $'

    ;DW para 16 bits
    n1 DW 0
    n2 DW 0
    res DW 0

.code
    main PROC

        CARGA:
    ; importar variables
    mov ax, @data
    mov ds, ax
    xor ax, ax

    ; resetear bandera de negativo
    mov esNegativo, 0

    ; salto de línea
    mov dx, offset saltoLinea
    mov ah, 9
    int 21h

    ; salto de línea
    mov dx, offset msjI
    mov ah, 9
    int 21h

    ; salto de línea extra
    mov dx, offset saltoLinea
    mov ah, 9
    int 21h

    ; mostrar operaciones disponibles
    mov dx, offset msj0
    mov ah, 9
    int 21h

    ; salto de línea
    mov dx, offset saltoLinea
    mov ah, 9
    int 21h

    ; mensaje: primer número
    mov dx, offset mensajeN1
    mov ah, 9
    int 21h

    ; pedir n1
    CALL cargaNumero
    xor ax, ax
    mov ax, aux 
    mov aux, 0
    mov n1, ax

    ; salto de línea
    mov dx, offset saltoLinea
    mov ah, 9
    int 21h

    ; mensaje: operador
    mov dx, offset mensajeOp
    mov ah, 9
    int 21h

    ; pedir operando
    CALL cargarOperando

    ; salto de línea
    mov dx, offset saltoLinea
    mov ah, 9
    int 21h

    ; mensaje: segundo número
    mov dx, offset mensajeN2
    mov ah, 9
    int 21h

    ; pedir n2
    CALL cargaNumero
    xor ax, ax
    mov ax, aux 
    mov aux, 0
    mov n2, ax

    ; salto de línea
    mov dx, offset saltoLinea
    mov ah, 9
    int 21h

    ; pasar operador a CL
    mov cl, operador

    ; determinar operacion
    CMP cl, 2Bh
    JE HACER_SUMA

    CMP cl, 2Dh
    JE HACER_RESTA

    CMP cl, 2Fh
    JE HACER_DIVI

    CMP cl, 2Ah
    JE HACER_MULTI

        ;calculos llamadas
        HACER_SUMA:
            CALL suma
            JMP IMPRESION
        HACER_RESTA:
            CALL resta
            JMP IMPRESION           
        HACER_MULTI:
            CALL multiplicacion
            JMP IMPRESION
        HACER_DIVI:
            CALL division
            JMP IMPRESION

        IMPRESION:
            ;impresiones
            CALL imprimirBuffer  
            CALL Decimal_Hexadecimal
            CALL Decimal_Binario
            CALL Decimal_Octal    
        
        FIN:
            ;finalizar programa
            mov ah, 4Ch
            int 21h
    main ENDP

    cargaNumero PROC
        ;reiniciar acum
        mov aux, 0

        ;carga de numero
        Digito:
            mov ah, 01h
            int 21h

            CMP al, 0Dh
            JE finCarga
            
            xor ah, ah
            
            SUB al, 30h
            mov bl, al
            
            mov ax, aux
            mov ch, 10d
            MUL ch
            add ax, bx
            mov aux, ax

            JMP Digito
        finCarga:
            ret
    cargaNumero ENDP
    
    cargarOperando PROC
        ;consulta operando

        mov ah, 1h 
        int 21h
        mov operador, al

        ret
    cargarOperando ENDP
    
    suma PROC
        xor ax, ax
        xor bx, bx

        mov ax, n1
        mov bx, n2
        add ax, bx
        mov res, ax
        ret
    suma ENDP

    resta PROC
        mov ax, n1
        sub ax, n2
  
        cmp ax, 0
        jge store_res 
        ;si no es negativo  
        neg ax
        mov esNegativo, 1
        ;guardar el result
        store_res:
         mov res, ax
        ret
    resta ENDP

    multiplicacion PROC
        xor ax, ax

        mov ax, n1
        mov bx, n2
        mul bx
        mov res, ax
        ret
    multiplicacion ENDP

    division PROC
        mov ax, n1
        mov bx, n2
        cmp bx, 0
        je division_Error ;si divisor es 0, salgo con error

        xor dx, dx
        div bx ; AX / BX → AX = parte entera, DX = resto
        mov res, ax  ; guardar parte entera

        ;Calcular parte decimal
        mov ax, dx ;resto
        mov cx, bx ;divisor
        
        xor dx, dx

        mov bx, 10 ;multiplico resto por 10
        mul bx ;AX = resto * 10
        div cx ;AX / divisor, parte decimal
        mov aux, ax ;parte decimal, un digito
        ret
    division ENDP

    division_Error PROC
        mov dx, offset saltoLinea
        mov ah, 9
        int 21h

        mov dx, offset msj2
        mov ah, 9
        int 21h

        mov ah, 4Ch
        int 21h

        ret
    division_Error ENDP 

    imprimirNumero PROC
    ; AX contiene el número a imprimir
     cmp ax, 0
     jne siguiente
     ;si no es 0 sigue, sino tira 0
     mov dl, '0'
     mov ah, 2
     int 21h
     ret
    
    ;inicializ indice
    siguiente:
     xor si, si
    
    ;separar digitos
    ;div ax entre 10
    ;Cociente: AX, resto: DX
    imprimirLoop:
        xor dx, dx
        mov bx, 10
        div bx
        add dl, '0'
        mov buffer[si], dl
        inc si
        cmp ax, 0
        jne imprimirLoop
    
    ;imprimir en orden correcto
    ;decrementa si, carga digito desde buffer en dl
    imprimirOrden:
        dec si
        mov dl, buffer[si]
        mov ah, 2
        int 21h
        cmp si, 0
        jne imprimirOrden
        ret
    ;imprime hasta si == 0
    imprimirNumero ENDP 

        imprimirBuffer PROC

        ; salto de línea antes de resultado
        mov dx, offset saltoLinea
        mov ah, 9
        int 21h
        
        ; salto de línea antes de resultado
        mov dx, offset saltoLinea
        mov ah, 9
        int 21h

        ; mensaje print
        mov dx, offset msj3
        mov ah, 9
        int 21h

        ; Mostrar primer número
        mov ax, n1
        call imprimirNumero

        ; Imprimir espacio
        mov ah, 09h
        lea dx, espacio
        int 21h 

        ; Mostrar operador
        mov dl, operador
        mov ah, 2
        int 21h

        mov ah, 09h
        lea dx, espacio
        int 21h 

        ; Mostrar segundo número
        mov ax, n2
        call imprimirNumero

        mov ah, 09h
        lea dx, espacio
        int 21h 

        ; Imprimir " = "
        mov dx, offset igual
        mov ah, 9
        int 21h

        mov ah, 09h
        lea dx, espacio
        int 21h 
        
        ;si la resta da negativa
        cmp esNegativo, 1
        jne CONTINUAR_IMPRESION

        ;imprimir signo
        mov dl, '-'
        mov ah, 2
        int 21h

        CONTINUAR_IMPRESION: 

            mov ax, res
            cmp ax, 0
            jne CARGAR_BUFFER

            ;si es 0 imprima 0
            mov dl, '0'
            mov ah, 2
            int 21h
            jmp IMPRIMIR_DECIMAL

            ; imprimir decenas
            add ah, 30h
            mov dl, ah
            mov ah, 2
            int 21h

            CARGAR_BUFFER:
            xor si, si

            CARGA_LOOP:
             xor dx, dx
             mov bx, 10
             div bx
             add dx, '0'
             mov buffer[si], dl
             inc si
             cmp ax, 0
             jne CARGA_LOOP

            IMPRIMIR_BUFFER:
                dec si
                mov dl, buffer[si]
                mov ah, 2
                int 21h
                cmp si, 0
                jne IMPRIMIR_BUFFER         

            ;si hubo division mostrar parte decimal
            IMPRIMIR_DECIMAL:
             cmp operador, '/'
             jne FIN_IMPRESION

             ; Imprimir punto
             mov dl, '.'
             mov ah, 2
             int 21h

             ; Imprimir parte decimal 
             mov ax, aux
             add al, '0'
             mov dl, al
             mov ah, 2
             int 21h

             ; salto de linea
             mov dx, offset saltoLinea
             mov ah, 9
             int 21h

            FIN_IMPRESION:  
             ret
    imprimirBuffer ENDP

    ;4 bits x digito - dividir en 4 
    Decimal_Hexadecimal PROC

       ; salto de línea antes de resultado
        mov dx, offset saltoLinea
        mov ah, 9
        int 21h

        ; mensaje print
        mov dx, offset msj4
        mov ah, 9
        int 21h

        ; Mostrar primer número
        mov ax, n1
        call imprimirNumero

        ; Imprimir espacio
        mov ah, 09h
        lea dx, espacio
        INT 21h 

        ; Mostrar operador
        mov dl, operador
        mov ah, 2
        int 21h

        mov ah, 09h
        lea dx, espacio
        INT 21h 

        ; Mostrar segundo número
        mov ax, n2
        call imprimirNumero

        mov ah, 09h
        lea dx, espacio
        INT 21h 

        ; Imprimir " = "
        mov dx, offset igual
        mov ah, 9
        int 21h

        mov ah, 09h
        lea dx, espacio
        INT 21h 

        mov ax, res          ; cargar número en AX
        xor cx, cx           ; contador de caracteres
        mov si, 0            ; índice para buffer

     siguiente_hex:
        xor dx, dx
        mov bx, 16           ; base hexadecimal
        div bx               ; AX / 16, cociente en AX, resto en DL

        cmp dl, 9
        jbe digito_decimal
        add dl, 55           ; para letras A-F (10 → A, etc.)
        jmp guardar_hex

     digito_decimal:
        add dl, '0'

     guardar_hex:
        mov buffer[si], dl
        inc si
        inc cx
        cmp ax, 0
        jne siguiente_hex

        imprimir_hex:
        dec si
        mov dl, buffer[si]
        mov ah, 2
        int 21h
        loop imprimir_hex

     ret
    Decimal_Hexadecimal ENDP

    ;Bit a bit de derecha a izquierda
    Decimal_Binario PROC
     
      ; salto de línea antes de resultado
        mov dx, offset saltoLinea
        mov ah, 9
        int 21h

        ; mensaje print
        mov dx, offset msj5
        mov ah, 9
        int 21h

        ; Mostrar primer número
        mov ax, n1
        call imprimirNumero

        ; Imprimir espacio
        mov ah, 09h
        lea dx, espacio
        INT 21h 

        ; Mostrar operador
        mov dl, operador
        mov ah, 2
        int 21h

        mov ah, 09h
        lea dx, espacio
        INT 21h 

        ; Mostrar segundo número
        mov ax, n2
        call imprimirNumero

        mov ah, 09h
        lea dx, espacio
        int 21h 

        ; Imprimir " = "
        mov dx, offset igual
        mov ah, 9
        int 21h

        mov ah, 09h
        lea dx, espacio
        int 21h 

    ;paso res a ax, si para recorrer
    ;y bx 2 que representa base binario, por el cual dividir
     mov ax, res
     xor si, si
     mov bx, 2

     FORBINARIO:
      xor dx, dx
      div bx ;cociente en ax, resto en dl
      add dl, '0'
      mov buffer [si], dl ;carga del res en la pos actual del buffer
      inc si

      cmp ax, 0 ;si llego a 0, si no llego sigo imprimiendo
      jne FORBINARIO

     IMPRIMIRBINARIO:
      dec si
      mov dl, buffer[si] ;sigo al siguiente
      mov ah, 2
      int 21h
      cmp si, 0 
      jne IMPRIMIRBINARIO

     ret
    Decimal_Binario ENDP

    ;cada 3 bits un digito, dividir por 8 y guardar restos
    ;Division sucesiva por 8
    Decimal_Octal PROC
     
     ; salto de línea antes de resultado
        mov dx, offset saltoLinea
        mov ah, 9
        int 21h

        ; mensaje print
        mov dx, offset msj6
        mov ah, 9
        int 21h

        ; Mostrar primer número
        mov ax, n1
        call imprimirNumero

        ; Imprimir espacio
        mov ah, 09h
        lea dx, espacio
        int 21h 

        ; Mostrar operador
        mov dl, operador
        mov ah, 2
        int 21h

        mov ah, 09h
        lea dx, espacio
        int 21h 

        ; Mostrar segundo número
        mov ax, n2
        call imprimirNumero

        mov ah, 09h
        lea dx, espacio
        int 21h 

        ; Imprimir " = "
        mov dx, offset igual
        mov ah, 9
        int 21h

        mov ah, 09h
        lea dx, espacio
        int 21h 
    
    ;paso res a ax, inicilizo contador, si para recorrer
    ;y bx 8 que representa base octal, por el cual dividir
     mov ax, res
     xor si, si

     mov bx, 8 ;base octal

     FOR_OCTAL:
      xor dx, dx
      div bx ;cociente en ax, resto en dl
      add dl, '0'
      mov buffer [si], dl  ;carga del res en la pos actual del buffer
      inc si

      cmp ax, 0 ;si llego a 0, si no llego sigo imprimiendo
      jne FOR_OCTAL    

     IMPRIMIR_OCTAL:
      ;termina apuntando al ultimo elemento, decrementarlo para imprimir
      dec si
      mov dl, buffer[si] ;sigo al siguiente
      mov ah, 2
      int 21h

      cmp si, 0
      jne IMPRIMIR_OCTAL

     ret
    Decimal_Octal ENDP 

END main