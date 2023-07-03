.model small
.stack 100h
.data
    CRLF db 13,10,'$'
    menu db "1. First Name", 10, "2. Course Name", 10, "3. Exit Program", 10, 10, "Choose an operation: $"
    fname db "Elisha $"
    cname db "Bachelor of Computer Science $"
.code

print macro string
    mov dx,offset string
    mov ah,9
    int 21h
endm

printRes proc
    push ax
    cmp al,'1'
    je one

    cmp al,'2'
    je two

    pop ax
    ret
    
    one:
        print fname
        print crlf
        ret

    two:
        print cname
        print crlf
        ret
    
printRes endp

.startup

    ; print menu
    print menu
    mov ah,01h
    mov bl,al
    int 21h

    print crlf

    call printRes

    ; end
    mov ah,4ch
    int 21h

.exit
end