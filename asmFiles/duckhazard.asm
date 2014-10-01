org 0x0000
ori $6, $zero, 0xDEAD
ori $7, $zero, 0xBEEF
ori $8, $zero, 0xDEAD
ori $8, $zero, 0xDEAD
addu $9, $6, $7
or   $10, $9, $zero
sw $10, $zero, 0xF4
halt
