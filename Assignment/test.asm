.model small
.stack 100h
.data
    valid db 13, 10, "Number in range$"
    invalid db 13, 10, "Number not in range$"
.code

print macro string
    lea dx, string
    mov ah, 09h
    int 21h
endm

.startup
    mov ah, 01h
    int 21h
    
    mov bl, al
    sub bl, 31h
    mov dl, 9
    sub dl, bl
    jc error

    mov dl, 4
    add al, dl
    sub al, 30h
    mov bl, 10
    cmp al, bl
    jge error

    fine:
        print valid
        jmp finish

    error:
        print invalid

    finish:
        mov ah, 4ch
        int 21h
.exit
end