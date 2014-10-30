org 0x0000
addiu $sp, $0, 0xFFFC # Initialize stack pointer to address 0xFFFC
addiu $18, $0, 2 # operands
addiu $17, $0, 2
mloop:
beq $18, $0, mult_done
#addu $19, $17, $19
addiu $18, $18, -1 # decrement loop
j mloop
mult_done:
addiu $sp, $sp, -4
sw    $19, 0($sp)
#push $19
#addiu $31, $19, 0
halt
