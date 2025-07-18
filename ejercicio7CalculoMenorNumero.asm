.model small
.stack 100h
.data
 input db 'Ingrese un num: $'
 mayor db 'El mayor es: $'
 num1 db 2
 num2 db 5
 saltoLinea db 10, 13, '$'
.code
 main:
  mov ax, @data
  mov ds, ax
  xor ax, ax
  
  mov dx, offset input
  mov ah, 9
  int 21h
   
  mov ah, 1H
  int 21h
   
  mov cl, al
  xor ax, ax

  mov dx, offset input
  mov ah, 9
  int 21h
   
  mov ah, 1H
  int 21h
   
  mov ch, al
  sub ch, 30h
  xor ax, ax
  
  printMayor:
  cmp cl, ch
   je L1
   jmp L2
   
   L1:
   
   add cl, 30h
   mov dl, cl
   mov ah, 2
   int 21h 

   mov dx, offset mayor
   mov ah, 9
   int 21h
   
   mov dx, offset saltoLinea
   mov ah, 9
   int 21h
           
   add al, 30h
   mov dl, cl
   mov ah, 2
   int 21h
  
   L2:
   
   mov dx, offset mayor
   mov ah, 9
   int 21h
   
   mov dx, offset saltoLinea
   mov ah, 9
   int 21h
  
   add ch, 30h
   mov dl, ch
   mov ah, 2
   int 21h            
   
  mov ah,4Ch
  int 21h    
end main




