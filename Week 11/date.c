#include <stdio.h>
#include <conio.h>

int main 
{
    int y;
    char m, d, w;

    while (!kbhit()) 
    {
        asm {   mov ah, 2ah
                int 21h
                mov y, cx
                mov m, dh
                mov d, dl
                mov w, al
        }

        gotoxy(1, 1);
        printf("Year: %3d\n", y);
        printf("Month: %3d\n", m);
        printf("Day: %3d\n", d);
        printf("Day of the week: %3d", w);
    }   

    return 0;
}