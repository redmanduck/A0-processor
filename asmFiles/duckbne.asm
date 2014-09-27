org 0x0000
bne $zero, $zero, stop
ori $6, $zero, 0xFABB
stop:
ori  $5, $zero, 0xFACC
#sw   $5, 5($zero)
halt
