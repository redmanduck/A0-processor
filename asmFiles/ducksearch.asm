  org 0x0000

  what:
  ori   $4, $zero, 0xFACA 
  ori   $4, $zero, 0xFACA 
  ori   $4, $zero, 0xFACA 
  ori   $4, $zero, 0xFACA 

  beq   $zero, $4, what
  beq   $zero, $zero, superman
  halt

  superman:
  halt
