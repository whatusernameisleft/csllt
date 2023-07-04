
# Services

---

## Definition
Predefined functions which are created by computer manufacturers (e.g. Intel, AMD)

## Types

- BIOS (Basic Input/Output System)
- DOS (Disk Operating System)

## [Examples](http://spike.scu.edu.au/~barry/interrupts.html)

<dl>
    <dt>mov ah,02 (DOS)</dt> 
    <dd>Write character to stdout</dd>
    <dt>mov ah,09 (DOS)</dt>
    <dd>Write string to stdout</dd>
    <dt>mov ah,01 (DOS)</dt>
    <dd>Read character from stdin, with ECHO</dd>
    <dt>mov ah,0ah (DOS)</dt>
    <dd>Buffered Input</dd>
    <dt>mov ah,00h (BIOS)</dt>
    <dd>Character Input</dd>
</dl>

---

## How to display string on the screen

```
.model small
.stack 100h
.data                               ; data section

    msg db "Welcome to CSLLT $"     ; msg - variable name
                                    ; db - define bytes

.code

MAIN PROC
    mov ax,@data                    ; @data - address of data
    mov ds,ax                       ; moving address from ax to ds register
                                    ; ds - data segment register (stores addresses of data)

    mov ah,09                       ; string display function
    mov dx,offset msg               ; dx - data register
                                    ; offset - read/access character by character
    int 21h                         ; open dos
    
    mov ah,4ch                      ; exit function
    int 21h                         ; close dos
MAIN ENDP
END MAIN
```

## How to display string on the screen (Alternative)

```
.model small
.stack 100h
.data                               ; data section

    msg db "Welcome to CSLLT $"     ; msg - variable name
                                    ; db - define bytes

.code

MAIN PROC
    mov ax,@data                    ; @data - address of data
    mov ds,ax                       ; moving address from ax to ds register
                                    ; ds - data segment register (stores addresses of data)

    mov ah,09                       ; string display function
    LEA dx,msg                      ; lea - load effective address
    int 21h                         ; open dos
    
    mov ah,4ch                      ; exit function
    int 21h                         ; close dos
MAIN ENDP
END MAIN
```