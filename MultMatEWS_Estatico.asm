	.file	"MultMatEWS_Estatico.c"
	.text
	.p2align 4
	.type	main._omp_fn.0, @function
main._omp_fn.0:
.LFB42:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	andq	$-32, %rsp
	subq	$32, %rsp
	movl	44(%rdi), %r12d
	call	omp_get_num_threads@PLT
	movl	%eax, 40(%rbx)
	call	omp_get_thread_num@PLT
	movl	%eax, %r13d
	call	omp_get_wtime@PLT
	movl	%r12d, %eax
	cltd
	idivl	40(%rbx)
	movq	32(%rbx), %rsi
	movq	24(%rbx), %r10
	movq	16(%rbx), %rcx
	vmovsd	%xmm0, (%rbx)
	movl	%r13d, %edi
	imull	%eax, %edi
	leal	-1(%rdi,%rax), %eax
	cmpl	%edx, %r13d
	jge	.L2
	addl	%r13d, %edi
	leal	1(%r13,%rax), %edx
.L3:
	cmpl	%edi, %edx
	jle	.L4
	testl	%r12d, %r12d
	jle	.L4
	decl	%edx
	movslq	%edi, %r8
	subl	%edi, %edx
	addq	%r8, %rdx
	imulq	$80000, %r8, %rax
	imulq	$80000, %rdx, %rdx
	movl	%r12d, %r11d
	addq	%rax, %rsi
	addq	%rcx, %rax
	leaq	80000(%rcx,%rdx), %rcx
	movl	%r12d, %edx
	shrl	$2, %edx
	movq	%rcx, 16(%rsp)
	salq	$5, %rdx
	leal	-1(%r12), %ecx
	movq	%rdx, 24(%rsp)
	movq	%rcx, 8(%rsp)
	movq	%rcx, %r13
	andl	$-4, %r11d
	.p2align 4,,10
	.p2align 3
.L6:
	movq	24(%rsp), %rcx
	movq	%r10, %rdi
	leaq	(%rcx,%rax), %r14
	xorl	%ecx, %ecx
	cmpl	$2, %r13d
	jbe	.L11
	.p2align 4,,10
	.p2align 3
.L21:
	movq	%rdi, %rdx
	movq	%rax, %r8
	vxorpd	%xmm0, %xmm0, %xmm0
.L8:
	vmovsd	160000(%rdx), %xmm2
	vmovsd	(%rdx), %xmm1
	vmovhpd	240000(%rdx), %xmm2, %xmm2
	vmovhpd	80000(%rdx), %xmm1, %xmm1
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1
	vmulpd	(%r8), %ymm1, %ymm2
	addq	$32, %r8
	addq	$320000, %rdx
	vaddsd	%xmm2, %xmm0, %xmm0
	vunpckhpd	%xmm2, %xmm2, %xmm3
	vextractf128	$0x1, %ymm2, %xmm1
	vaddsd	%xmm3, %xmm0, %xmm0
	vaddsd	%xmm1, %xmm0, %xmm0
	vunpckhpd	%xmm1, %xmm1, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
	cmpq	%r14, %r8
	jne	.L8
	movl	%r11d, %edx
	cmpl	%r12d, %r11d
	je	.L9
.L7:
	movslq	%edx, %r8
	leaq	(%rax,%r8,8), %r9
	imulq	$80000, %r8, %r8
	vmovsd	(%r9), %xmm4
	leal	1(%rdx), %r15d
	addq	%r10, %r8
	leaq	(%r8,%rcx,8), %r8
	vfmadd231sd	(%r8), %xmm4, %xmm0
	cmpl	%r15d, %r12d
	jg	.L19
.L9:
	vmovsd	%xmm0, (%rsi,%rcx,8)
	leaq	1(%rcx), %rdx
	addq	$8, %rdi
	cmpq	8(%rsp), %rcx
	je	.L20
	movq	%rdx, %rcx
	cmpl	$2, %r13d
	ja	.L21
.L11:
	vxorpd	%xmm0, %xmm0, %xmm0
	xorl	%edx, %edx
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L20:
	addq	$80000, %rax
	addq	$80000, %rsi
	cmpq	16(%rsp), %rax
	jne	.L6
	vzeroupper
.L4:
	call	omp_get_wtime@PLT
	vmovsd	%xmm0, 8(%rbx)
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
.L19:
	.cfi_restore_state
	vmovsd	8(%r9), %xmm5
	addl	$2, %edx
	vfmadd231sd	80000(%r8), %xmm5, %xmm0
	cmpl	%edx, %r12d
	jle	.L9
	vmovsd	160000(%r8), %xmm6
	vfmadd231sd	16(%r9), %xmm6, %xmm0
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L2:
	addl	%edx, %edi
	addl	%eax, %edx
	jmp	.L3
	.cfi_endproc
