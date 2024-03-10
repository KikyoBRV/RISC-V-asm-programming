.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
newline: .string "\n"
print_text: .asciiz "The dot product is: "

.text
main:
    la a0, a # loading address of a to a0
    la a1, b # loading address of b to a1
    addi a2, x0, 5 # set size to 5 and put into a2
    
    # call function
    jal dot_product_recursive
    
    # exit
    j exit
    
    
dot_product_recursive:
    
    # recursive case
    addi sp, sp, -16
    sw ra, 0(sp) # storing the ra value on to the stack
    sw a0, 4(sp) # storing the a value on to the stack
    sw a1, 8(sp) # storing the b value on to the stack
    sw a2, 12(sp) # storing the size value on to the stack
    addi t0, x0, 1 # add 1 to t0
    beq a2, t0, exit_case # if size == 1
    
    # dot_product_recursive(a+1, b+1, size-1)
    addi a0, a0, 4 # add 4 to the a value
    addi a1, a1, 4 # add 4 to the b value
    addi a2, a2, -1 # minus 1 from the size value
    jal dot_product_recursive
    
    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    lw ra, 0(sp) # load ra
    lw t0, 4(sp) # load a value to t0
    lw t1, 8(sp) # load b value to t1
    lw t2, 12(sp)# load size value to t2
    addi sp, sp, 16
    lw t3, 0(t0) # load a[0] value to t3
    lw t4, 0(t1) # load b[0] value to t4
    mul t5, t3, t4 # a[0]*b[0]
    add a0, a0, t5 
    jr ra
    
    
exit_case:
    addi sp sp 16 # Reset stack pointer
    lw t1 0(a0) # load a[0] to t1
    lw t2 0(a1) # load b[0] to t2
    mul a0 t1 t2 # a[0]*b[0]
    jr ra

exit:
    mv t0 a0

    addi a0 x0 4
    la a1 print_text
    ecall

    mv a1 t0
    addi a0 x0 1
    ecall

    addi a0 x0 10
    ecall