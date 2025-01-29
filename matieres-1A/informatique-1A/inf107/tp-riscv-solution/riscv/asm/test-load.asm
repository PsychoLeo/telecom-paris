main:
	li s0, %lo(tab)  # s0 <- &tab
	lw a0, 0(s0)     # a0 <- MEM[s0]   (= tab[0])
	lw a1, 4(s0)     # a1 <- MEM[s0+4] (= tab[1])
	add a2, a0, a1   # a2 <- a0 + a1   (Res = )
	nop
	nop
	nop
	nop

	.align 4
tab:
	.word 0xcafe0123
	.word 0x5a5a5a5a
