	.file	"MultMatEWS_Estatico_v3.c"
	.text
	.p2align 4
	.type	multiplicarMatrizes._omp_fn.0, @function
multiplicarMatrizes._omp_fn.0:
.LFB44:
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
	andq	$-32, %rsp
	subq	$32, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	24(%rdi), %ebx
	movq	16(%rdi), %r12
	movq	8(%rdi), %r13
	movq	(%rdi), %r15
	call	omp_get_num_threads@PLT
	movl	%eax, %r14d
	call	omp_get_thread_num@PLT
	movl	%eax, %esi
	movl	%ebx, %eax
	cltd
	idivl	%r14d
	movl	%esi, %ecx
	imull	%eax, %ecx
	leal	-1(%rcx,%rax), %eax
	cmpl	%edx, %esi
	jge	.L22
	addl	%esi, %ecx
	leal	1(%rsi,%rax), %edx
.L12:
	cmpl	%edx, %ecx
	jge	.L19
	testl	%ebx, %ebx
	jle	.L19
	leal	-1(%rdx), %eax
	movslq	%ecx, %rsi
	subl	%ecx, %eax
	addq	%rsi, %rax
	imulq	$80000, %rax, %rax
	imulq	$80000, %rsi, %r9
	movl	%ebx, %r10d
	leaq	80000(%r15,%rax), %rax
	movq	%rax, 16(%rsp)
	movl	%ebx, %eax
	shrl	$2, %eax
	salq	$5, %rax
	movq	%rax, 24(%rsp)
	addq	%r9, %r12
	addq	%r15, %r9
	leal	-1(%rbx), %r15d
	movq	%r15, %r14
	andl	$-4, %r10d
	vxorpd	%xmm4, %xmm4, %xmm4
	.p2align 4,,10
	.p2align 3
.L9:
	movq	24(%rsp), %rax
	movq	%r13, %rsi
	addq	%r9, %rax
	xorl	%edx, %edx
	cmpl	$2, %r14d
	jbe	.L13
	.p2align 4,,10
	.p2align 3
.L24:
	movq	%rsi, %rcx
	movq	%r9, %rdi
	vmovapd	%xmm4, %xmm1
	.p2align 4,,10
	.p2align 3
.L8:
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
	jne	.L8
	movl	%r10d, %edi
	cmpl	%ebx, %r10d
	je	.L10
.L7:
	movslq	%edi, %rcx
	leaq	(%r9,%rcx,8), %r8
	imulq	$80000, %rcx, %rcx
	vmovsd	(%r8), %xmm5
	leal	1(%rdi), %r11d
	addq	%r13, %rcx
	leaq	(%rcx,%rdx,8), %rcx
	vfmadd231sd	(%rcx), %xmm5, %xmm1
	cmpl	%r11d, %ebx
	jle	.L10
	vmovsd	8(%r8), %xmm6
	addl	$2, %edi
	vfmadd231sd	80000(%rcx), %xmm6, %xmm1
	cmpl	%edi, %ebx
	jle	.L10
	vmovsd	160000(%rcx), %xmm7
	vfmadd231sd	16(%r8), %xmm7, %xmm1
.L10:
	vmovsd	%xmm1, (%r12,%rdx,8)
	leaq	1(%rdx), %rcx
	addq	$8, %rsi
	cmpq	%r15, %rdx
	je	.L23
	movq	%rcx, %rdx
	cmpl	$2, %r14d
	ja	.L24
.L13:
	xorl	%edi, %edi
	vmovapd	%xmm4, %xmm1
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L23:
	addq	$80000, %r9
	addq	$80000, %r12
	cmpq	16(%rsp), %r9
	jne	.L9
	vzeroupper
.L19:
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
.L22:
	.cfi_restore_state
	addl	%edx, %ecx
	addl	%eax, %edx
	jmp	.L12
	.cfi_endproc
.LFE44:
	.size	multiplicarMatrizes._omp_fn.0, .-multiplicarMatrizes._omp_fn.0
	.p2align 4
	.globl	getValue
	.type	getValue, @function
getValue:
.LFB39:
	.cfi_startproc
	endbr64
	movslq	%esi, %rsi
	imulq	$80000, %rsi, %rsi
	movslq	%edx, %rdx
	addq	%rdi, %rsi
	vmovsd	(%rsi,%rdx,8), %xmm0
	ret
	.cfi_endproc
.LFE39:
	.size	getValue, .-getValue
	.p2align 4
	.globl	setValue
	.type	setValue, @function
