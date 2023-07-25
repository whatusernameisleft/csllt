.model small
.stack 100h
.data
    CRLF db 13, 10, '$'
    menu db '1. List inventory', 13, 10, '2. Sell items', 13, 10, '3. Exit', 13, 10, 10, 'Choose an operation: $'
    listInv db '1. Priority', 13, 10, '2. Finished goods', 13, 10, '3. Ordering', 13, 10, '4. Need to order', 13, 10, 10, 'Choose an operation: $'
    sellItems db 'bruh$'
    items dw 1, 2, 3, 4, 5
          db 'Cherry', 'Banana', 'Papaya', 'Durian', 'Orange'
          dw 7, 3, 3, 5, 6, '$'
.code

print macro string
    mov dx, offset string
    mov ah, 09h
    int 21h
endm

printInt proc
    ; add dl, 30h
    ; mov ah, 02h
    ; int 21h


    mov bx, 10
    mov cx, 0
    loop1:
        xor dx, dx
        div bx
        add dl, 30h
        push dx
        inc cx
        cmp ax, 0
        jne loop1
    
    loop2:
        pop dx
        mov ah, 02h
        int 21h
        dec cx
        cmp cx, 0
        jne loop2
        
    ret

printInt endp

printItems proc
    mov bp, 0
    lea si, items

    print_loop:
        mov ax, [si]
        cmp ax, 10
        ja finished

        call printInt
    finished:
        ret
printItems endp

chooseOp proc
    mov ah, 01h
    int 21h

    cmp al, '1'
    je m1
    
    cmp al, '2'
    je m2

    cmp al, '3'
    je exit

    m1:
        print CRLF
        print listInv
        jmp m0

    m2:
        call printItems
        jmp m0

    exit:
        mov ah, 4ch
        int 21h

chooseOp endp



.startup
    m0:
        print CRLF
        print menu

        call chooseOp

        jmp m0

.exit

end