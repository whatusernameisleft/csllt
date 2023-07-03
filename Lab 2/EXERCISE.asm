.model small
.stack 100h
.data
    fname  db "Elisha Hu Zi Qian $"
    course db "Bachelor in Computer Science $"
    year   db "Year 2 $"
    grad   db "2024 $"
    fav    db "OODJ $"
.code

main PROC
         mov ax,@data
         mov ds,ax

         mov ah,09
         mov dx,offset fname
         int 21h

         mov ah,02
         mov dl,10
         int 21h

         mov ah,09
         mov dx,offset course
         int 21h

         mov ah,02
         mov dl,10
         int 21h

         mov ah,09
         mov dx,offset year
         int 21h

         mov ah,02
         mov dl,10
         int 21h

         mov ah,09
         mov dx,offset grad
         int 21h
         
         mov ah,02
         mov dl,10
         int 21h

         mov ah,09
         mov dx,offset fav
         int 21h

         mov ah,4ch
         int 21h
main ENDP
END MAIN