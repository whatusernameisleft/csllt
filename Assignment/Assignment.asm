.model small
.stack 100h
.data
    CRLF db 13, 10, '$'
    TAB db 9, '$'
    HEADER db 13, 10, 13, 10, '================================', 13, 10, '     WORLD TREE FRUIT STORE     ', 13, 10, '================================', '$'
    menu db 13, 10, '1. List inventory', 13, 10, '2. Sell items', 13, 10, '3. Exit', 13, 10, 10, 'Choose an operation: $'
    listInvMenu db 13, 10, '1. Priority', 13, 10, '2. Finished goods', 13, 10, '3. Ordering', 13, 10, '4. Need to order', 13, 10, 10, 'Choose an operation: $'
    sellItems db 'bruh$'
    itemsColTitles db 13, 10, 'ID', 9, 'Name', 9, 9, 'Quantity', 13, 10, '$'
    items db 1, 2, 3, 4, 5
          db 'Cherry', 'Banana', 'Papaya', 'Durian', 'Orange'
          db 7, 3, 3, 5, 6, '$'
.code
LOCALS @@

prints macro string
    mov dx, offset string
    mov ah, 09h
    int 21h
endm

printc macro char
    mov dl, char
    mov ah, 02h
    int 21h
endm

getInput proc
    mov ah, 01h
    int 21h
    ret
getInput endp

printInt proc
    mov dl, al
    add dl, 30h
    mov ah, 02h
    int 21h
    ret
printInt endp

printName proc
    push ax
    push bx
    push cx

    mov bx, dx
    mov cx, 6
    @@print_loop:
        mov dl, [bx]
        int 21h
        inc bx
        loop @@print_loop
    
    pop cx
    pop bx
    pop ax
    ret
printName endp

printItems proc
    mov bp, 0
    lea si, items

    @@print_loop:
        mov al, [si]
        cmp al, 10
        ja @@finished

        call printInt
        printc TAB

        mov dx, offset items + 5
        add dx, bp
        call printName

        printc TAB
        printc TAB
        mov al, [si + 35]
        call printInt

        prints CRLF
        add bp, 6
        inc si
        jmp @@print_loop

    @@finished:
        ret
printItems endp

invMenuOp proc
    call getInput

    cmp al, '1'
    je @@m1

    cmp al, '2'
    je @@m2

    cmp al, '3'
    je @@m3

    cmp al, '4'
    je @@m4

    @@m1:
        prints HEADER
        prints itemsColTitles
        call printItems
        jmp main

    @@m2:
        jmp main

    @@m3:
        jmp main

    @@m4:
        jmp main

invMenuOp endp

chooseOp proc
    call getInput

    cmp al, '1'
    je @@m1
    
    cmp al, '2'
    je @@m2

    cmp al, '3'
    je @@exit

    @@m1:
        prints HEADER
        prints listInvMenu
        call invMenuOp

    @@m2:
        prints HEADER
        prints sellItems
        jmp main

    @@exit:
        mov ah, 4ch
        int 21h

chooseOp endp

.startup
    main:
        prints HEADER
        prints menu

        call chooseOp

        jmp main

.exit

end