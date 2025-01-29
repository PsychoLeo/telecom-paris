main:
	li   a0, 0x80
	li   a1, 0x70
loop:
	addi a1, a1, 2
	blt  a1, a0, loop
	nop 
	.size	main, .-main
