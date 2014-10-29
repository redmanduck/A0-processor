org 0x0000
ori $4, $zero, 0xFF4
j  target
j infinite
target:
bne $4, $zero, notequal #14
jal infinite #18
notequal:
sw $4,0($4) #1C
halt  #20
infinite:

