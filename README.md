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
 - stringCheck.c: contains the problem written in C language, this should not be changed instantly
 - stringCheck.s: contains the problem written in MIPS language, which compiled from stringCheck.c, this cannot be run on MARS
 - stringCheck_backup.s: the same content with stringCheck.s; however, it contains comment more clearly than the above
 - stringCheck.jpg: flowchart algorithm image
 - stringCheck.eddx: flowchart algorithm in EDraw extension
 - stringCheck.asm: (not yet) adjust stringCheck.s in order to run on MARS, as well as optimize it
 - baocao.pdf: our report contains what the lecturer require