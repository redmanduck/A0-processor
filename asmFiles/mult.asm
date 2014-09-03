 org    0x0000
 addiu  $sp, $0, 0xFFFC     # Initialize stack pointer to address 0xFFFC
 addi  $sp, $sp, -8        # allocate 2 spaces
 lui    $15, 2              # operands
 lui    $16, 3
 push   $15
 push   $16
 halt
mult:
  pop    $16
  pop    $17
  lw     $18, 0($0)
  beq    $16,  $0, mult_done        # skip if operand is 0
mloop:
  beq    $17,  $0, mult_done   # exit condition
  addu   $18,  $16, $16        # add s0 to itself
  addi   $17,  $17, -1         # decrement loop
  j      mloop
mult_done:
  push   $18
  addi   $31, $18, 0
