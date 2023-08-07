.model small
.stack 100h
.data
    CRLF db 13, 10, '$'
    TAB db 9, '$'
    THRESHOLD db 5
    colour db 7
    HEADER db 13, 10, 13, 10, '================================', 13, 10, '     WORLD TREE FRUIT STORE     ', 13, 10, '================================', '$'
    menu db 13, 10, '1. List inventory', 13, 10, '2. Sell items', 13, 10, '3. Exit', 13, 10, 10, 'Choose an operation: $'
    listInvMenu db 13, 10, '1. Priority', 13, 10, '2. Finished goods', 13, 10, '3. Ordering', 13, 10, '4. Need to order', 13, 10, 10, 'Choose an operation: $'
    menuNote1 db '*Red means quantity under threshold$'
    menuNote2 db '*Red Highlight means under threshold and needs to be ordered$'
    sellItems db 'bruh$'
    itemsColTitles db 13, 10, 'ID', 9, 'Name', 9, 9, 'Quantity', 13, 10, '$'
    items db 1, 2, 3, 4, 5
          db 'Cherry', 'Banana', 'Papaya', 'Durian', 'Orange'
          db 7, 1, 4, 5, 0
          db 0, 1, 0, 0, 0, '$'
.code
LOCALS @@
LOCAL @@

prints macro string
    lea dx, string
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
    push bx
    push cx

    mov bx, dx
    mov cx, 6
    @@printLoop:
        call setColour
        printc [bx]
        inc bx
        loop @@printLoop
    
    pop cx
    pop bx
    ret
printName endp

setColour proc
    push ax
    push bx
    push cx

    mov ah, 09h
    mov bh, 0
    mov bl, colour
    mov cx, 1
    int 10h
    
    pop cx
    pop bx
    pop ax
    ret
setColour endp

checkQuantity proc
    cmp al, THRESHOLD
    jge @@aboveThreshold

    mov al, [si + 40]
    cmp al, 0
    je @@setHighlight
    mov bl, 4
    jmp @@save
    
    @@aboveThreshold:
        mov bl, 7
        jmp @@save

    @@setHighlight:
        mov bl, 64

    @@save:
        mov dl, al
        add dl, 30h
        mov colour, bl

    ret
checkQuantity endp

printNote macro note, col, chars
    LOCAL @@printColourLoop, @@printLoop, @@finished
    prints CRLF
    mov colour, col

    lea dx, note
    mov bx, dx
    mov cx, chars
    printc [bx]
    inc bx
    @@printColourLoop:
        call setColour
        printc [bx]
        inc bx
        loop @@printColourLoop
        
    @@printLoop:
        mov dl, [bx]
        cmp dl, '$'
        je @@finished

        printc [bx]
        inc bx
        jmp @@printLoop

    @@finished:
endm

printNotes proc
    push bx
    push cx

    printNote menuNote1, 4, 3
    printNote menuNote2, 64, 13

    pop cx
    pop bx
    ret
printNotes endp

printItems proc
    prints HEADER
    prints itemsColTitles
    mov bp, 0
    lea si, items

    @@printLoop:
        mov al, [si]
        cmp al, 10
        ja @@finished
        
        mov al, [si + 35]
        call checkQuantity

        mov al, [si]
        call setColour
        call printInt   ;print id
        printc TAB

        mov dx, offset items + 5
        add dx, bp
        call printName  ;print name

        printc TAB
        printc TAB
        mov al, [si + 35]
        call setColour
        call printInt

        prints CRLF
        add bp, 6
        inc si
        jmp @@printLoop

    @@finished:
        mov colour, 7
        call setColour
        printc ''
        call printNotes
        ret
printItems endp

printFinished proc
    prints HEADER
    prints itemsColTitles
    mov bp, 0
    lea si, items

    @@printLoop:
        mov al, [si]
        cmp al, 10
        ja @@finished
        
        mov al, [si + 35]
        cmp al, 0
        jne @@next

        mov al, [si]
        call printInt   ;print id
        printc TAB

        mov dx, offset items + 5
        add dx, bp
        call printName  ;print name

        printc TAB
        printc TAB
        mov al, [si + 35]
        call printInt   

        prints CRLF

        @@next:
            add bp, 6
            inc si
            jmp @@printLoop

    @@finished:
        ret
printFinished endp

printOrdering proc
    prints HEADER
    prints itemsColTitles
    mov bp, 0
    lea si, items

    @@printLoop:
        mov al, [si]
        cmp al, 10
        ja @@finished
        
        mov al, [si + 40]
        cmp al, 1
        jne @@next

        mov al, [si]
        call printInt   ;print id
        printc TAB

        mov dx, offset items + 5
        add dx, bp
        call printName  ;print name

        printc TAB
        printc TAB
        mov al, [si + 35]
        call printInt   

        prints CRLF

        @@next:
            add bp, 6
            inc si
            jmp @@printLoop

    @@finished:
        ret
printOrdering endp

printToOrder proc
    prints HEADER
    prints itemsColTitles
    mov bp, 0
    lea si, items

    @@printLoop:
        mov al, [si]
        cmp al, 6
        ja @@finished
        
        mov al, [si + 35]
        cmp al, THRESHOLD
        jge @@next

        mov al, [si + 40]
        cmp al, 0
        jne @@next

        mov al, [si]
        call printInt   ;print id
        printc TAB

        mov dx, offset items + 5
        add dx, bp
        call printName  ;print name

        printc TAB
        printc TAB
        mov al, [si + 35]
        call printInt   

        prints CRLF

        @@next:
            add bp, 6
            inc si
            jmp @@printLoop

    @@finished:
        ret
printToOrder endp

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

    jmp main

    @@m1:
        call printItems
        jmp main

    @@m2:
        call printFinished
        jmp main

    @@m3:
        call printOrdering
        jmp main

    @@m4:
        call printToOrder
        jmp main

invMenuOp endp

mainMenuOp proc
    call getInput

    cmp al, '1'
    je @@m1
    
    cmp al, '2'
    je @@m2

    cmp al, '3'
    je @@exit

    jmp main

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

mainMenuOp endp

.startup
    main:
        prints HEADER
        prints menu

        call mainMenuOp

        jmp main

.exit

end