.model small
.stack 100h
.data
    crlf db 13,10,'$'
    msg1 db "I love assembly language $"
    msg2 db "I think I love assembly language $"
.code

print macro string
    lea dx,string
    mov ah,9
    int 21h
endm

.startup
    print msg1
    print crlf
    print msg2

    mov ah,4ch
    int 21h
.exit
end