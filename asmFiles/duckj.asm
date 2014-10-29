
  org 0x0000
  ori $1, $zero, 1
  ori $2, $zero, 1
  ori $3, $zero, 3

  superduck:
  beq $1, $1, superman
  j superduck
  superman:
  j stop

  stop:
  beq $1, $0, superduck
  halt
