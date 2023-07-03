.model small
.stack 50h
.code

main proc
         mov ah,00h    ; display a character
         mov dl,al
         int 16h       ; BIOS service

         mov ah,4ch
         int 21h
main ENDP
end main