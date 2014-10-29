#Mergesort for benchmarking
#Optimized for 512 bit I$ 1024 bit D$
#Author Adam Hendrickson ahendri@purdue.edu

org 0x0000
  ori   $fp, $zero, 0xFFFC #0
  ori   $sp, $zero, 0xFFFC #4
  ori   $a0, $zero, data   #8
  lw    $s0, size($zero)   #C
  srl   $a1, $s0, 1        #10
  or    $s1, $zero, $a0    #14
  or    $s2, $zero, $a1    #18
  jal   insertion_sort     #1C
  srl   $t0, $s0, 1        #20
  subu  $a1, $s0, $t0      #24
  sll   $t0, $t0, 2        #28
  ori   $a0, $zero, data   #2C
  addu  $a0, $a0, $t0      #30
  or    $s3, $zero, $a0    #34
  or    $s4, $zero, $a1    #38
  jal   insertion_sort     #3C
  or    $a0, $zero, $s1    #40
  or    $a1, $zero, $s2    #44
  or    $a2, $zero, $s3    #48
  or    $a3, $zero, $s4    #4C
  ori   $t0, $zero, sorted #50
  push  $t0                #54
  jal   merge              #58
  addiu $sp, $sp, 4        #60
  halt                     #64



#void insertion_sort(int* $a0, int $a1)
# $a0 : pointer to data start
# $a1 : size of array
#--------------------------------------
insertion_sort:            #68
  ori   $t0, $zero, 4      #6C
  sll   $t1, $a1, 2        #70
is_outer:
  sltu  $at, $t0, $t1      #74
  beq   $at, $zero, is_end #78
  addu  $t9, $a0, $t0      #7C
  lw    $t8, 0($t9)        #80
is_inner:
  beq   $t9, $a0, is_inner_end  #84
  lw    $t7, -4($t9)            #88
  slt   $at, $t8, $t7           #8C
  beq   $at, $zero, is_inner_end  #90
  sw    $t7, 0($t9) #94
  addiu $t9, $t9, -4 #98
  j     is_inner #9C
is_inner_end:
  sw    $t8, 0($t9) #A0
  addiu $t0, $t0, 4 #A4
  j     is_outer    #A8
is_end:
  jr    $ra         #AC
#--------------------------------------

#void merge(int* $a0, int $a1, int* $a2, int $a3, int* dst)
# $a0 : pointer to list 1
# $a1 : size of list 1
# $a2 : pointer to list 2
# $a3 : size of list 2
# dst [$sp+4] : pointer to merged list location
#--------------------------------------
merge:
  lw    $t0, 0($sp)    #B0
m_1:
  bne   $a1, $zero, m_3 #B4
m_2:
  bne   $a3, $zero, m_3 #B8
  j     m_end           #BC
m_3:
  beq   $a3, $zero, m_4  #C0
  beq   $a1, $zero, m_5  #C4
  lw    $t1, 0($a0)      #C8
  lw    $t2, 0($a2)      #CC
  slt   $at, $t1, $t2    #D0
  beq   $at, $zero, m_3a #D4
  sw    $t1, 0($t0)      #D8
  addiu $t0, $t0, 4      #DC
  addiu $a0, $a0, 4      #E0
  addiu $a1, $a1, -1     #E4
  j     m_1              #E8
m_3a:
  sw    $t2, 0($t0)      #EC
  addiu $t0, $t0, 4      #F0
  addiu $a2, $a2, 4      #f4
  addiu $a3, $a3, -1    #f8
  j     m_1 #fc
m_4:  #left copy
  lw    $t1, 0($a0)    #fc
  sw    $t1, 0($t0)    #100
  addiu $t0, $t0, 4    #104
  addiu $a1, $a1, -1   #108
  addiu $a0, $a0, 4    #10C
  beq   $a1, $zero, m_end  #110
  j     m_4            #114
m_5:  # right copy
  lw    $t2, 0($a2)  #118
  sw    $t2, 0($t0)  #11C
  addiu $t0, $t0, 4  #120
  addiu $a3, $a3, -1 #124
  addiu $a2, $a2, 4  #128
  beq   $a3, $zero, m_end #12C
  j     m_5          #130
m_end:
  jr    $ra          #134
#--------------------------------------


org 0x300
size:
cfw 64
data:
cfw 90
cfw 81
cfw 51
cfw 25
cfw 80
cfw 41
cfw 22
cfw 21
cfw 12
cfw 62
cfw 75
cfw 71
cfw 83
cfw 81
cfw 77
cfw 22
cfw 11
cfw 29
cfw 7
cfw 33
cfw 99
cfw 27
cfw 100
cfw 66
cfw 61
cfw 32
cfw 1
cfw 54
cfw 4
cfw 61
cfw 56
cfw 3
cfw 48
cfw 8
cfw 66
cfw 100
cfw 15
cfw 92
cfw 65
cfw 32
cfw 9
cfw 47
cfw 89
cfw 17
cfw 7
cfw 35
cfw 68
cfw 32
cfw 10
cfw 7
cfw 23
cfw 92
cfw 91
cfw 40
cfw 26
cfw 8
cfw 36
cfw 38
cfw 8
cfw 38
cfw 16
cfw 50
cfw 7
cfw 67

org 0x400
sorted:
