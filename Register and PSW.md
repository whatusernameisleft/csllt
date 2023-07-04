# Register and PSW

---

## Keywords

- PSW: Program Status Word

## Addressing Modes in 8086

<dl>
    <dt>Register Mode</dt>
    <dd>
        Source and destination are registers<br>
        mov dx,ax
    </dd>
    <dt>Immediate Mode</dt> 
    <dd>
        Destination must be register, source immediately value<br>
        mov ax,2000
    </dd>
    <dt>Displacement/Direct Mode</dt>
    <dd>
        Effective address is directly given in the instruction as displacement ([] around source)<br>
        mov ax,[2000]
    </dd>
    <dt>Register Indirect Mode</dt>
    <dd>
        Effective address is in SI, DI, or BX<br>
        mov ax,[si]<br>
        mov ax,[di]<br>
        mov ax,[bx]
    </dd>
    <dt>Based Indexed Mode</dt>
    <dd>
        Effective address is sum of base register and index register<br>
        Base Registers: BX, BP<br>
        Index Registers: SI, DI<br>
        mov al,[bx + si]
    </dd>
    <dt>Indexed Mode</dt>
    <dd>
        Effective address is sum of index register and displacement<br>
        mov ax,[si + 300]
    </dd>
    <dt>Based Mode</dt>
    <dd>
        Effective adress is sum of base register and displacement<br>
        mov bx,[bp + 0100]
    </dd>
    <dt>Based Indexed Displacement Mode</dt>
    <dd>
        Effective address is sum of index register, base register, and displacement<br>
        mov al,[SI + BP + 200]
    </dd>
    <dt>String Mode</dt>
    <dd>movs b</dd>
    <dt>Input/Output Mode</dt>
    <dd>
        Related with input and output operations<br>
        in a,45<br>
        out a,50
    </dd>
    <dt>Relative Mode</dt>
    <dd>
        Effective address is calculated with reference to instruction pointer<br>
        jnz 8 bit address<br>
        ip = ip + 8 bit address
    </dd>
</dl>