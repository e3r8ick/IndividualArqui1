__main:
	 MOV R0,#12             @Number to check
	 CMP R0,#01             @Comparing with 0
	 BEQ PRIME              @If equal => prime
	 CMP R0,#02             @Compare with 02
	 BEQ PRIME              @If equal => prime
	 MOV R1,R0              @Copy the number in R1
	 MOV R2,#02             @Initial divider

UP:                     
	 BL DIVISION            @Call for division sub-function
	 CMP R8,#00             @Compare remainder with 0
	 BEQ NOTPRIME           @If equal => not prime
	 ADD R2,R2,#01          @If not increment divider and check
	 CMP R2,R1              @Compare divider with the number
	 BEQ PRIME              @All possible numbers are done => prime
	 B UP                   @If not repeat until end

NOTPRIME: 
	 MOV R3,#0              @The number is not prime
	 B STOP                 @Jump STOP

PRIME: 
	 MOV R3,#1              @The number is prime

STOP:
	B EXIT                  @Jump EXIT

DIVISION:                    @Function for division operation
	 MOV R8,R0              @Copy of data from main function
	 MOV R9,R2              @Copy of divider from main function
     
LOOP:                     
	 SUB R8,R8,R9           @Successive subtraction for division
	 ADD R10,R10,#01        @Counter for holding the result of division
	 CMP R8,R9              @Compares for non-zero result
	 BPL LOOP               @Repeats the loop if subtraction is still needed
	 MOV PC,LR              @Return back to main function

EXIT:
	END					    @End the function
