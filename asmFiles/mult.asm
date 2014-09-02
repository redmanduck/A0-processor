# *** Multiply program ***
# this program multiplies two unsigned words.
# data will be passsed to this routine via stack
# use the stack pointer register sp(29)
# at start of the program initialize stack to address 0xFFFC
# Pat S. Sabpisal
# ssabpisa@purdue.edu


addiu $29, $0, 0xFFFC     # R[29] = 0 + 0xFFFC

