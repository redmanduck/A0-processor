  org    0x0000
  addiu  $sp, $0, 0xFFFC       # Initialize stack pointer to address 0xFFFC

countday:
  addiu    $15, $0, 28                # currentday
  addiu    $16, $0, 8                # currentmonth
  addiu    $14, $0, 2014             # currentyear
  addiu    $14, $14, -2000           # get the third term
  addiu    $16, $16, -1
  addiu    $8,  $0, 365
  push     $14
  push     $8
  jal      mult
  pop      $14  #recylcling 14
  addi     $8, $0, 30
  push     $16
  push     $8
  jal      mult
  pop      $16    # recycling 16
  addu     $14, $14, $16
  addu     $14, $15, $14
  addu     $31, $0, $14         #ans
  push     $31
  halt

mult:
  pop     $18
  pop     $17
  lui     $8, 0
  lui     $19, 0
  beq     $17,  $0, mult_done        # skip if operand is 0
mloop:
  beq     $18,  $0, mult_done
  addu    $19, $17, $19
  addiu   $18,  $18, -1              # decrement loop
  j       mloop
mult_done:
  push   $19 #push ans to stk
  jr     $31 #return to caller
