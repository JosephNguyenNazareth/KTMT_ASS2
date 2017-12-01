	.file	1 "stringCheck.c" # file name compiled
	.section .mdebug.abi32 # for debugger 1-3
	.previous
	.nan	legacy # there are two type of NaN ("signalling" and "quiet", WIKI for more details), "legacy" express using "signalling" NaN
	.module	fp=xx # -mfpxx: floating-point number is executed exactly 32-bit register or 64-bit register??
	.module	nooddspreg
	.rdata
	.align	2 # each instruction cost 4-byte
.LC0:
	.ascii	"%s%s\000" # input instruction description
	.align	2 # 4-byte instruction, pc + 4 each time
.LC1:
	.ascii	"%d\000" # output instruction description
	.text
	.align	2
	.globl	main # name of the scope can be called by another
	.set	nomips16 # for certain that, this mips work on normal 32-bit mode, not 16-bit mode
	.set	nomicromips #micromips is a supersets of MIPS32 and MIPS64 which changes some 32-bit instruction to 16-bit version for using mix in MIPS16e
	.ent	main # .ent makes the entry of main, tell the debugger
	.type	main, @function
main:
	.frame	$fp,56,$31		# vars= 24, regs= 3/0, args= 16, gp= 0
							# frame will create a space of 56-bit in stack, pointer to $31
	.mask	0xc0010000,-4 	# for debugger, store variable at $16 and cost 4-bit lower
	.fmask	0x00000000,0
	.set	noreorder # tell the assembler not to move(rearrange) our instruction
	.set	nomacro # no macro to translate-no statement is more than one instruction
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	sw	$16,44($sp)
	move	$fp,$sp
	sw	$4,56($fp)
	sw	$5,60($fp)
	li	$4,1000			# 0x3e8
	jal	malloc
	nop

	sw	$2,28($fp)
	li	$4,1000			# 0x3e8
	jal	malloc
	nop

	sw	$2,32($fp)
	lui	$2,%hi(.LC0)
	addiu	$4,$2,%lo(.LC0)
	lw	$5,28($fp)
	lw	$6,32($fp)
	jal	scanf
	nop

	sw	$0,16($fp)
	sw	$0,20($fp)
	sw	$0,24($fp)
	b	.L2
	nop

.L8:
	b	.L3
	nop

.L6:
	lw	$2,20($fp)
	lw	$3,32($fp)
	addu	$2,$3,$2
	lbu	$3,0($2)
	lw	$2,16($fp)
	lw	$4,28($fp)
	addu	$2,$4,$2
	lbu	$2,0($2)
	bne	$3,$2,.L4
	nop

	lw	$2,20($fp)
	addiu	$2,$2,1
	sw	$2,20($fp)
	lw	$2,16($fp)
	addiu	$2,$2,1
	sw	$2,16($fp)
	b	.L3
	nop

.L4:
	lw	$2,16($fp)
	addiu	$2,$2,1
	sw	$2,16($fp)
	b	.L5
	nop

.L3:
	lw	$2,20($fp)
	lw	$3,32($fp)
	addu	$2,$3,$2
	lbu	$2,0($2)
	bne	$2,$0,.L6
	nop

.L5:
	lw	$16,20($fp)
	lw	$4,32($fp)
	jal	strlen
	nop

	bne	$16,$2,.L7
	nop

	lw	$3,16($fp)
	lw	$2,20($fp)
	subu	$2,$3,$2
	sw	$2,24($fp)
.L7:
	sw	$0,20($fp)
.L2:
	lw	$2,16($fp)
	lw	$3,28($fp)
	addu	$2,$3,$2
	lbu	$2,0($2)
	bne	$2,$0,.L8
	nop

	lui	$2,%hi(.LC1)
	addiu	$4,$2,%lo(.LC1)
	lw	$5,24($fp)
	jal	printf
	nop

	move	$2,$0
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	lw	$16,44($sp)
	addiu	$sp,$sp,56
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Codescape GNU Tools 2016.05-03 for MIPS MTI Bare Metal) 4.9.2"
