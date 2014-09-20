
  #------------------------------------------------------------------
  # Flying BEQ algorithm
  # author Pat Sabpisal pat@uniduck.co
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,10   #0
  ori   $2,$zero,5    #4
  ori   $3,$zero,5    #8

  superduck:
  ori   $16, $zero, 0x900D #C
  beq  $2,$3, superend     #10
  j superduck              #14

  superend:
  halt                     #1C