.LFE42:
	.size	main._omp_fn.0, .-main._omp_fn.0
	.p2align 4
	.globl	somarMatrizes
	.type	somarMatrizes, @function
somarMatrizes:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%ecx, %eax
	movl	%ecx, %r10d
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	movq	%rsi, %r11
	pushq	%r14
	pushq	%r13
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	movq	%rdx, %r13
	cltd
	idivl	%r9d
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%eax, %ecx
	imull	%r8d, %ecx
	leal	-1(%rcx,%rax), %eax
	cmpl	%r8d, %edx
	jle	.L23
	addl	%r8d, %ecx
	leal	1(%rax,%r8), %edx
.L24:
	cmpl	%edx, %ecx
	jge	.L39
	testl	%r10d, %r10d
	jle	.L39
	leal	-1(%rdx), %eax
	movslq	%ecx, %rsi
	subl	%ecx, %eax
	addq	%rsi, %rax
	imulq	$80000, %rax, %rax
	imulq	$80000, %rsi, %r9
	leal	-1(%r10), %r15d
	leaq	80000(%rdi,%rax), %rax
	movq	%rax, -16(%rsp)
	movl	%r10d, %eax
	shrl	$2, %eax
	salq	$5, %rax
	movq	%rax, -8(%rsp)
	movl	%r10d, %ebx
	addq	%r9, %r13
	movq	%r15, %r14
	addq	%rdi, %r9
	andl	$-4, %ebx
	vxorpd	%xmm4, %xmm4, %xmm4
	.p2align 4,,10
	.p2align 3
.L27:
	movq	-8(%rsp), %rax
	movq	%r11, %rsi
	addq	%r9, %rax
	xorl	%edx, %edx
	cmpl	$2, %r14d
	jbe	.L34
	.p2align 4,,10
	.p2align 3
.L41:
	movq	%rsi, %rcx
	movq	%r9, %rdi
	vmovapd	%xmm4, %xmm1
	.p2align 4,,10
	.p2align 3
.L29:
	vmovsd	160000(%rcx), %xmm0
	addq	$32, %rdi
	vmovhpd	240000(%rcx), %xmm0, %xmm2
	vmovsd	(%rcx), %xmm0
	addq	$320000, %rcx
	vmovhpd	-240000(%rcx), %xmm0, %xmm0
	vinsertf128	$0x1, %xmm2, %ymm0, %ymm0
	vmulpd	-32(%rdi), %ymm0, %ymm0
	vaddsd	%xmm0, %xmm1, %xmm1
	vunpckhpd	%xmm0, %xmm0, %xmm3
	vextractf128	$0x1, %ymm0, %xmm0
	vaddsd	%xmm3, %xmm1, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm1
	vunpckhpd	%xmm0, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm1
	cmpq	%rax, %rdi
	jne	.L29
	movl	%ebx, %edi
	cmpl	%r10d, %ebx
	je	.L28
.L32:
	movslq	%edi, %rcx
	leaq	(%r9,%rcx,8), %r8
	imulq	$80000, %rcx, %rcx
	vmovsd	(%r8), %xmm5
	leal	1(%rdi), %r12d
	addq	%r11, %rcx
	leaq	(%rcx,%rdx,8), %rcx
	vfmadd231sd	(%rcx), %xmm5, %xmm1
	cmpl	%r12d, %r10d
	jle	.L28
	vmovsd	8(%r8), %xmm6
	addl	$2, %edi
	vfmadd231sd	80000(%rcx), %xmm6, %xmm1
	cmpl	%edi, %r10d
	jle	.L28
	vmovsd	160000(%rcx), %xmm7
	vfmadd231sd	16(%r8), %xmm7, %xmm1
.L28:
	vmovsd	%xmm1, 0(%r13,%rdx,8)
	leaq	1(%rdx), %rcx
	addq	$8, %rsi
	cmpq	%r15, %rdx
	je	.L31
	movq	%rcx, %rdx
	cmpl	$2, %r14d
	ja	.L41
.L34:
	xorl	%edi, %edi
	vmovapd	%xmm4, %xmm1
	jmp	.L32
	.p2align 4,,10
	.p2align 3
.L31:
	addq	$80000, %r9
	addq	$80000, %r13
	cmpq	-16(%rsp), %r9
	jne	.L27
	vzeroupper
.L39:
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
.L23:
	.cfi_restore_state
	addl	%edx, %ecx
	addl	%eax, %edx
	jmp	.L24
	.cfi_endproc
