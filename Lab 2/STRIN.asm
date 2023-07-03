.model small
.stack 100h
.data
    msg  db ""    ; during runtime the input will be filled
.code

main PROC
         mov ax,@data
         mov ds,ax

         mov ah,0ah           ; 0ah is the string input function
         mov dx,offset msg    ; now the input is transferred to dl register
         int 21h

         mov ah,4ch           ; exit the function
         int 21h              ; close the dos

main ENDP
end main