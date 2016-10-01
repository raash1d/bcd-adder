# 8-Bit BCD Adder
An 8-Bit adder is used to add two 8-Bit words, or two bytes, of binary data. BCD is a standard form to put binary information in, where 4 bits, or a nibble, represents one number in decimal, up to the number 9.
- ___For example:___ 
    - The decimal number 19 is be represented by two nibbles.
    - The first nibble, or most significant nibble, is the 4-bit representation of 1
    - The second nibble, or the least significant nibble, is the 4-bit representation of 9.
    - When combined, these two nibbles would represent 1 and 9, or the decimal number 19.
    - `19 = 0001 1001` (BCD representation)

## Language used
- ___Verilog:___ C like HDL is easier to comprehend and saves design time since the syntax is more concise that VHDL

## Tools used
- ___Cadence NCSim:___ To compile and check logic design

## Group members
1. Jonathan Frey – Group Lead
2. William Nitsch – Testbench Coder
3. Raashid Ansari – Source Coder
