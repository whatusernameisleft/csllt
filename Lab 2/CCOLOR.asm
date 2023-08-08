.model small
.stack 100h
.data
    MAX db 5
    NAMELEN db 3
    amogus db 1, 2, 3, 4, 5
           db 'abc', 'def', 'ghi', 'jkl', 'mno'
           db 5, 2, 4, 6, 8
           db 0, 0, 0, 0, 0, '$'
    qOffset dw ?
.code

loadLow macro low, high, value
    mov low, value
    mov high, 0
endm

.startup
    ; mov ah,09     ; string display function
    ; mov al,'A'    ; 'A' temporarily stored in al register
    ; mov bh,0      ; initial value of bh is 0
    ; mov bl,158    ; setting foreground and background (from 0 to 255)
    ; mov cx,8      ; repeat both colour for 8 times
    ; int 10h       ; bios service for applying colours
    
    loadLow al, ah, MAX
    loadLow bl, bh, NAMELEN
    inc bl
    mul bl
    mov word ptr qOffset, ax

    lea si, amogus
    mov bx, [qOffset]
    mov dl, [si + bx]
    cmp dl, 5
    je b

    mov dl, 10
    mov ah, 02h
    int 21h

    mov ah, 01h
    int 21h
    mov bh, al

    lea si, amogus
    loadLow cl, ch, MAX

    check:
        mov dl, [si]
        add dl, 30h
        cmp bh, dl
        je match

        ; mov ah, 02h
        ; mov dl, [si]
        ; add dl, 30h
        ; int 21h

        ; inc bp
        inc si
        dec cx
        jnz check

    jmp finish

    match:
        ; mov ax, [qOffset]
        add si, [qOffset]
        mov byte ptr [si], 9

    finish:
        lea si, amogus
        add si, [qOffset]
        loadLow cl, ch, MAX
        ploop:
            mov dl, [si]
            add dl, 30h
            mov ah, 02h
            int 21h

            inc si
            dec cx
            jnz ploop
    
    ; mov ah, 02h
    ; mov dl, 10
    ; int 21h

    ; lea dx, val
    ; mov ah, 09h
    ; int 21h

    ; mov ah, 02h
    ; mov dl, 0
    ; int 21h

    b:
        mov ah, 02h
        mov dl, 'b'
        int 21h

    mov ah,4ch    ; exit function
    int 21h       ; close dos
.exit
end