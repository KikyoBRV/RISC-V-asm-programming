.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
newline: .string "\n"

.text
main:
    
    #int i, sop = 0;
    addi x4, x0, 0 # let x4 be the sop and set it to 0
    addi x5, x0, 5 # let x5 be size and set it to 5
    addi x6, x0, 0 # let x6 be the i and set it to 0
    
    #for (i = 0; i < 5; i++) {
    #    sop += a[i] * b[i];
    #}
    la x7, a # loading the address of a to x7
    la x8, b # loading the address of b to x8
    
loop1:
    bge x6, x5, exit1 # check if i >= size, if so goto exit1
    slli x9, x6, 2 # set x9 to i*4
    add x13, x7, x9 # add i*4 to the base address off a and put it to x9
    lw x10, 0(x13) # value of a[i] load to x10
    add x13, x8, x9 # add i*4 to the base address off a and put it to x9
    lw x11, 0(x13) # value of b[i] load to x11
    mul x12, x10, x11 # a[i]*b[i]
    add x4, x4, x12 # sop += a[i]*b[i]
    addi x6, x6, 1 # i++
    j loop1

exit1:

    # print_int; sop
    addi a0, x0, 1
    add a1, x0, x4
    ecall
