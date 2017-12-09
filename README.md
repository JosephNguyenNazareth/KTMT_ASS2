# KTMT_ASS2
Compile C to MIPS Assemply

## Deadline
11:59:59 December 11th, 2017

## Compile C to MIPS using Codescape
mips-mti-elf-gcc -std=c11 -S x.c<br>
mips-mti-elf-gcc -std=c11 -march=mips32r2 -S x.c<br>
mips-mti-elf-gcc -std=c11 -fomit-frame-pointer -S x.c<br>
<Attention: this MIPS file cannot run directly on MARS>

## Folder content
 - Assignment2.pdf: our assignment requirement
 - README.md: some notice about the assignment
 - ktmt_11_code.c: contains the problem written in C language, this should not be changed instantly
 - ktmt_11_code.s: contains the problem written in MIPS language, which compiled from stringCheck.c, this cannot be run on MARS
 - ktmt_11_C2MIPS.asm: the same content with ktmt_11_code.s; however, it contains comment more clearly than the above
 - ktmt_11_MIPS_MARS.asm: modified compiled file in order to run on MARS MIPS
 - ktmt_11_MIPS_Reorder.asm: reorder ktmt_11_MIPS_MARS instruction
 - ktmt_11_MIPS_Hazard.asm: solve data hazard in ktmt_11_MIPS_MARS
 - ktmt_11_MIPS_final.asm: modified ktmt_11_MIPS_MARS to optimize it
 - stringCheck.jpg: flowchart algorithm image
 - stringCheck.eddx: flowchart algorithm in EDraw extension
 - ktmt_11_assignment2.pdf: our report contains what the lecturer require