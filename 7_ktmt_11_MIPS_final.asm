.data
	strIn: .space 1002
	newline: .ascii "\n"
.text

main:
    # s1 is pString, s2 is myString, t2 is pIndex, t3 is mIndex, t4 is found
	la 	$t1, newline

	# create 1002-bit in $a0
	la 	$a0, strIn
	lbu 	$t1, 0($t1)
	li	$a1,1002			# 0x3e8
	li 	$v0, 8
	syscall

	# after getting input from screen, store it to $fp + 28
	add $s1, $a0, $zero
	# get another string
	la 	$a0, strIn
	li	$a2,1002
	addi 	$a0, $a0, 1002 # 0x3e8
	syscall

	# do the same as above
	add $s2, $a0, $zero

	add $t2, $zero, $zero # pIndex = 0
	add $t3, $zero, $zero # mIndex = 0
	add $t4, $zero, $zero # found = 0
	b	.L2
	nop
.L6:
	addu	$v0,$s2,$t3 # myString + mIndex
	lbu	$v1,0($v0) # assign it to $v1

	addu	$v0,$s1,$t2 # v0 is pString + pIndex
	lbu	$v0,0($v0) # assign it to $v0
	nop
	nop
	bne	$v1,$v0,.L4 # if (myString[mIndex] != pString[pIndex])
	nop

	addiu	$t3,$t3,1 # increase mIndex
	addiu	$t2,$t2,1 # increase pIndex
	b	.L3
	nop
# .L4 = else
.L4:
	addiu	$t2,$t2,1 # then increase pIndex to 1 unit
    add     $v0,$t2,$zero
	b	.L5
	nop
# .L3 = while (myString[mIndex] != '\0')
.L3:
	addu	$v1,$s2,$t3 # increase myString to myString + mIndex
    add     $v0,$t3,$zero
	lbu	$v1,0($v1)
	bne	$v1,$t1,.L6 # if myString character not equals to zero
	nop
# .L5 = if (mIndex == strlen(myString)) found = pIndex - mIndex;
.L5:
	bne	$t3,$v0,.L7 # compare mIndex ($s0) and strlen(myString) ($v0)
	nop
	subu	$t4,$t2,$t3 # pIndex - mIndex
# .L7 = mIndex = 0
.L7:
	add     $t3, $zero, $zero
# .L2 = while (pString[index] != '\0')
.L2:
	addu	$v0,$s1,$t2 # increase pString to pString + index
	lbu	$v0,0($v0)
	nop
	nop
	bne	$v0,$0,.L3 # if our pString character not equals to zero
	nop
	# print found variable
	li 	$v0, 1
	la 	$a0, ($t4)
	syscall