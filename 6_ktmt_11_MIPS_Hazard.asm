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
	sw	$fp,48($sp)
	sw	$s0,44($sp)
	# now $fp get the address of $sp
	# then store value of $a0, $a1
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	la 	$t1, newline
	lbu $t1, 0($t1)

	# create 1002-bit in $a0
	la 	$a0, strIn
	li	$a1,1002		# 0x3e8
	li 	$v0, 8
	syscall

	# after getting input from screen, store it to $fp + 28
	sw	$a0,28($fp)
	# get another string
	la 	$a0, strIn
	nop
	nop
	addi 	$a0, $a0, 1002
	li	$a2,1002		# 0x3e8
	li 	$v0, 8
	syscall

	# do the same as above
	sw 	$a0, 32($fp)
	lw	$a1,28($fp) 		# pString
	lw	$a2,32($fp) 		# myString

	sw	$0,16($fp) 		# pIndex = 0
	sw	$0,20($fp) 		# mIndex = 0
	sw	$0,24($fp) 		# found = 0
	b	.L2
	nop	           		#Branch hazard
.L6:
	lw	$v0,20($fp) 		# load myString and its mIndex
	lw	$v1,32($fp)
	nop 	# double stall for load use
	nop
	addu	$v0,$v1,$v0
	lbu	$v1,0($v0) 		# assign it to $v1
	lw	$v0,16($fp) 		# load pString and its pIndex
	lw	$a0,28($fp)
	nop			# double stall load hazard
	nop
	addu	$v0,$a0,$v0
	lbu	$v0,0($v0) 		# assign it to $v0
	nop			# double stall load hazard
	nop
	bne	$v1,$v0,.L4 		# if (myString[mIndex] != pString[pIndex])
	nop	         		#Branch hazard

	lw	$v0,20($fp) 		# mIndex increase 1 unit # load it from $fp
	nop			# double stall load hazard
	nop
	addiu	$v0,$v0,1 		# increase
	nop 	# double stall
	nop
	sw	$v0,20($fp) 		# store back to $fp
	lw	$v0,16($fp) 		# the same with pIndex
	nop			# double stall load hazard
	nop
	addiu	$v0,$v0,1
	nop 	# double stall
	nop
	sw	$v0,16($fp)
	b	.L3
	nop	           		#Branch hazard

# .L4 = else
.L4:
	lw	$v0,16($fp) 		# load from $fp pIndex
	nop			# double stall load hazard
	nop
	addiu	$v0,$v0,1 		# then increase it to 1 unit
	nop 	# double stall to store value
	nop
	sw	$v0,16($fp) 		# store it again back to $fp
	b	.L5
	nop	           #Branch hazard

# .L3 = while (myString[mIndex] != '\0')
.L3:
	lw	$v0,20($fp) 		# mIndex
	lw	$v1,32($fp) 		# myString
	nop			# double stall for load hazard
	nop
	addu	$v1,$v1,$v0 		# increase myString to myString + mIndex
	lbu	$v1,0($v1)
	nop			# double stall for load hazard
	nop
	bne	$v1,$t1,.L6 		# if myString character not equals to zero
	nop	           		#Branch hazard
# .L5 = if (mIndex == strlen(myString)) found = pIndex - mIndex;
.L5:
	lw	$s0,20($fp) 		# mIndex
	lw	$a0,32($fp) 		# myString

	bne	$s0,$v0,.L7 		# compare mIndex ($s0) and strlen(myString) ($v0)
	nop	           		#Branch hazard

	lw	$v1,16($fp) 		# load pIndex
	lw	$v0,20($fp) 		# load mIndex
	nop			# double stall for load hazard
	nop
	subu	$v0,$v1,$v0 		# pIndex - mIndex, forwarding
	nop 	# double stall for store instruction
	nop
	sw	$v0,24($fp) 		# store to found variable address

# .L7 = mIndex = 0
.L7:
	sw	$0,20($fp)
# .L2 = while (pString[index] != '\0')
.L2:
	lw	$v0,16($fp) 		# pIndex
	lw	$v1,28($fp) 		# pString
	nop			# double stall for load hazard
	nop
	addu	$v0,$v1,$v0 		# increase pString to pString + index, forwarding
	lbu	$v0,0($v0)
	nop			# double stall for load hazard
	nop
	bne	$v0,$0,.L3 		# if our pString character not equals to zero
	nop	           		#Branch hazard

	# print found variable
	lw	$a1,24($fp)
	nop			# double stall for load hazard
	nop
	la 	$a0, ($a1)
	li 	$v0, 1
	syscall

	# restore memmory
	move	$v0,$0
	move	$sp,$fp
	lw	$v1,52($sp)
	lw	$fp,48($sp)
	lw	$s0,44($sp)