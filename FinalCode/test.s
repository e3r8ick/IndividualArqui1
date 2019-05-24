.text
.global pow
POW:
    MOV R0,#2           @ number to pow
    MOV R1,#3           @ the pow
    MOV R2,#3           @ i = pow
    CMP R2,#1           @ if pow = 1
    BEQ NEXT

POW_AUX:
    MUL R4,R0,R0        @ x*x
    SUB R2,#1           @ i--
    CMP R2,#0           @ i == 0
    BNE POW_AUX         @ loot

NEXT: