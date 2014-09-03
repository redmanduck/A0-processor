###################
### main program ##
###################

   org    0x0000
   addi   $sp, $0, 0xFFFC
   addi   $15, $0, 2                # operands
   addi   $16, $0, 2
   addi   $14, $0, 0xFFF8           # R14 save the sp state
   push   $15
   push   $16
   push   $16
   jal    mult_procedure
mult_procedure:
  beq    $14, $sp, end_mult_procedure
  jal    mult
  j      mult_procedure
end_mult_procedure:
  halt

###################################
######## Multiply routine #########
###################################

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
  push   $19 #push ans to stk
  jr     $31 #return to caller
