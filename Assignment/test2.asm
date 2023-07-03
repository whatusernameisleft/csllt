.MODEL SMALL
.STACK 100h
.DATA
    ; Define a string array.
    string_array DB 'Hello', 'World', '$'

.CODE
.STARTUP

; Load the offset of string_array into SI.
MOV SI, OFFSET string_array

; Loop through the array and display each element.
bruh:
    MOV AL, [SI]
    CMP AL, '$'
    JE EXIT
    MOV AH, 09h
    INT 21h
    INC SI
    JMP bruh

EXIT:
    ; Exit the program.
    MOV AH, 4Ch
    INT 21h

.exit
end