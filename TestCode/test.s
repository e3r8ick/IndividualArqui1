.text
.global gcd
gcd:
    mov r0, #17
    mov r1, #29
    cmp r0, r1     
    subgt r0, r0, r1 
    sublt r1, r1, r0 
    bne gcd        