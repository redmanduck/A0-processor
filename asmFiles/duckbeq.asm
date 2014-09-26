
  #------------------------------------------------------------------
  # Flying BEQ algorithm
  # author Pat Sabpisal pat@uniduck.co
  #------------------------------------------------------------------

  org 0x0000
  ori   $4, $zero, 0xFACA #0
  beq   $zero, $zero, superend #04
  ori   $1,$zero,6             #08
  ori   $2,$zero,6           #0c
  ori   $3,$zero,6 #10

  superend:
  halt                     #14
