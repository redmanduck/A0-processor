org 0x0000
ori  $5, $zero, 0xF0
ori  $6, $zero, 0xDEAD
addiu $7, $zero, 0xBEEF
beq  $zero, $7, custom
sw $6, 0($5)
custom:
sw $7, 4($5)
halt
