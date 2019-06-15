.data          /* the .data section is dynamically created and its addresses cannot be easily predicted */
    pfname: .asciz "params.txt"/* address to var1 stored here */
    p: .asciz "params.txt"/* address to var1 stored here */

@openat call
     @syscall's arguments
     mov R0, #100
     ldr R7, =pfname_addr
     ldr R1, [R7]
     mov R2, #2
     mov R8, #56 @syscall R1__NR_openat
     svc #0
     mov R10, R0

     ldr R7, =p_addr
     ldr R1, [R7]
     mov R2, #16
     mov R8, #63 @syscall __NR_read
     svc #0

     mov R0, R10
     mov R8, #57 @syscall __NR_close
     svc #0

p_addr: .word p  /* address to var1 stored here */
pfname_addr: .word pfname  /* address to var1 stored here */