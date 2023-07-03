.model small
.stack 100h
.code

main PROC
         mov ah,01h    ; input a character function in BIOS
         mov dl, al    ; now the input is transferred to dl register
         int 21h       ; it is input function so 16h can be used BIOS

         mov ah,02     ; character display function
         mov dl,al     ; now al transferring to dl register
         int 21h       ; open the dos

         mov ah,4ch    ; exit the function
         int 21h       ; close the dos

main ENDP
end main