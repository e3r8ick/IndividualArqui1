.data          /* the .data section is dynamically created and its addresses cannot be easily predicted */
	array_bet: .word 3  /* variable 1 in memory */
	message: .word 4  /* variable 2 in memory */

.text
.global __main

__main:
	MOV R0, #11			   @ e 
	MOV R1, #17            @ n
	MOV R2, #17            @ d
	MOV R3, #17            @ message

POW:
    MOV R4,R3           	@ number to pow (a)
    MOV R5,R3           	@ number to pow (a)
    MOV R6,R0           	@ the pow (b)
    CMP R6,#1           	@ if pow = 1
    BEQ DIVISION_MOD

POW_AUX:
    MUL R4,R5,R4       	 	@ x*x (a^b)
    SUB R6,R6,#1        	@ i--
    CMP R6,#1           	@ i == 1
    BNE POW_AUX         	@ loot

EXIT:						@Finish
	bkpt

adr_array_bet: .word array_bet  /* address to var1 stored here */
adr_message: .word message  /* address to var2 stored here */