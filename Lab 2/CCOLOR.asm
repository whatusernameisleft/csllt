.model small
.stack 100h
.code

.startup
    mov ah,09     ; string display function
    mov al,'A'    ; 'A' temporarily stored in al register
    mov bh,0      ; initial value of bh is 0
    mov bl,158    ; setting foreground and background (from 0 to 255)
    mov cx,8      ; repeat both colour for 8 times
    int 10h       ; bios service for applying colours

    mov ah,4ch    ; exit function
    int 21h       ; close dos
.exit
end