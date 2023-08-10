.model small
.stack 100h
.data
    CRLF db 13, 10, '$'
    TAB db 9, '$'
    THRESHOLD db 5
    colour db 7
    MAX db 5
    NAMELEN db 6
    HEADER db 13, 10, 13, 10, '================================', 13, 10, '     WORLD TREE FRUIT STORE     ', 13, 10, '================================', '$'
    menu db 13, 10, '1. List inventory', 13, 10, '2. Sell items', 13, 10, '3. Exit', 13, 10, 10, 'Choose an operation: $'
    listInvMenu db 13, 10, '1. Priority', 13, 10, '2. Finished goods', 13, 10, '3. Ordering', 13, 10, '4. Need to order', 13, 10, 10, 'Choose an operation: $'
    menuNote1 db '*Red means quantity under threshold$'
    menuNote2 db '*Red Highlight means under threshold and needs to be ordered$'
    itemSaleId db 13, 10, 'Enter item ID for sale: $'
    itemSaleQuantity db 13, 10, 'Enter quantity: $'
    itemSaleSuccess db 13, 10, 'Item has been sold.$'
    itemOutOfStockError db 13, 10, 'Item out of stock.$'
    itemSaleIdError db 13, 10, 'Invalid item ID.$'
    itemSaleQuantityError db 13, 10, 'Invalid item quantity.$'
    itemsColTitles db 13, 10, 'ID', 9, 'Name', 9, 9, 'Quantity', 13, 10, '$'
    items db 1, 2, 3, 4, 5
          db 'Cherry', 'Banana', 'Papaya', 'Durian', 'Orange'
          db 7, 1, 4, 5, 0
          db 0, 1, 0, 0, 0, '$'
    quantityOffset dw ?
    orderedOffset dw ?
.code
LOCALS @@

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

loadLow macro low, high, value
    mov low, value
    mov high, 0
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
    loadLow cl, ch, NAMELEN
    @@printLoop:
        call setColour
        printc [bx]
        inc bx
        dec cx
        jnz @@printLoop
    
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

    mov bx, [orderedOffset]
    mov al, [si + bx]
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
    mov colour, 7

    pop cx
    pop bx
    ret
printNotes endp

printItems proc
    prints HEADER
    prints itemsColTitles
    mov bp, 0
    lea si, items

    loadLow cl, ch, MAX
    @@printLoop:
        mov bx, [quantityOffset]
        mov al, [si + bx]
        call checkQuantity

        mov al, [si]
        call setColour
        call printInt   ;print id
        printc TAB

        loadLow bl, bh, MAX
        lea dx, items
        add dx, bx
        add dx, bp
        call printName  ;print name

        printc TAB
        printc TAB
        mov bx, [quantityOffset]
        mov al, [si + bx]
        call setColour
        call printInt

        prints CRLF
        loadLow bl, bh, NAMELEN
        add bp, bx
        inc si
        dec cx
        jnz @@printLoop
    
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

    loadLow cl, ch, MAX
    @@printLoop:
        mov bx, [quantityOffset]
        mov al, [si + bx]
        cmp al, 0
        jne @@next

        mov al, [si]
        call printInt   ;print id
        printc TAB

        loadLow bl, bh, MAX
        lea dx, items
        add dx, bx
        add dx, bp
        call printName  ;print name

        printc TAB
        printc TAB
        mov bx, [quantityOffset]
        mov al, [si + bx]
        call printInt   

        prints CRLF

    @@next:
        loadLow bl, bh, NAMELEN
        add bp, bx
        inc si
        dec cx
        jnz @@printLoop

    ret
printFinished endp

printOrdering proc
    prints HEADER
    prints itemsColTitles
    mov bp, 0
    lea si, items

    loadLow cl, ch, MAX
    @@printLoop:
        mov bx, [orderedOffset]
        mov al, [si + bx]
        cmp al, 1
        jne @@next

        mov al, [si]
        call printInt   ;print id
        printc TAB

        loadLow bl, bh, MAX
        lea dx, items
        add dx, bx
        add dx, bp
        call printName  ;print name

        printc TAB
        printc TAB
        mov bx, [quantityOffset]
        mov al, [si + bx]
        call printInt   

        prints CRLF

    @@next:
        loadLow bl, bh, NAMELEN
        add bp, bx
        inc si
        dec cx
        jnz @@printLoop

    ret
printOrdering endp

printToOrder proc
    prints HEADER
    prints itemsColTitles
    mov bp, 0
    lea si, items

    loadLow cl, ch, MAX
    @@printLoop:
        mov bx, [quantityOffset]
        mov al, [si + bx]
        cmp al, THRESHOLD
        jge @@next

        mov bx, [orderedOffset]
        mov al, [si + bx]
        cmp al, 0
        jne @@next

        mov al, [si]
        call printInt   ;print id
        printc TAB

        loadLow bl, bh, MAX
        lea dx, items
        add dx, bx
        add dx, bp
        call printName  ;print name

        printc TAB
        printc TAB
        mov bx, [quantityOffset]
        mov al, [si + bx]
        call printInt   

        prints CRLF

    @@next:
        loadLow bl, bh, NAMELEN
        add bp, bx
        inc si
        dec cx
        jnz @@printLoop

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

sellItems proc
    call printItems
    prints CRLF
    prints itemSaleId
    call getInput

    mov bl, al
    lea si, items
    loadLow cl, ch, MAX
    @@checkLoop:
        mov dl, [si]
        add dl, 30h
        cmp bl, dl
        je @@match

        inc si
        dec cx
        jnz @@checkLoop

    jmp @@idError    

    @@match:
        add si, [quantityOffset]
        mov dl, [si]
        cmp dl, 0
        je @@outOfStockError
        
        prints itemSaleQuantity
        call getInput
    
        mov bl, al
        sub bl, 31h
        mov dl, [si]
        dec dl
        sub dl, bl
        jc @@quantityError

        mov byte ptr [si], dl
        prints CRLF
        prints itemSaleSuccess

        jmp main

    @@outOfStockError:
        prints itemOutOfStockError
        jmp main

    @@idError:
        prints itemSaleIdError
        jmp main

    @@quantityError:
        prints itemSaleQuantityError
        jmp main
        
    ret
sellItems endp

init proc
    loadLow al, ah, MAX
    loadLow bl, bh, NAMELEN
    inc bl
    mul bl
    mov word ptr quantityOffset, ax

    loadLow bl, bh, MAX
    add ax, bx
    mov word ptr orderedOffset, ax
    ret
init endp

mainMenuOp proc
    call init
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
        call sellItems
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