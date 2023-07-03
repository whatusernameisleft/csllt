.model small
.stack 100h
.code
.startup
    mov al, 4       ; assigning value to al register
    mov bl, 2       ; assigning value to bl register
    add al, bl      ; add (al+bl), al is called implied register or resultant register

    mov dl, al      ; move al value to dl register
    add dl, 30h     ; 30h is the ascii code for digit 0

    mov ah, 02h     ; display character function
    int 21h

    mov ah, 4ch
    int 21h
.exit
end

; 41h is the ascii code for character A