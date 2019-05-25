.data          /* the .data section is dynamically created and its addresses cannot be easily predicted */
	array_bet: .word 3  /* variable 1 in memory */
	message: .word 4  /* variable 2 in memory */

.text
.global __main

__main:
	MOV R11, #11			@ p
	MOV R12, #17            @ q

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
	LDR R4,[R7,R8]			@ load the element e

GCD:						@ Determining the greatest common divisor
	CMP R4,R5     			@ if R4 > R5 
	SUBGT R4,R4,R5 			@ subtract r1 from r0 
	SUBLT R5,R5,R4 			@ else subtract r0 from R5 
	BNE GCD					@ loop


MULT_INVERSE:
	MOV R5,#0				@ d = 0
	MOV R6,#0				@ x1 = 0
	MOV R7,#1				@ x2 = 1
	MOV R8,#1				@ y1 = 1
	MOV R9,R3				@ temp_L = L

MULT_CHECK:	
	CMP R4,#0				@ e > 0
	BEQ MULT_RETURN

DIVISION:
	MOV R1,R9   			@ divide R1
	MOV R2,R4     			@ by R2
	MOV R10,#0     			@ initialise counter

DIVISION_AUX:
	SUBS R1,R1,R2  			@ temp_L/e
	ADD R10,R10,#1  		@ add 1 to counter,
	BHI DIVISION_AUX  		@ branch to start of Answer now in R0=3

MULT_AUX:
	MUL R1,R10,R4			@ temp1 * e
	SUB R2,R9,R1			@ temp2 = temp_L - temp1 * e
	MOV R9,R4				@ temp_L = e
	MOV R4,R2				@ e = temp2
	MUL R1,R10,R6			@ temp1* x1
	SUB R2,R7,R1			@ x = x2- temp1* x1
	MUL R1,R10,R8			@ temp1 * y1
	SUB R1,R7,R1			@ y = d - temp1 * y1
	MOV R7,R6				@ x2 = x1
	MOV R6,R6				@ x1 = x
	MOV R5,R8				@ d = y1
	MOV R8,R1				@ y1 = y
	B MULT_CHECK

IT_IS:
	ADD R10,R5,R3			@ d + L
	B DEF_VALUES

MULT_RETURN:
	CMP R4,#1				@ L == 1?
	BEQ IT_IS

DEF_VALUES:					@ R0 = n
	MOV R1,R9				@ e
	MOV R2,R10				@ d
	ADD R2,R2,#1			@ d

ENCRYPT:
	MOV R3,#38				@ Message = 38

POW:
    MOV R4,R3           	@ number to pow (a)
    MOV R5,R3           	@ number to pow (a)
    MOV R6,R1           	@ the pow (b)
    CMP R6,#1           	@ if pow = 1
    BEQ DIVISION_MOD

POW_AUX:
    MUL R4,R5,R4       	 	@ x*x (a^b)
    SUB R6,R6,#1        	@ i--
    CMP R6,#1           	@ i == 1
    BNE POW_AUX         	@ loot


DIVISION_MOD:				@ x - (n*int(x/n))
	MOV R7,R4   			@ x
	MOV R8,R0     			@ n
	MOV R10,#0     			@ initialise counter

DIVISION_AUX_MOD:
	SUBS R7,R7,R8  			@ temp_L/e
	ADD R10,R10,#1  		@ add 1 to counter,
	BHI DIVISION_AUX_MOD  	@ branch to start of Answer now in R0=3 

MOD:
	MUL R9,R8,R10			@ n*int(x/n)
	SUB R9,R4,R9			@ x - (n*int(x/n))

EXIT:						@Finish
	bkpt

adr_array_bet: .word array_bet  /* address to var1 stored here */
adr_message: .word message  /* address to var2 stored here */