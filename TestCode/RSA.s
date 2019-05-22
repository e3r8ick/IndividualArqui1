.data          /* the .data section is dynamically created and its addresses cannot be easily predicted */
	var_a: .word 3  /* variable 1 in memory */
	var_b: .word 4  /* variable 2 in memory */

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
	LDR R5,=adr_var_a		@ init the array
	LDR R6,[R5]				@ init the array
	STR R4,[R5]				@ save register
	STR R4,[R6]				@ save register
	LDR R7,=adr_var_a		@ get register

EXIT:						@Finish
	bkpt

adr_var_a: .word var_a  /* address to var1 stored here */
adr_var_b: .word var_b  /* address to var2 stored here */