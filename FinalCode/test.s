.text
.global GCD
GCD:
    MOV R0, #17
    MOV R1, #29
    CMP R0, R1     
    SUBGT R0, R0, R1 
    SUBLT R1, R1, R0 
    BNE GCD        