	.file	1 "VectorMul.c" #file name compiled
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.rdata
	.align	2 # advance programme counter each time 4-byte
.LC0:
	.ascii	"%d\012\000"
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0 #create 40-bits function stack, assign to $ra
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$16,32($sp)
	sw	$4,40($sp)
	sw	$5,44($sp)
	li	$4,4000			# 0xfa0
	jal	malloc # jal will move to next instruction then call $ra, it need a no-operation instruction, so we call nop
	nop #nop = stall

	sw	$2,24($sp)
	li	$4,4000			# 0xfa0
	jal	malloc
	nop

	sw	$2,28($sp)
	move	$4,$0
	jal	time
	nop

	move	$4,$2
	jal	srand
	nop

	sw	$0,16($sp)
	sw	$0,20($sp)
	b	.L2
	nop

.L3:
	lw	$2,20($sp)
	sll	$2,$2,2
	lw	$3,24($sp)
	addu	$16,$3,$2
	jal	rand
	nop

	move	$3,$2
	li	$2,1374355456			# 0x51eb0000
	ori	$2,$2,0x851f
	mult	$3,$2
	mfhi	$2
	sra	$4,$2,5
	sra	$2,$3,31
	subu	$2,$4,$2
	sll	$2,$2,2
	sll	$4,$2,2
	addu	$2,$2,$4
	sll	$4,$2,2
	addu	$2,$2,$4
	subu	$2,$3,$2
	sw	$2,0($16)
	lw	$2,20($sp)
	sll	$2,$2,2
	lw	$3,28($sp)
	addu	$16,$3,$2
	jal	rand
	nop

	move	$3,$2
	li	$2,1374355456			# 0x51eb0000
	ori	$2,$2,0x851f
	mult	$3,$2
	mfhi	$2
	sra	$4,$2,5
	sra	$2,$3,31
	subu	$2,$4,$2
	sll	$2,$2,2
	sll	$4,$2,2
	addu	$2,$2,$4
	sll	$4,$2,2
	addu	$2,$2,$4
	subu	$2,$3,$2
	sw	$2,0($16)
	lw	$2,20($sp)
	sll	$2,$2,2
	lw	$3,24($sp)
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,20($sp)
	sll	$2,$2,2
	lw	$4,28($sp)
	addu	$2,$4,$2
	lw	$2,0($2)
	mult	$3,$2
	lw	$2,16($sp)
	mflo	$3
	addu	$2,$2,$3
	sw	$2,16($sp)
	lw	$2,20($sp)
	addiu	$2,$2,1
	sw	$2,20($sp)
.L2:
	lw	$2,20($sp)
	slt	$2,$2,1000
	bne	$2,$0,.L3
	nop

	lui	$2,%hi(.LC0)
	addiu	$4,$2,%lo(.LC0)
	lw	$5,16($sp)
	jal	printf
	nop

	lw	$4,24($sp)
	jal	free
	nop

	lw	$4,28($sp)
	jal	free
	nop

	move	$2,$0
	lw	$31,36($sp)
	lw	$16,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Codescape GNU Tools 2016.05-03 for MIPS MTI Bare Metal) 4.9.2"
