# LMC

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
- Independent of Data and Address
- Computer Functional Organisation

## Types of Instructions
- 1: Addition
- 2: Subtraction
- 3: Store
- 4: Nothing
- 5: Load
- 6: Branch Unconditionally
- 7: Branch on Zero
- 8: Branch on Zero or Positive
- 0: Stop
- 901: Input
- 902: Output

## Exercise

### Show bigger number

```
00  901     Input 1
01	390     Store in 90
02	901     Input 2
03  391     Store in 91
04	290     Subtract 90
05	808     If positive jump to 8
06	590     Load 90
07  609     Jump to 9
08	591     Load 91
09	902     Output
10	000     Stop
```