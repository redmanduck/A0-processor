
  org 0x0000
  ori   $4, $zero, 0xFACA #0
  sw    $4, $zero, 0xFC
  beq   $zero, $zero, superend #04
  ori   $4, $zero, 0xADAA
  nop
  sw    $4,$zero, 0xFF
  ori   $1,$zero,6             #08
  ori   $2,$zero,6           #0c
  ori   $3,$zero,6 #10
  halt
  superend:
  #sw    $3,$zero, 0xF0
  sw    $4, $zero, 0xF0
  halt                     #14
