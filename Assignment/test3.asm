.MODEL SMALL
.STACK 100h
.DATA
    arr db 'string1',0dh,0ah,'string2',0dh,0ah,'string3',0dh,0ah,'$'
.CODE
.startup

    lea si,arr

    next:
        mov ah,09h
        lea dx,[si]
        int 21h

        inc si
        cmp byte ptr [si], '$'
        jne next

    mov ah,4ch
    int 21h
END