setValue:
.LFB40:
	.cfi_startproc
	endbr64
	movslq	%esi, %rsi
	imulq	$80000, %rsi, %rsi
	movslq	%edx, %rdx
	addq	%rdi, %rsi
	vmovsd	%xmm0, (%rsi,%rdx,8)
	ret
	.cfi_endproc
.LFE40:
	.size	setValue, .-setValue
	.p2align 4
	.globl	multiplicarMatrizes
	.type	multiplicarMatrizes, @function
multiplicarMatrizes:
.LFB41:
	.cfi_startproc
	endbr64
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movl	%ecx, 24(%rsp)
	movq	%rdx, 16(%rsp)
	movq	%rsi, 8(%rsp)
	movq	%rdi, (%rsp)
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rsp, %rsi
	leaq	multiplicarMatrizes._omp_fn.0(%rip), %rdi
	call	GOMP_parallel@PLT
	movq	40(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L31
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L31:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE41:
	.size	multiplicarMatrizes, .-multiplicarMatrizes
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%d "
	.text
	.p2align 4
	.globl	imprimirMatriz
	.type	imprimirMatriz, @function
imprimirMatriz:
.LFB42:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L39
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
.L34:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L35:
	movq	(%r14), %rax
	movq	%rbp, %rsi
	movl	(%rax,%rbx), %edx
	movl	$1, %edi
	xorl	%eax, %eax
	addq	$4, %rbx
	call	__printf_chk@PLT
	cmpq	%rbx, %r12
	jne	.L35
	movl	$10, %edi
	addq	$8, %r14
	call	putchar@PLT
	cmpq	%r13, %r14
	jne	.L34
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
.L39:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret
	.cfi_endproc
.LFE42:
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
.LFB43:
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
	je	.L43
	movq	(%rsi), %rdx
	movl	$1, %edi
	leaq	.LC2(%rip), %rsi
	call	__printf_chk@PLT
	movl	$1, %eax
.L42:
	movq	-56(%rbp), %rbx
	xorq	%fs:40, %rbx
	jne	.L60
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
.L43:
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
	jle	.L45
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
.L46:
	cmpl	$2, %r11d
	jbe	.L52
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L48:
	vmovapd	%ymm1, (%rdx,%rax)
	vmovapd	%ymm0, (%rcx,%rax)
	addq	$32, %rax
	cmpq	%rdi, %rax
	jne	.L48
	movl	%r10d, %esi
	cmpl	%r10d, %r13d
	je	.L47
.L50:
	movslq	%r8d, %rax
	imulq	$10000, %rax, %rax
	movslq	%esi, %r15
	addq	%rax, %r15
	vmovsd	%xmm3, (%r9,%r15,8)
	vmovsd	%xmm2, -1600000080(%rbp,%r15,8)
	leal	1(%rsi), %r15d
	cmpl	%ebx, %r15d
	jge	.L47
	movslq	%r15d, %r15
	addq	%rax, %r15
	addl	$2, %esi
	vmovsd	%xmm3, (%r9,%r15,8)
	vmovsd	%xmm2, -1600000080(%rbp,%r15,8)
	cmpl	%esi, %ebx
	jle	.L47
	movslq	%esi, %rsi
	addq	%rax, %rsi
	vmovsd	%xmm3, (%r9,%rsi,8)
	vmovsd	%xmm2, -1600000080(%rbp,%rsi,8)
.L47:
	incl	%r8d
	addq	$80000, %rdx
	addq	$80000, %rcx
	cmpl	%ebx, %r8d
	jne	.L46
	vzeroupper
.L45:
	call	omp_get_wtime@PLT
	movabsq	$-2400000120, %rax
	vmovsd	%xmm0, (%rax,%rbp)
	leaq	-800000064(%rbp), %rdx
	addq	$56, %rax
	movq	%rdx, -32(%rbp,%rax)
	leaq	-48(%rbp), %rbx
	movabsq	$-2400000032, %rdx
	addq	%rbx, %rdx
	movq	%rdx, -48(%rbp,%rax)
	leaq	(%rbx,%rax), %rsi
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	leaq	multiplicarMatrizes._omp_fn.0(%rip), %rdi
	movl	%r12d, -24(%rbp,%rax)
	movq	%r14, -40(%rbp,%rax)
	call	GOMP_parallel@PLT
	call	omp_get_wtime@PLT
	movabsq	$-2400000120, %rax
	vsubsd	(%rax,%rbp), %xmm0, %xmm0
	xorl	%edx, %edx
	leaq	.LC7(%rip), %rsi
	movl	$1, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	jmp	.L42
.L52:
	xorl	%esi, %esi
	jmp	.L50
.L60:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE43:
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
