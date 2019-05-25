.data          /* the .data section is dynamically created and its addresses cannot be easily predicted */
	array_bet: .word 3  /* variable 1 in memory */
    pfname: .asciz "params.txt"
@openat call
     @syscall's arguments
     mov R0, #100
     ldr R1, pfname_addr
     mov R2, #2
     mov R8, #56 @syscall R1__NR_openat
     svc #0
     mov R10, R0

     ldr R1, p_addr
     mov R2, #16
     mov R8, #63 @syscall __NR_read
     svc #0

     mov R0, R10
     mov R8, #57 @syscall __NR_close
     svc #0

adr_array_bet: .word array_bet  /* address to var1 stored here */
pfname_addr: .word pfname  /* address to var1 stored here */