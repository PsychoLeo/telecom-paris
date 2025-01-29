main:
	li s0, %lo(tab)  # s0 <- &tab      (Res = 0x0030)
	lw a1, 0(s0)	 # a1 <- MEM[s0]   (Res = 0x000f)
	addi a1, a1, 1   # a1 <- a1 + 1    (Res = 0x0010)
	sw a1, 0(s0)     # MEM[s0] <- a1   (Res = 0x0030) 
	addi a1, a1, 1   # a1 <- a1 + 1    (Res = 0x0011)
	sw a1, 4(s0)     # MEM[s0+4] <- a1 (Res = 0x0034)
	nop   
	nop
	lw a1, 0(s0)     # a1 <- MEM[s0]   (Res = 0x0010)
	lw a2, 4(s0)     # a2 <- MEM[s0+4] (Res = 0x0011)
	nop
	nop
	
.align 4
tab:
	.word 0x000f
	
