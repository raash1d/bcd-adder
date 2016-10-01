# 8-bit Binary Coded Decimal (BCD) adder

In this experiment, an 8-bit Binary-Coded-Decimal (BCD) Adder was designed, and then implemented and tested using Verilog HDL. An 8-Bit adder is used to add two 8-Bit words, or two bytes, of binary data. BCD is a standard form to put binary information in, where 4 bits, or a nibble, represents one number in decimal, up to the number 9. For example, the decimal number 19 would be represented by two nibbles, since there is a decimal number in the 1’s place, and another decimal number in the 10’s place. The first nibble, or most significant nibble, would be the 4-bit representation of 1, and then the least significant nibble, would be the 4-bit representation of 9. When combined, these two nibbles would represent 1 and 9, or the decimal number 19.

Firstly, the most vital component was designed and then implemented in Verilog, the Full-Adder. The circuit representation of the Full-Adder can be seen in Figure 1.

![Full-Adder Circuit](bcd-adder/images/figure1.tif "Full-Adder Circuit")

Figure 1. Full-Adder Circuit with Verilog I/O net names

To add two bytes of information, two 4-bit BCD adders were cascaded, where the carry-out of the least significant adder was the carry-in to the more significant adder. A 4-bit BCD adder is designed using two 4-bit adders, with added carry-out logic. The second 4-bit adder is used to perform a 2’s complement to make sure the sum is in BCD form.

The 4-bit adder is designed using 4 Full Adders. Each less significant Full Adder provides the carry-in to the more significant Full Adder next to it. Although sometimes this type of adder is considered a parallel 4-bit adder, really it is a ripple adder, since the next bit doesn’t come at the same time as the previous bit, but with some tiny added delay later. The 4-bit adder can be seen in Figure 2.

When the 4-bit adder was designed, the 4-bit BCD adder was designed, and then cascaded with another 4-bit BCD adder. The final design can be seen in Figure 3. The Carry-out of the more significant adder will be the least significant bit of the third output nibble, which is needed for an output sum of anything over 99. To keep with BCD form, the three dummy bits of logic 0 are added to complete the third nibble.

## Source Code Design:
### Submodules:
We broke down the 8-bit BCD adder to basic modules. The 8-bit adder is made up of two 4-bit BCD adders. Each 4-bit BCD adder is made up of two 4-bit Full Adders, 2 AND gates and 1 OR gate. Verilog has inbuilt functions for basic gates i.e AND, OR, XOR etc. hence we created a 1-bit Full Adder using those. We connected four of the 1-bit Full Adders in series to create the 4-bit full adder.

Creating these submodules gave us the flexibility of instantiating basic designs in upper-levels. Also, if there is an error in the basic design (1-bit full adder) but the upper levels (4-bit full adder) are connected properly, we just needed to focus on solving the error in the 1-bit full adder and the solution cascaded all the way up to the BCD adder. By creating submodules, the whole code became maintainable and manageable.

### Hierarchy:
It was quite obvious that a 4-bit adder would be made up using 1-bit adders, hence that hierarchy was not a problem. Similarly, a 4-bit BCD adder required two 4-bit adders with a logic to convert binary output to BCD output.  Figure 4 below shows the hierarchy that we used.

Figure 4. Source code hierarchy

### Adder Design:
When we provide two 4-bit BCD numbers to the 4-bit adders, the output exceeds the BCD range, or called BCD representation. We want to output also in BCD. But when we directly take the output of the 4-bit adder then it will be an invalid representation. Therefore we need some mechanism through which we can change the output of the 4 bit adder into a valid BCD representation. If you carefully see, that up to when the sum is 9, the BCD representation is same as the binary representation. When the sum exceed the 9, the following condition occur; Either the carry bit is 1, the sum is 1010, or the sum is 1100. For the numbers which does not satisfy the condition of BCD, 6 is added. When the sum is 01010 the BCD representation is obtained by adding 6, so the representation in BCD is 1 0000. The condition when 6 is to be added is

`cout_temp(i+1) = cout_temp(i) + sum_temp(3).sum_temp(2) + sum_temp(3).sum_temp(1);`

## Testbench Justification:
In order to verify the functionality of the design the test bench was set up to increment both of the 2-digit input values from 0 to 99, executing every possible combination of both inputs relative to the other. To accomplish this, nested for loops were employed to increment the values based on their place value. The one’s place value of each was increased from 0 to 9, at which point the ten’s place would increment by one and the counter for the one’s place would reset. For input B, this happened 99 times for every incrementing value of input A. At the end of each iteration the sum was calculated in software (non-gate-level) and this sum was compared to the actual output sum of the decimal equivalent of the BCD output of the adder circuit. If the two are not equal then an error statement is printed, indicating a fault.

19,604 test cases were evaluated in this testbench. 9,801 of those values are all the possible combinations of the inputs. Then, each of these cases was tested with and without an input carry (which would simply increase the final value by 1).

Figure 5 and 6 shows the beginning of these tests, with all inputs initially set to zero, and Figures 6 and 7 show the maximum values of these tests with the carry values set to 0 and 1 respectively. Note that in Figure 6 the end of the first test transitions into the start of the second by resetting the inputs to zero and adding the carry bit. One final test (the 19,603rd condition) tests the response of the design when both of the inputs have values greater than 9 (each is set to 10). For the 19,604th case just the one’s place value of each input A and B was set to 10, and the ten’s place remained zero. For both of these final cases, the adder outputs a technically correct value but the way the value is represented is not correct because it is no longer in a decimal form. However, if you consider all outputs being equal to 10 (A = B = 10\*10+10 = 110), the sum would be 220. The adder outputs a hex value of 1BA, which is equal to 1\*100+11*10+10 which is equal to 220.

Similarly for the case of the one’s place of the inputs equaling 10 (A = B = 0\*10+10 = 10), the final sum is 20. The adder outputs a hex value of 1A, which is equal to 1*10+10 = 20. The outputs of these two final tests can be observed in Figure 7. The flaw in these cases that makes them fault conditions is because they are no longer in binary coded decimal and the only way to calculate the correct answer is to mathematically work out the numbers and know to carry any value greater than 9 to the next place value. Since the user would be expecting a BCD output, the presence of alphabetical characters in an answer or input term makes it invalid.

Using this many test cases is enough to prove the functionality of the adder circuit because every possible input capable of being represented with two 2-digit BCD values is tested. The special cases verify that a non-BCD output is generated when any value greater than 9 is used as an input. Running the source code and testbench provided yields no errors and consistently produces accurate outputs for the range of inputs intended by the design.