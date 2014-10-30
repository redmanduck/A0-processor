org 0x0000
ori $4, $zero, 0xEC
ori $5, $zero, 0xAC
ori $8, $zero, 0x1EC
ori $22, $0, 0xB0AF
ori $21, $0, 0xF0AB
ori $6, $zero, 0xBEEF
ori $7, $zero, 0xDEAD
ori $1, $zero, 0xAABB

sw $6, 0($4) #1
sw $7, 0($5) #0
sw $1, 0($8) #1

lw $26, 0($4) 
lw $27, 0($5)  
lw $28, 0($8)  

sw $26, 4($4) 
sw $21, 8($4)  #<--that
sw $22, 4($8)

halt
