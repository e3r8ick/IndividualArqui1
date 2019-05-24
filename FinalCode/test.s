.text
.global pow
pow:
    CMP r0, #0
    MOVEQ r0, #1
    BXEQ lr
    TST r0, #1
    BEQ skip
    SUB r0, r0, #1
    BL pow
    MUL r0, r1, r0
    BX lr
    
skip:
    LSR r0, #1
    BL pow
    MUL r3, r0, r3
    BX lr