.LFE39:
	.size	somarMatrizes, .-somarMatrizes
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
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
	jle	.L49
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
	leaq	.LC1(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	.p2align 4,,10
	.p2align 3
.L44:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L45:
	movq	(%r14), %rax
	movq	%rbp, %rsi
	movl	(%rax,%rbx), %edx
	movl	$1, %edi
	xorl	%eax, %eax
	addq	$4, %rbx
	call	__printf_chk@PLT
	cmpq	%rbx, %r12
	jne	.L45
	movl	$10, %edi
	addq	$8, %r14
	call	putchar@PLT
	cmpq	%r13, %r14
	jne	.L44
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
.L49:
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
.LC2:
	.string	"Uso: %s <tamanho da matriz N>\n"
	.section	.rodata.str1.1
.LC7:
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
	subq	$2144, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	je	.L53
	movq	(%rsi), %rdx
	movl	$1, %edi
	leaq	.LC2(%rip), %rsi
	call	__printf_chk@PLT
	movl	$1, %eax
.L52:
	movq	-56(%rbp), %rbx
	xorq	%fs:40, %rbx
	jne	.L70
	movl	$2400000096, %r11d
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
.L53:
	.cfi_restore_state
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	xorl	%edi, %edi
	movq	%rax, %r12
	movl	%eax, %ebx
	call	time@PLT
	movq	%rax, %rdi
	call	srand@PLT
	leaq	-1600000080(%rbp), %r14
	testl	%r12d, %r12d
	jle	.L55
	movabsq	$-2400000032, %rdx
	leaq	-48(%rbp), %rax
	movl	%r12d, %edi
	addq	%rax, %rdx
	leaq	-1600000080(%rbp), %r14
	shrl	$2, %edi
	movl	%r12d, %r10d
	vmovapd	.LC5(%rip), %ymm1
	vmovapd	.LC6(%rip), %ymm0
	vmovsd	.LC3(%rip), %xmm3
	vmovsd	.LC4(%rip), %xmm2
	movq	%r14, %rcx
	movl	%r12d, %r13d
	leal	-1(%r12), %r11d
	salq	$5, %rdi
	andl	$-4, %r10d
	xorl	%r8d, %r8d
	movq	%rdx, %r9
	.p2align 4,,10
	.p2align 3
.L56:
	cmpl	$2, %r11d
	jbe	.L62
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L58:
	vmovapd	%ymm1, (%rdx,%rax)
	vmovapd	%ymm0, (%rcx,%rax)
	addq	$32, %rax
	cmpq	%rdi, %rax
	jne	.L58
	movl	%r10d, %esi
	cmpl	%r10d, %r13d
	je	.L57
.L60:
	movslq	%r8d, %rax
	imulq	$10000, %rax, %rax
	movslq	%esi, %r15
	addq	%rax, %r15
	vmovsd	%xmm3, (%r9,%r15,8)
	vmovsd	%xmm2, -1600000080(%rbp,%r15,8)
	leal	1(%rsi), %r15d
	cmpl	%ebx, %r15d
	jge	.L57
	movslq	%r15d, %r15
	addq	%rax, %r15
	addl	$2, %esi
	vmovsd	%xmm3, (%r9,%r15,8)
	vmovsd	%xmm2, -1600000080(%rbp,%r15,8)
	cmpl	%esi, %ebx
	jle	.L57
	movslq	%esi, %rsi
	addq	%rax, %rsi
	vmovsd	%xmm3, (%r9,%rsi,8)
	vmovsd	%xmm2, -1600000080(%rbp,%rsi,8)
.L57:
	incl	%r8d
	addq	$80000, %rdx
	addq	$80000, %rcx
	cmpl	%ebx, %r8d
	jne	.L56
	vzeroupper
.L55:
	movabsq	$-2400000080, %rbx
	leaq	-48(%rbp), %rax
	leaq	(%rax,%rbx), %rsi
	leaq	-48(%rbp), %rcx
	movabsq	$-2400000032, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp,%rbx)
	xorl	%ecx, %ecx
	leaq	-800000064(%rbp), %rax
	xorl	%edx, %edx
	leaq	main._omp_fn.0(%rip), %rdi
	movq	%rax, -16(%rbp,%rbx)
	movl	%r12d, -4(%rbp,%rbx)
	movq	$0x000000000, -48(%rbp,%rbx)
	movq	$0x000000000, -40(%rbp,%rbx)
	movq	%r14, -24(%rbp,%rbx)
	movl	$0, -8(%rbp,%rbx)
	call	GOMP_parallel@PLT
	vmovsd	-40(%rbp,%rbx), %xmm0
	movl	-8(%rbp,%rbx), %edx
	vsubsd	-48(%rbp,%rbx), %xmm0, %xmm0
	leaq	.LC7(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	jmp	.L52
.L62:
	xorl	%esi, %esi
	jmp	.L60
.L70:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	0
	.long	1072693248
	.align 8
.LC4:
	.long	0
	.long	1073741824
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC5:
	.long	0
	.long	1072693248
	.long	0
	.long	1072693248
	.long	0
	.long	1072693248
	.long	0
	.long	1072693248
	.align 32
.LC6:
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
