__main:
	MOV R11, #17			@Key pair number1
	MOV R12, #29            @keY pair number2

ITSPRIME_A:
	MOV R0,R11				@Move the first number to check
	CMP R0,#01             	@Comparing with 01
	BEQ PRIME_A             @If equal => prime
	CMP R0,#02             	@Compare with 02
	BEQ PRIME_A             @If equal => prime
	MOV R1,R0              	@Copy the number in R1
	MOV R2,#02             	@Initial divider

UP_A:                     
	BL DIVISION_A           @Call for division sub-function
	CMP R8,#00             	@Compare remainder with 0
	BEQ NOTPRIME_A        	@If equal => not prime
	ADD R2,R2,#01          	@If not increment divider and check
	CMP R2,R1              	@Compare divider with the number
	BEQ PRIME_A            	@All possible numbers are done => prime
	B UP_A                 	@If not repeat until end

NOTPRIME_A:
	MOV R3,#0       		@The number is not prime
	B ITSPRIME_B           	@Jump STOP

PRIME_A:
	MOV R3,#1       		@The number is prime
	B ITSPRIME_B            @Jump STOP
 
DIVISION_A:                 @Function for division operation
	MOV R8,R0              	@Copy of data from main function
	MOV R9,R2              	@Copy of divider from main function
	 
LOOP_A:              
	SUB R8,R8,R9           	@Successive subtraction for division
	ADD R10,R10,#01        	@Counter for holding the result of division
	CMP R8,R9              	@Compares for non-zero result
	BPL LOOP_A              @Repeats the loop if subtraction is still needed
	MOV PC,LR              	@Return back to main function

ITSPRIME_B:
	MOV R0,R12				@Move the second number to check
	CMP R0,#01             	@Comparing with 01
	BEQ PRIME_B             @If equal => prime
	CMP R0,#02            	@Compare with 02
	BEQ PRIME_B             @If equal => prime
	MOV R1,R0              	@Copy the number in R1
	MOV R2,#02             	@Initial divider

UP_B:                     
	BL DIVISION_B           @Call for division sub-function
	CMP R8,#00             	@Compare remainder with 0
	BEQ NOTPRIME_B        	@If equal => not prime
	ADD R2,R2,#01          	@If not increment divider and check
	CMP R2,R1              	@Compare divider with the number
	BEQ PRIME_B            	@All possible numbers are done => prime
	B UP_B                 	@If not repeat until end

NOTPRIME_B:
	MOV R4,#0       		@The number is not prime
	B STOP                 	@Jump STOP

PRIME_B:
	MOV R4,#1       		@The number is prime

STOP:
	B EXIT                  @Jump EXIT
 
DIVISION_B:                 @Function for division operation
	MOV R8,R0              	@Copy of data from main function
	MOV R9,R2              	@Copy of divider from main function
	 
LOOP_B:              
	SUB R8,R8,R9           	@Successive subtraction for division
	ADD R10,R10,#01        	@Counter for holding the result of division
	CMP R8,R9              	@Compares for non-zero result
	BPL LOOP_B              @Repeats the loop if subtraction is still needed
	MOV PC,LR              	@Return back to main function

 
EXIT:						@Finish

