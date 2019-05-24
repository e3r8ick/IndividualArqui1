.text
.global pow
POW:
    MOV R0,#2           @ number to pow
    MOV R3,#2           @ number to pow
    MOV R1,#3           @ the pow
    CMP R1,#1           @ if pow = 1
    BEQ NEXT

POW_AUX:
    MUL R0,R3,R0        @ x*x
    SUB R1,R1,#1        @ i--
    CMP R1,#1           @ i == 1
    BNE POW_AUX         @ loot

NEXT: