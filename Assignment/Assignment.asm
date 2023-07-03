.model small
.stack 100h
.data
    CRLF db 10, 13, '$'
    menu db "1. List inventory", 10, "2. Sell items", 10, "3. Exit", 10, 10, "Choose an operation: $"
    listInv db "1. Priority", 10, "2. Finished goods", 10, "3. Ordering", 10, "4. Need to order", 10, 10, "Choose an operation: $"
    sellItems db "bruh", 10, 10, "$"
    itemNames db "Apple", 10, "Banana", 10, "Coconut", 10, "Durian", 10, "European Pear", 10, "$"
    ; itemQuantities dw 100, 50, 70, 150, 5
    op db ?
.code

print macro string
    mov dx, offset string
    mov ah, 09h
    int 21h
endm

printChar macro char
    mov ah, 02h
    mov dl, char
    int 21h
endm

printArray macro array
    mov si, offset array

    loop_start:
        mov dl, [si]
        cmp dl, '$'
        je loop_end

        mov ah, 02h
        mov dl, [si]
        int 21h

        inc si
        jmp loop_start

    loop_end:
endm

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
        printArray itemNames
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