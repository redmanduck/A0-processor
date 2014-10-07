#--------------------------------------
# Test with a duck fibs sequence
#--------------------------------------
  org 0x0000

  ori   $2, $2, start
  ori   $1, $1, 1
  ori   $8, $8, 4
  ori   $6, $6, 0x0F00
  ori   $15, $zero, 5   

loop:
  lw    $3, 0 ($2)
  lw    $4, 4 ($2)                     #$rt,  imm($rs)
  addu  $5, $3, $4  #addu  $2, $2, $8  #$rd, $rs $rt
  sw    $5, 8 ($2)
  addu  $5, $3, $4
  subu  $15, $15, $1
  bne   $15, $zero, loop
end:
  halt

  org 0x80

start:
  cfw 0
  cfw 1

#uncomment to work with the simulator (sim)
# comment to use mmio

  org 0x0F00
  cfw 22
