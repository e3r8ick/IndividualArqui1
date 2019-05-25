# IndividualArqui1
##########STEPS TO EMULATE########################################

-> Follow this tutorial
https://azeria-labs.com/emulate-raspberry-pi-with-qemu/

-> in the initialConfig 
bash run.sh

-> in the emulator 
as RSA.s -o rsa.o

ld rsa.o -o rsa

./rsa

-> for debuggin

gdb rsa

##########COMANDS###################################################
layout asm      # Mostrar el código 
nexti           # Próxima instrucción
next            # Terminar ejecución
stepi           # Proximo step
info registers  #info de los registers


#######REGISTER INFO###################################
R0 EEE
R1 AAA
R2 BBB
R3 CCC
R4 DDD
R5 GGG
R8 YYY
R9 TTT
R9 TTT
R11 Key1
R12 Key2