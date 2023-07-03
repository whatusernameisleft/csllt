.model small
.stack 100h
.data
    msg db "I love assembly language $"
.code 

main proc
    mov ax,@data
    mov ds,ax

    mov dx,offset msg
    call showmess

    mov ah,4ch
    int 21h

main endp

showmess proc
    push ax
    mov ah,9
    int 21h
    pop ax
    ret
showmess endp

end main