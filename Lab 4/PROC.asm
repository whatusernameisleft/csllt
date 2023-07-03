.model small
.stack 100h
.code 

.startup                ; main proc
    jmp l2              ; label name

    l1:
        mov ah,02       ; character display function
        mov dl,'*'      ; dl - data register (low bit)
        int 21h         ; open dos

.exit                   ; main endp

mov ah,4ch              ; exit function
int 21h                 ; exit dos

sub2 proc               ; sub2 is a user-defined procedure
l2:
    jmp l1
    ret
sub2 endp

end