@openat call
     @syscall's arguments
     mov R0, -100
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