
  org   0x0000
  ori   $1, $zero, 0xF0
  ori   $2, $zero, 0x001
  ori   $3, $zero, 0x200
  ori   $4, $zero, 0x300
  ori   $5, $zero, 0x400
  addu  $6, $2, $2
  addu  $7, $2, $2
  sw    $7, 0($1)
  halt      # that's all


