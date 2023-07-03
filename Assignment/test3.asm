.MODEL SMALL
.STACK 100h
.DATA
    strings_array db 'Hello$', 0
                 db 'World$', 0
                 db 'Example$', 0

.CODE
.STARTUP
    mov si, offset strings_array   ; Load the address of the array into SI

    print_strings:
        mov ah, 09h                 ; DOS function to display string
        mov dx, si                  ; Set DX to the address of the current string
        int 21h                     ; Invoke DOS interrupt 21h

        add si, 7                   ; Move to the next string (including the null terminator)
        cmp byte ptr [si], 0        ; Check if the current byte is null (end of strings)
        jne print_strings           ; Jump back to print_strings if not null

    ; Other code
.EXIT
end
