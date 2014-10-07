
  #------------------------------------------------------------------
  # Jumping duck algorithm
  # author Pat Sabpisal pat@uniduck.co
  #------------------------------------------------------------------

  org 0x0000
  ori $1, $zero, 1
  ori $2, $zero, 2
  ori $3, $zero, 3

  superduck:
  ori $4, $zero, 4
  jal layegg  #0  (addr 31 contains 4)
  sw $3, $zero, 0xF4
  halt        #4

  layegg:
  ori $15, $zero, 0xAABB #8
  jr $31   #C


  #PC order: 0, 8, C, 4

