  org    0x0000
  addiu  $sp, $0, 0xFFFC       # Initialize stack pointer to address 0xFFFC
# addi  $sp, $sp, -8           # allocate 2 spaces
  addi    $15, $0, 6                # operands
  addi    $16, $0, 5
  push   $15
  push   $16

mult:
  pop    $18
  pop    $17
  lui    $8, 0
  lui    $19, 0
  beq    $17,  $0, mult_done        # skip if operand is 0
mloop:
  beq    $18,  $0, mult_done
  addu   $19, $17, $19
  addi   $18,  $18, -1              # decrement loop
  j      mloop
mult_done:
  #push   $19
  #addi   $31,  $19, 0
  halt
