# THIS MIPS FILE FOR COMPARISION ONLY
# WE WORK ON THE .s FILE
.data
    endl: .asciiz "\n" #create endline character when printing number
.text
# $t0 holds the walker value, to create a list of random number
addi    $t0, $zero, 0
addi    $t1, $zero, 0
# $s0 holds the size of list
addi    $s0, $zero, 9
#  $a1 holds the upper limit of our random
li      $a1, 100

# main will create random number, loops until $t0 equals to $s0

main1:
# $v0, 41 especially makes random number
li      $v0, 42
syscall
add     $s1, $a0, $zero
add     $s1, $s1, $t1

# increase $t0 by 1 unit, stop when reach $s0
addi    $t0, $t0, 1
addi    $t1, $t1, 4

# compare $t0 and $s0, if not equal, continue to make random
# if not, stop main loop
bne     $s0, $t0, main1

addi    $t0, $zero, 0
addi    $t1, $zero, 0

main2:
# $v0, 41 especially makes random number
li      $v0, 42
syscall
add     $s2, $a0, $zero
add     $s2, $s2, $t1

# increase $t0 by 1 unit, stop when reach $s0
addi    $t0, $t0, 1
addi    $t1, $t1, 4

# compare $t0 and $s0, if not equal, continue to make random
# if not, stop main loop
bne     $s0, $t0, main2

addi    $t0, $zero, 0
addi    $t1, $zero, 0
addi    $s3, $zero, 0

# multiply two vector result as a number
multiply:
mul     $t3, $s1, $s2
add     $s3, $s3, $t3

addi    $t0, $t0, 1
addi    $t1, $t1, 4

sub     $s1, $s1, $t1
sub     $s2, $s2, $t1
bne     $s0, $t0, multiply

la      $a0, ($s3)
li      $v0, 1
syscall