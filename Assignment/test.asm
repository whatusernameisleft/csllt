.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter a number:', '$'
    MSG2 DB 'The number is greater than 5', '$'
    MSG3 DB 'The number is less than or equal to 5', '$'
    NUM1 Db ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, MSG1 ; display message to enter a number
    MOV AH, 9H
    INT 21H

    MOV AH, 1H ; read character from keyboard
    INT 21H

    SUB AL, 30H ; convert character to number

    CMP AL, 5 ; compare with the number 5

    JG GREATER ; jump if greater than 5

    LEA DX, MSG3 ; display message if less than or equal to 5
    MOV AH, 9H ; display message on screen
    int 21h
    JMP EXIT

GREATER:
    LEA DX, MSG2 ; display message if greater than 5
    MOV AH, 9H ; display message on screen
    int 21h

EXIT:
    MOV AH, 4CH ; return control to DOS
    INT 21H
MAIN ENDP
END MAIN