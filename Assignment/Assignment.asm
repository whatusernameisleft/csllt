.model small
.stack 100h
.data
    CRLF db 10, 13, '$'
    menu db "1. List inventory", 10, "2. Sell items", 10, "3. Exit", 10, 10, "Choose an operation: $"
    listInv db "1. Priority", 10, "2. Finished goods", 10, "3. Ordering", 10, "4. Need to order", 10, 10, "Choose an operation: $"
    sellItems db "bruh", 10, 10, "$"
    itemNames db "Cherry", 0
              db "Banana", 0
              db "Papaya", 0
              db "Durian", 0
              db "Orange", 0
    ; itemQuantities dw 100, 50, 70, 150, 5
    op db ?
.code

print macro string
    mov dx, offset string
    mov ah, 09h
    int 21h
endm

printItems proc
     mov si, offset itemNames ; Load the offset of the strings array into SI register

    print_loop:
        mov ah, 09h
        mov dx, si
        int 21h

        add si, 7
        cmp byte [si], 0
        jne print_loop
    ret
printItems endp

mainMenu proc
    cmp op, 1
    je m1
    
    cmp op, 2
    je m2

    cmp op, 3
    je close

    m1:
        print listInv
        jmp m0

    m2:
        call printItems
        jmp m0
    
    close:
        mov ah, 4ch
        int 21h
        
mainMenu endp

.startup
    m0:
        print CRLF
        print menu

        mov ah, 01h
        int 21h

        sub al, 30h
        mov op, al

        print CRLF

        call mainMenu

        jmp m0

.exit

end