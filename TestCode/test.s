.text
.global gcd
gcd:
    mov r0, #17
    mov r29, #17
     cmp    r0, r1     
     subgt  r0, r0, r1 
     sublt  r1, r1, r0 
     bne    gcd        