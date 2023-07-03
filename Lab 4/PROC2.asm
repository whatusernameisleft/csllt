.model small
.stack 100h
.data
    fname db "Elisha$"
    lname db "Hu$"
.code 

print macro string
    mov ah,09
    mov dx,offset string
    int 21h

    mov ah,02
    mov dl,10
    int 21h
endm

.startup                ; main proc
    jmp l2              ; label name

    l1:
        print fname
        ; mov ah,02       ; character display function
        ; mov dl,'*'      ; dl - data register (low bit)
        ; int 21h         ; open dos

.exit                   ; main endp

mov ah,4ch              ; exit function
int 21h                 ; exit dos

sub2 proc               ; sub2 is a user-defined procedure
l2:
    print lname
    jmp l1
    ret
sub2 endp

end