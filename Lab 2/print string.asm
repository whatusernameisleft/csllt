.model small
.stack 100h
.data                                 ; data section

     msg  db "Welcome to CSLLT $"     ; msg - variable name
     ; db - define bytes

.code

MAIN PROC
          mov ax,@data          ; @data - address of data
          mov ds,ax             ; moving address from ax to ds register
     ; ds - data segment register (stores addresses of data)

          mov ah,09             ; string display function
          mov dx,offset msg     ; dx - data register
     ; offset - read/access character by character
          int 21h               ; open dos
    
          mov ah,4ch            ; exit function
          int 21h               ; close dos
MAIN ENDP
END MAIN