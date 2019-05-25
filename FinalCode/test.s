.text
.global __main

__main:
    ldr R1, =OpenParams @ parameters block for OPEN
    mov R0, #0x01 @ code number for Open File
    swi 0x123456 @ open a text file for input
    cmp R0, #0
    blt OpenError @ branch if there was an error
    ldr R1, =ReadParams
    str R0,[R1] @ save the file handle into
    @ parameters block for READ
    mov R0, #0x06 @ code number for Read File
    swi 0x123456 @ read from the text file
    cmp R0, #0
    bne ReadError @ branch if there was an error

.data
    ReadParams:
.word 0 @ the file handle
.word InputBuffer @ address of input buffer
.word 80 @ number of bytes to read
    InputBuffer:
.skip 80
    OpenParams:
.word FileName
.word FileNameEnd-FileName @ length of filename
.word 0 @ File mode = read
    FileName:
.ascii "params.txt" @ name without final NUL byte
    FileNameEnd:
.byte 0 @ the NUL byte