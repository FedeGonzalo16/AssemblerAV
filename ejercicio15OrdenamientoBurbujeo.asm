;Ordenamiento
.model small
.stack 100h
.data
  saltoLinea DB 13, 10, '$'
  msg1 db 'Ingrese un numero entre 0 y 9 $'
  msg5 db 'El resultado del ordenamiento es: $' 
  arreglo db 3 dup(?); vector con 3 elem

.code
 main:
  mov ax, @data
  mov ds, ax

  xor ax, ax
  
  mov cx, 3; contador elem
  mov si, 0; indice elem
  
  ENTRADAS:
  
    ; mensaje 1
    mov dx, offset msg1
    mov ah, 9
    int 21h

    ; ingresar num
    mov ah, 1
    int 21h
    sub al, 30h
    ;guardamos el num en el arreglo
    mov arreglo[si], al
    
    ;salto de linea
    mov dx, OFFSET saltoLinea
    mov ah, 09h
    int 21h
    
    inc si; pasa al sig elemento a cargar
    
   CALCULOS:
   
    loop ENTRADAS
    
    ;Burbujeo
    
    mov cx, 2 ;contador de pasadas, son 2, n-1
    
    BUCLE_EXT:
    
    mov si, 0 ;indice inic para comparar
    mov bx, 2 ;n-1 cmp internas, 3 elem = 2 comparac
    
    BUCLE_INT:
    
    mov al, arreglo[si] ;se carga 1er elem
    mov ah, arreglo[si+1] ;se carga 2ndo elem
    cmp al, ah ;se comparan
    jbe NO_SWAP ;si es menor el de adelante, no se swapea 
    
    ;swapeo
    ;sino intercambio al con ah, al > ah
    mov arreglo[si], ah ;intercambio ah al indice
    mov arreglo[si+1], al; paso al al sig elemento
    
    ;si no se requiere intercambiar
    NO_SWAP:
    inc si ;inc indice
    dec bx
    jnz BUCLE_INT ;si no es = o no es 0    
    loop BUCLE_EXT ;sino se repite para cx pasadas
    
    ;Impresion del vector ordenado
    mov dx, OFFSET msg5
    mov ah, 09h
    int 21h
    
    mov si, 0   
    
    IMPRESION:
    
    ;imprimo la posic del vector
    mov dl, arreglo[si]
    add dl, 30h           
    mov ah, 2
    int 21h
    
    ;si no hay mas elem a comparar se hace el salto final
    cmp si, 2
    je SALTO_FINAL
    
    ;imprimir un espacio
    mov dl, ' '
    mov ah, 2
    int 21h
    
    ;mientras hayan elem a imprimir, siga imprimiendo
    inc si
    cmp si, 3
    jne IMPRESION; si no se imprimieron los 3 elem
    
    SALTO_FINAL:
    ; Imprimir salto de linea
    mov dx, offset saltoLinea
    mov ah, 9
    int 21h
  
    FIN:  
    mov ah, 4Ch
    int 21h
   
 end main




