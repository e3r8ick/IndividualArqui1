.data          /* the .data section is dynamically created and its addresses cannot be easily predicted */
	array_bet: .word 3  /* variable 1 in memory */
	avar_b: .word 4  /* variable 2 in memory */

.text
.global __main

__main:
	MOV R11, #17			@ Key pair number1
	MOV R12, #29            @ keY pair number2

ITSPRIME_A:
	MOV R0,R11				@ Move the first number to check
	CMP R0,#01             	@ Comparing with 01
	BEQ PRIME_A             @ If equal => prime
	CMP R0,#02             	@ Compare with 02
	BEQ PRIME_A             @ If equal => prime
	MOV R1,R0              	@ Copy the number in R1
	MOV R2,#02             	@ Initial divider

UP_A:                     
	BL DIVISION_A           @ Call for division sub-function
	CMP R8,#00             	@ Compare remainder with 0
	BEQ NOTPRIME_A        	@ If equal => not prime
	ADD R2,R2,#01          	@ If not increment divider and check
	CMP R2,R1              	@ Compare divider with the number
	BEQ PRIME_A            	@ All possible numbers are done => prime
	B UP_A                 	@ If not repeat until end

NOTPRIME_A:
	MOV R3,#0       		@ The number is not prime
	B ITSPRIME_B           	@ Jump ITSPRIME_B

PRIME_A:
	MOV R3,#1       		@ The number is prime
	B ITSPRIME_B            @ Jump ITSPRIME_B
 
DIVISION_A:                 @ Function for division operation
	MOV R8,R0              	@ Copy of data from main function
	MOV R9,R2              	@ Copy of divider from main function
	 
LOOP_A:              
	SUB R8,R8,R9           	@ Successive subtraction for division
	ADD R10,R10,#01        	@ Counter for holding the result of division
	CMP R8,R9              	@ Compares for non-zero result
	BPL LOOP_A              @ Repeats the loop if subtraction is still needed
	MOV PC,LR              	@ Return back to main function

ITSPRIME_B:
	MOV R0,R12				@ Move the second number to check
	CMP R0,#01             	@ Comparing with 01
	BEQ PRIME_B             @ If equal => prime
	CMP R0,#02            	@ Compare with 02
	BEQ PRIME_B             @ If equal => prime
	MOV R1,R0              	@ Copy the number in R1
	MOV R2,#02             	@ Initial divider

UP_B:                     
	BL DIVISION_B           @ Call for division sub-function
	CMP R8,#00             	@ Compare remainder with 0
	BEQ NOTPRIME_B        	@ If equal => not prime
	ADD R2,R2,#01          	@ If not increment divider and check
	CMP R2,R1              	@ Compare divider with the number
	BEQ PRIME_B            	@ All possible numbers are done => prime
	B UP_B                 	@ If not repeat until end

NOTPRIME_B:
	MOV R4,#0       		@ The number is not prime
	B CHECK_PRIME_A        	@ Jump CHECK_PRIME_A

PRIME_B:
	MOV R4,#1       		@ The number is prime
	B CHECK_PRIME_A        	@ Jump CHECK_PRIME_A
 
DIVISION_B:                 @ Function for division operation
	MOV R8,R0              	@ Copy of data from main function
	MOV R9,R2              	@ Copy of divider from main function
	 
LOOP_B:              
	SUB R8,R8,R9           	@ Successive subtraction for division
	ADD R10,R10,#01        	@ Counter for holding the result of division
	CMP R8,R9              	@ Compares for non-zero result
	BPL LOOP_B              @ Repeats the loop if subtraction is still needed
	MOV PC,LR              	@ Return back to main function

CHECK_PRIME_A:
	CMP R3,#1               @ To check if the first number was prime
	BEQ CHECK_PRIME_B       @ If equal => prime
	B EXIT					@ If not, exit (sistem alert)

CHECK_PRIME_B:
	CMP R4,#1               @ To check if the second number was prime
	BEQ CHECK_EQUAL		    @ If equal => prime
	B EXIT					@ If not, exit (sistem alert)

CHECK_EQUAL:
	CMP R11,R12             @ To check if the numbers are the same
	BEQ EXIT			    @ If equal => EXIT (sistem alert)
	B GENERATOR				@ Jump to the function how generates the keypair

GENERATOR:
	MUL R0,R11,R12			@ n = p*q
	SUB R1,R11,#1			@ p - 1
	SUB R2,R12,#1			@ q - 1
	MUL R3,R1,R2			@ L = (p-1)*(q-1)

ARRAY_GENERATOR:
	MOV R4,#1				@ init the array
	MOV R5,R3				@ Copy the L value to make a counter
	MOV R6,#0				@ address for save every element
	LDR R7,=adr_array_bet	@ load the address
	LDR R7,[R7]				@ load the element

ARRAY_LOOP:	
	STR R4,[R7,R6]			@ save the element array
	ADD R4,R4,#1			@ R4++
	ADD R6,R6,#4			@ Next address
	SUB R5,R5,#1			@ counter --
	CMP R5,#0				@ R5 = 0?
	BNE ARRAY_LOOP			@ loop for create the array

VERIFY:						@ Verify that e and L(n) are coprime
	MOV R5,R3				@ get L
	MOV R6,#0				@ init i =0
	MOV R9,#4				@ address offset
	LDR	R7,=adr_array_bet	@ array address
	LDR	R7,[R7]				@ array element
	MUL R8,R6,R9			@ array item append address
	LDR R4,[R7,R8]			@ load the element

GCD:						@ Determining the greatest common divisor
	CMP R4,R5     			@ if R4 > R5 
	SUBGT R4,R4,R5 			@ subtract r1 from r0 
	SUBLT R5,R5,R4 			@ else subtract r0 from R5 
	BNE GCD					@ loop


MULT_INVERSE:

EXIT:						@Finish
	bkpt

adr_array_bet: .word array_bet  /* address to var1 stored here */
adr_var_b: .word var_b  /* address to var2 stored here */