.model small
.stack 100h
.data
    crlf db 13,10,'$'
    msg1 db "I love assembly language $"
    msg2 db "I think I love assembly language $"
.code

.startup
    lea dx,msg1
    mov ah,9
    int 21h
    
    lea dx,crlf
    mov ah,9
    int 21h
    
    lea dx,msg2
    mov ah,9
    int 21h

    mov ah,4ch
    int 21h
.exit
end