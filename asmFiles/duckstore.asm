org 0x0000
ori $4, $zero, 0xF4
ori $5, $zero, 0xEE
sw $5, 0($4)
sw $4, 4($4)
lw $6, 0($4)
halt
