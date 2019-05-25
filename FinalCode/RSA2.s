.data          /* the .data section is dynamically created and its addresses cannot be easily predicted */
	array_bet: .word 3  /* variable 1 in memory */
	message: .word 4  /* variable 2 in memory */

.text
.global __main

__main:
	MOV R11, #11			@ p
	MOV R12, #17            @ q

EXIT:						@Finish
	bkpt

adr_array_bet: .word array_bet  /* address to var1 stored here */
adr_message: .word message  /* address to var2 stored here */