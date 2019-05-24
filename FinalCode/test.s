.text
.global pow
POW:
    MOV R0,#2           @ number to pow
    MOV R1,#3           @ the pow
    CMP R2,#1           @ if pow = 1
    BEQ NEXT

POW_AUX:
    MUL R0,R0,R0        @ x*x
    SUB R1,R1,#1        @ i--
    CMP R1,#0           @ i == 0
    BNE POW_AUX         @ loot

NEXT: