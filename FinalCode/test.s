@openat call
     @syscall's arguments
     mov x0, -100
     ldr x1, pfname_addr
     mov x2, 2
     mov x8, 56 @syscall x1__NR_openat
     svc #0
     mov x10, x0

     ldr x1, p_addr
     mov x2, 16
     mov x8, 63 @syscall __NR_read
     svc #0

     mov x0, x10
     mov x8, 57 @syscall __NR_close
     svc #0