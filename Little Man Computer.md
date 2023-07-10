# LMC

---

## Little Man Computer

<dl>
<dt>Processor</dt>
<dd>Understand how processor handles instructions</dd>
</dl>

## OPCODE and Operand

- AL (Arithmetic)
- Hand Counter / PC
- Memory: 100
- Address 00 to 99

## Von-Neumann Guidelines

- Stored Program Concept
- Linear Memory Addressing
- Sequential Process of Instruction
- Independence of Data and Address
- Computer Functional Organisation

## Types of Instructions
- 1 (ADD): Addition
- 2 (SUB): Subtraction
- 3 (STA): Store
- 4: Nothing
- 5 (LDA): Load
- 6 (BRA): Branch Unconditionally
- 7 (BRZ): Branch on Zero
- 8 (BRP): Branch on Zero or Positive
- 000 (HLT): Stop
- 901 (INP): Input
- 902 (OUT): Output

---

## Exercise

### Show bigger number

```
00  901     First input
01	390     Store in 90
02	901     Second input
03  391     Store in 91
04	290     Subtract 90
05	808     If positive jump to 8
06	590     Load 90
07  609     Jump to 9
08	591     Load 91
09	902     Output
10	000     Stop
```

### Calculate Perimeter of Rectangle

```
00  901     First input
01  390     Store in 90
02  901     Second input
03  190     Add 90
04  391     Store in 91
05  191     Add 91
06  902     Output
07  000     Stop
```

### Write Mnemonic code and fetch/execute cycle for all given instructions

Indicate any register changes. Assume program has been reset. Inputs are 5 and 7.

#### Given
```
00  901
01  312
02  901
03  313
04  212
05  809
06  512
07  902
08  611
09  513
10  902
11  000
```

#### Mnemonic Code
```
00  INP
01  STA 12
02  INP
03  STA 13
04  SUB 12
05  BRP 09
06  LDA 12
07  OUT
08  BRA 11
09  LDA 13
10  OUT
11  HLT
```