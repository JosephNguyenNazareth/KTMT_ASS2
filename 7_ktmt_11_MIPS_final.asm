.data
	strIn: .space 1002
	newline: .ascii "\n"
.text

main:
	# move stack pointer to 56-bit lower
	# first store value of $ra to $sp + 52 ($ra = $fp + 56)
	# then store value of $fp
	# then store value of $s0
	addiu	$sp,$sp,-56
	sw	$v1,52($sp)
	sw	$s0,44($sp)
	# now $fp get the address of $sp
	# then store value of $a0, $a1
	# move	$fp,$sp
	sw	$a0,56($sp)
	sw	$a1,60($sp)
	la 	$t1, newline

	# create 1001-bit in $a0
	la 	$a0, strIn
	lbu 	$t1, 0($t1)
	li	$a1,1002			# 0x3e8
	li 	$v0, 8
	syscall

	# after getting input from screen, store it to $fp + 28
	sw	$a0,28($sp)
	# get another string
	la 	$a0, strIn
	li	$a2,1002
	addi 	$a0, $a0, 1002 # 0x3e8
	syscall

	# do the same as above
	sw 	$a0, 32($sp)
	lw	$a1,28($sp) # pString
	lw	$a2,32($sp) # myString

	sw	$0,16($sp) # pIndex = 0
	sw	$0,20($sp) # mIndex = 0
	sw	$0,24($sp) # found = 0
	b	.L2
	nop
.L6:
	lw	$v0,20($sp) # load myString and its mIndex
	lw	$v1,32($sp)
	lw	$a0,28($sp)
	nop
	nop
	addu	$v0,$v1,$v0

	lbu	$v1,0($v0) # assign it to $v1

	lw	$v0,16($sp) # load pString and its pIndex
	nop
	nop
	addu	$v0,$a0,$v0

	lbu	$v0,0($v0) # assign it to $v0
	nop
	nop
	bne	$v1,$v0,.L4 # if (myString[mIndex] != pString[pIndex])
	nop

	lw	$v0,20($sp) # mIndex increase 1 unit # load it from $sp
	nop
	nop
	addiu	$v0,$v0,1 # increase
	nop
	nop
	sw	$v0,20($sp) # store back to $sp
	lw	$v0,16($sp) # the same with pIndex
	nop
	nop
	addiu	$v0,$v0,1
	nop
	nop
	sw	$v0,16($sp)
	b	.L3
	nop
# .L4 = else
.L4:
	lw	$v0,16($sp) # load from $sp pIndex
	nop
	nop
	addiu	$v0,$v0,1 # then increase it to 1 unit
	nop
	nop
	sw	$v0,16($sp) # store it again back to $sp
	b	.L5
	nop
# .L3 = while (myString[mIndex] != '\0')
.L3:
	lw	$v0,20($sp) # mIndex
	lw	$v1,32($sp) # myString
	nop
	nop
	addu	$v1,$v1,$v0 # increase myString to myString + mIndex

	lbu	$v1,0($v1)
	nop
	nop
	bne	$v1,$t1,.L6 # if myString character not equals to zero
	nop
# .L5 = if (mIndex == strlen(myString)) found = pIndex - mIndex;
.L5:
	lw	$s0,20($sp) # mIndex
	lw	$a0,32($sp) # myString

	bne	$s0,$v0,.L7 # compare mIndex ($s0) and strlen(myString) ($v0)
	nop
	lw	$v0,20($sp) # load mIndex
	lw	$v1,16($sp) # load pIndex
	nop
	nop
	subu	$v0,$v1,$v0 # pIndex - mIndex
	nop
	nop
	sw	$v0,24($sp) # store to found variable address

# .L7 = mIndex = 0
.L7:
	sw	$0,20($sp)
# .L2 = while (pString[index] != '\0')
.L2:
	lw	$v0,16($sp) # pIndex
	lw	$v1,28($sp) # pString
	nop
	nop
	addu	$v0,$v1,$v0 # increase pString to pString + index

	lbu	$v0,0($v0)
	nop
	nop
	bne	$v0,$0,.L3 # if our pString character not equals to zero
	nop

	# print found variable
	lw	$a1,24($sp)
	li 	$v0, 1
	nop
	la 	$a0, ($a1)
	syscall

	# restore memmory
	move	$v0,$0
	lw	$v1,52($sp)
	lw	$s0,44($sp)
