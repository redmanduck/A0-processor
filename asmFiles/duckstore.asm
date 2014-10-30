org 0x0000
ori $4, $zero, 0xF4
ori $5, $zero, 0xEE
ori $9, $zero, 1
ori $10, $zero, 0xFF

end:  
beq $10, $zero, halto
sw $5, 0($4)
sw $4, 4($4)
lw $6, 0($4)
sw $5, 0($4)
subu $10, $10, $9
j end
halto:
halt
