.model small
.stack 100h
.data
  saltoLinea DB 13, 10, '$'
.code
 main:
  mov ax,@data
  mov ds,ax
  xor ax,ax
  
  
  xor si,si 
  FOR:
   inc si
   cmp si, 10d
   je EXIT
        
   mov cx, si
   
   ;si es mas grande q un low o high
   add cx, 30h
   mov dx, cx    
   mov ah, 2
   int 21h
   
   mov dx, offset saltoLinea
   mov ah, 9
   int 21h
   
   xor cx,cx

   jmp FOR
   
   EXIT:
  
   mov ah,4Ch
   int 21h  
 end main 




