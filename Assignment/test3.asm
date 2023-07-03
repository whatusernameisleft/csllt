.MODEL SMALL
.STACK 100h
.DATA
    strings_array db 'Apple', 0
                 db 'Banana', 0
                 db 'Orange', 0

    ints_array    dw 10
                 dw 20
                 dw 30

.CODE
.STARTUP
    mov si, offset strings_array   ; Load the address of the strings array into SI
    mov di, offset ints_array      ; Load the address of the ints array into DI
    mov cx, 3                      ; Number of elements in the map

iterate_map:
    mov ah, 09h                    ; DOS function to display string

    ; Calculate the length of the current string
    xor bx, bx                     ; Initialize BX to zero for string length calculation
    mov al, [si]                   ; Load the first character of the string into AL
    count_length:
        cmp al, 0                  ; Check if the current character is null terminator
        je print_string            ; If null terminator is found, proceed to print_string
        inc bx                     ; Move to the next character
        mov al, [si + bx]          ; Load the next character into AL
        jmp count_length           ; Jump back to count_length

    print_string:
        mov dx, si                 ; Set DX to the address of the current string
        mov cx, bx                 ; Store the length in CX
        int 21h                    ; Invoke DOS interrupt 21h

        add si, bx                 ; Move SI to the next string
        add di, 2                  ; Move DI to the next integer (assuming each integer is 2 bytes long)

        dec cx                     ; Decrement the loop counter
        jnz iterate_map            ; Jump back to iterate_map if CX is not zero

    ; Terminate the program
    mov ah, 4Ch                   ; DOS function to terminate the program
    mov al, 0                     ; Return code 0
    int 21h                       ; Invoke DOS interrupt 21h

    ; Other code
.EXIT
end
