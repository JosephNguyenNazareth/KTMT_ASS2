# KTMT_ASS2
Compile C to MIPS Assemply

Compile C to MIPS using Codescape
mips-mti-elf-gcc -std=c11 -march=mips32r2 -S x.c
mips-mti-elf-gcc -std=c11 -fomit-frame-pointer -S x.c
<Attention: this MIPS file cannot run directly on MARS>