	.file	"SomaMatEWS_Estatico.c"
	.text
	.p2align 4
	.globl	somarMatrizes
	.type	somarMatrizes, @function
somarMatrizes:
.LFB39:
	.cfi_startproc
	endbr64
	movl	%ecx, %eax
	movq	%rdx, %r10
	cltd
	idivl	%r9d
	movl	%eax, %r11d
	imull	%r8d, %r11d
	leal	-1(%r11,%rax), %r9d
	cmpl	%r8d, %edx
	jle	.L2
	addl	%r8d, %r11d
	leal	1(%r9,%r8), %r9d
	cmpl	%r9d, %r11d
	jg	.L23
.L27:
	testl	%ecx, %ecx
	jle	.L23
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	subl	%r11d, %r9d
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	.cfi_offset 15, -24
	movl	%ecx, %r15d
	andl	$-4, %r15d
	pushq	%r14
	.cfi_offset 14, -32
	leal	2(%r15), %r14d
	pushq	%r13
	pushq	%r12
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	movslq	%r15d, %r12
	pushq	%rbx
	.cfi_offset 3, -56
	movslq	%r11d, %rbx
	imulq	$80000, %rbx, %rdx
	andq	$-32, %rsp
	leaq	(%r10,%rdx), %rax
	leaq	32(%r10,%rdx), %r8
	addq	%rdx, %rdi
	addq	%rsi, %rdx
	leaq	(%r9,%rbx), %rsi
	imulq	$80000, %rsi, %rsi
	movl	%r14d, -20(%rsp)
	movslq	%r14d, %r14
	leaq	80000(%r10,%rsi), %rbx
	leal	-1(%rcx), %r10d
	movl	%ecx, %esi
	movl	%r10d, -12(%rsp)
	movq	%rbx, -8(%rsp)
	shrl	$2, %esi
	leal	1(%r15), %ebx
	movl	%ebx, -16(%rsp)
	movslq	%ebx, %r13
	salq	$5, %rsi
	movl	%r10d, %ebx
	.p2align 4,,10
	.p2align 3
.L5:
	leaq	32(%rdi), %r9
	cmpq	%r9, %rax
	setnb	%r10b
	cmpq	%r8, %rdi
	setnb	%r9b
	orl	%r9d, %r10d
	leaq	32(%rdx), %r9
	cmpq	%r9, %rax
	setnb	%r9b
	cmpq	%r8, %rdx
	setnb	%r11b
	orl	%r11d, %r9d
	testb	%r9b, %r10b
	je	.L11
	xorl	%r9d, %r9d
	cmpl	$2, -12(%rsp)
	jbe	.L11
	.p2align 4,,10
	.p2align 3
.L6:
	vmovupd	(%rdi,%r9), %ymm1
	vaddpd	(%rdx,%r9), %ymm1, %ymm0
	vmovupd	%ymm0, (%rax,%r9)
	addq	$32, %r9
	cmpq	%rsi, %r9
	jne	.L6
	cmpl	%r15d, %ecx
	je	.L9
	vmovsd	(%rdi,%r12,8), %xmm0
	vaddsd	(%rdx,%r12,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%r12,8)
	cmpl	-16(%rsp), %ecx
	jle	.L9
	vmovsd	(%rdi,%r13,8), %xmm0
	vaddsd	(%rdx,%r13,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%r13,8)
	cmpl	-20(%rsp), %ecx
	jle	.L9
	vmovsd	(%rdi,%r14,8), %xmm0
	vaddsd	(%rdx,%r14,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%r14,8)
.L9:
	addq	$80000, %rax
	addq	$80000, %rdi
	addq	$80000, %r8
	addq	$80000, %rdx
	cmpq	-8(%rsp), %rax
	jne	.L5
	vzeroupper
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	.cfi_restore_state
	xorl	%r9d, %r9d
	.p2align 4,,10
	.p2align 3
.L8:
	vmovsd	(%rdi,%r9,8), %xmm0
	movq	%r9, %r10
	vaddsd	(%rdx,%r9,8), %xmm0, %xmm0
	vmovsd	%xmm0, (%rax,%r9,8)
	incq	%r9
	cmpq	%r10, %rbx
	jne	.L8
	jmp	.L9
.L2:
	.cfi_def_cfa 7, 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	addl	%edx, %r11d
	addl	%edx, %r9d
	cmpl	%r9d, %r11d
	jle	.L27
.L23:
	ret
	.cfi_endproc
.LFE39:
	.size	somarMatrizes, .-somarMatrizes
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d "
	.text
	.p2align 4
	.globl	imprimirMatriz
	.type	imprimirMatriz, @function
