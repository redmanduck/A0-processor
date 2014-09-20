
  #------------------------------------------------------------------
  # Flying duck algorithm
  # author Pat Sabpisal pat@uniduck.co
  #------------------------------------------------------------------

  org 0x0000
  ori   $1,$zero,31

  j superduck

  layegg:
  ori   $15,$zero, 0xDEA
  jr $31

  superduck:
  ori   $16, $zero, 0x900D
  jal layegg

  halt
