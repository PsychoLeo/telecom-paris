main:
	addi a0, x0, 17   # a0 <- 17         (Res = 17)
	add  a1, a0, a0   # a1 <- a0 + a0    (Res = 34)
	ori  a3, a1, 0    # a3 <- a1         (Res = 34)
	addi a2, x0, 1    # a2 <- 1          (Res = 1)
	sll  a1, a1, a2   # a1 <- a1 << 1    (Res = 68)
	ori  a4, a1, 0    # a4 <- a1         (Res = 68)
	srli a1, a1, 2    # a1 <- a1 >> 1    (Res = 34)
	slt  x0, a3, a4   # a3 < a4 ?        (Res = 1)
	slt  x0, a4, a3   # a4 < a3 ?        (Res = 0)
	xor  a2, a3, a4   # a2 <- a3 ^ a4    (Res = 102)
	xori x0, a3, 0xff # x0 <- a3 ^ 0xff  (Res = 221)
	ori  a2, x0, 28   # a2 <- 28         (Res = 28)
	and  a2, a2, a0   # a2 <- a2 & a0    (Res = 16)
	andi x0, a3, 0x0f # x0 <- a3 & 0x0f  (Res = 2)
	or   a2, a2, a4   # a2 <- a2 | a4    (Res = 84)
	ori  a5, x0, -1   # a5 <- -1         (Res = -1)
	slti x0, a5, 0    # a5 < 0 ?         (Res = 1)
	sltiu x0, a5, 0   # a5 <u 0 ?        (Res = 0)
	sltu x0, a5, x0   # a5 <u 0 ?        (Res = 0)
	sltu x0, x0, a5   # 0 <u a5 ?        (Res = 1)
	sub  a4, a4, a3   # a4 <- a4 - a3    (Res = 34)
	ori  a1, x0, 3    # a1 <- 3          (Res = 3
    srl  a3, a2, a1   # a3 <- a4 >> 3    (Res = 10)	
    ori  a3, x0, -99  # a3 <- -99        (Res = -99)
    slli a3, a3, 3    # a3 <- a3 << 3    (Res = -792)
	nop
	nop
	nop
	nop
