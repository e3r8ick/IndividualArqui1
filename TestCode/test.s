.text
.global main
main:

        ldr r1, =string
        svc #0

.data
string: .asciz "Hello World\n"