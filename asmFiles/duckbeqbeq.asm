org 0x0000
ori $4, $zero, 0xFACA
ori $5, $zero, 0xABCD
beq $zero, $zero, dran
halt
dran:
beq $4, $5, duxman
beq $zero, $zero, danmux
halt
danmux:
sw  $4, $zero, 0xF0
duxman:
sw $5, $zero, 0xF4
halt