imprimirMatriz:
.LFB40:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L35
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leal	-1(%rsi), %eax
	movq	%rdi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	8(%rdi,%rax,8), %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	leaq	4(,%rax,4), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	leaq	.LC0(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	.p2align 4,,10
	.p2align 3
.L30:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L31:
	movq	(%r14), %rax
	movq	%rbp, %rsi
	movl	(%rax,%rbx), %edx
	movl	$1, %edi
	xorl	%eax, %eax
	addq	$4, %rbx
	call	__printf_chk@PLT
	cmpq	%rbx, %r12
	jne	.L31
	movl	$10, %edi
	addq	$8, %r14
	call	putchar@PLT
	cmpq	%r13, %r14
	jne	.L30
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L35:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret
	.cfi_endproc
.LFE40:
	.size	imprimirMatriz, .-imprimirMatriz
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Uso: %s <tamanho da matriz N>\n"
	.section	.rodata.str1.1
.LC6:
	.string	"%d ; %.10f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB41:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	movabsq	$-2399997952, %r11
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	addq	%rsp, %r11
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	subq	$2112, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	je	.L39
	movq	(%rsi), %rdx
	movl	$1, %edi
	leaq	.LC1(%rip), %rsi
	call	__printf_chk@PLT
	movl	$1, %eax
.L38:
	movq	-56(%rbp), %rcx
	xorq	%fs:40, %rcx
	jne	.L56
	movl	$2400000064, %r11d
	addq	%r11, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L39:
	.cfi_restore_state
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	xorl	%edi, %edi
	movq	%rax, %r13
	movl	%eax, %ebx
	call	time@PLT
	movq	%rax, %rdi
	call	srand@PLT
	leaq	-1600000080(%rbp), %r12
	testl	%r13d, %r13d
	jle	.L41
	movabsq	$-2400000032, %rdx
	leaq	-48(%rbp), %rax
	movl	%r13d, %r8d
	addq	%rax, %rdx
	leaq	-1600000080(%rbp), %r12
	shrl	$2, %r8d
	movl	%r13d, %r10d
	vmovapd	.LC4(%rip), %ymm1
	vmovapd	.LC5(%rip), %ymm0
	vmovsd	.LC2(%rip), %xmm3
	vmovsd	.LC3(%rip), %xmm2
	movq	%r12, %rsi
	movl	%r13d, %r14d
	leal	-1(%r13), %r11d
	salq	$5, %r8
	andl	$-4, %r10d
	xorl	%r9d, %r9d
	movq	%rdx, %rcx
	.p2align 4,,10
	.p2align 3
.L42:
	cmpl	$2, %r11d
	jbe	.L48
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L44:
	vmovapd	%ymm1, (%rdx,%rax)
	vmovapd	%ymm0, (%rsi,%rax)
	addq	$32, %rax
	cmpq	%r8, %rax
	jne	.L44
	movl	%r10d, %edi
	cmpl	%r10d, %r14d
	je	.L43
.L46:
	movslq	%r9d, %rax
	imulq	$10000, %rax, %rax
	movslq	%edi, %r15
	addq	%rax, %r15
	vmovsd	%xmm3, (%rcx,%r15,8)
	vmovsd	%xmm2, -1600000080(%rbp,%r15,8)
	leal	1(%rdi), %r15d
	cmpl	%ebx, %r15d
	jge	.L43
	movslq	%r15d, %r15
	addq	%rax, %r15
	addl	$2, %edi
	vmovsd	%xmm3, (%rcx,%r15,8)
	vmovsd	%xmm2, -1600000080(%rbp,%r15,8)
	cmpl	%edi, %ebx
	jle	.L43
	movslq	%edi, %rdi
	addq	%rax, %rdi
	vmovsd	%xmm3, (%rcx,%rdi,8)
	vmovsd	%xmm2, -1600000080(%rbp,%rdi,8)
.L43:
	incl	%r9d
	addq	$80000, %rdx
	addq	$80000, %rsi
	cmpl	%ebx, %r9d
	jne	.L42
	vzeroupper
.L41:
	call	omp_get_num_threads@PLT
	movl	%eax, %r14d
	call	omp_get_thread_num@PLT
	movl	%eax, %ebx
	call	omp_get_wtime@PLT
	movabsq	$-2400000088, %rax
	vmovsd	%xmm0, (%rax,%rbp)
	movabsq	$-2400000032, %rdi
	leaq	-48(%rbp), %rax
	addq	%rax, %rdi
	leaq	-800000064(%rbp), %rdx
	movl	%r14d, %r9d
	movl	%ebx, %r8d
	movl	%r13d, %ecx
	movq	%r12, %rsi
	call	somarMatrizes
	call	omp_get_wtime@PLT
	movabsq	$-2400000088, %rax
	vsubsd	(%rax,%rbp), %xmm0, %xmm0
	movl	%r14d, %edx
	leaq	.LC6(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	jmp	.L38
.L48:
	xorl	%edi, %edi
	jmp	.L46
.L56:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	0
	.long	1072693248
	.align 8
.LC3:
	.long	0
	.long	1073741824
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC4:
	.long	0
	.long	1072693248
	.long	0
	.long	1072693248
	.long	0
	.long	1072693248
	.long	0
	.long	1072693248
	.align 32
.LC5:
	.long	0
	.long	1073741824
	.long	0
	.long	1073741824
	.long	0
	.long	1073741824
	.long	0
	.long	1073741824
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
