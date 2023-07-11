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

### Calculate area of circle

```
00  901     Input decrement number (1)
01  399     Store in 99
02  901     Input PI (3)
03  390     Store in 90
04  901     Input r
05  391     Store r (Read-only)
06  392     Store r (Loop count)
07  715     Jump to 15 if 0
08  550     Load 50 (r*r result)
09  191     Add 91 (r)
10  350     Store back into 50 (Result)
11  592     Load 92 (Loop count)
12  299     Minus 99 (Decrement)
13  392     Store back into 92 (Loop count)
14  807     Jump to 7 if positive
15  590     Load 90 (r)
16  724     Jump to 24 if 0
17  551     Load 51 (Final result)
18  150     Add 50 (r*r)
19  351     Store back into 51 (Final result)
20  590     Load 90 (r)
21  299     Minus 99 (Decrement)
22  390     Store back into 90 (r)
23  816     Jump to 16 if positive
24  551     Load 51 (Final result)
25  902     Output
26  000     End
```