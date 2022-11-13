	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	max_length
	.section	.rodata
	.align 4
	.type	max_length, @object
	.size	max_length, 4
max_length:
	.long	10
	.align 8
.LC0:
	.string	"You input a not number.\nnumber = "
	.align 8
.LC1:
	.string	"You input a number which more than length of text.\nnumber = "
	.align 8
.LC2:
	.string	"A negative number cannot be the number of a text element.\nnumber = "
	.text
	.globl	inputNumber
	.type	inputNumber, @function
inputNumber:
	push	rbp

	mov	rbp, rsp					; ��������� ��������� ��������� � �����
	push	rbx
	sub	rsp, 72
	mov	QWORD PTR -72[rbp], rdi		; ������������� count (�������� � �������)
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -24[rbp], rax		
	xor	eax, eax
	mov	rax, rsp
	mov	rbx, rax

	mov	eax, 10
	cdqe
	sub	rax, 1
	mov	QWORD PTR -48[rbp], rax		; �������� ��������� is_correct
	mov	eax, 10
	cdqe
	mov	r10, rax
	mov	r11d, 0
	mov	eax, 10
	cdqe
	mov	r8, rax
	mov	r9d, 0
	mov	eax, 10
	cdqe
	mov	edx, 16
	sub	rdx, 1
	add	rax, rdx
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L2:
	cmp	rsp, rdx
	je	.L3
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L2
.L3:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L4
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L4:
	mov	rax, rsp
	add	rax, 0
	mov	QWORD PTR -40[rbp], rax
.L9:							 ; ���� while
	mov	rax, QWORD PTR -40[rbp]  ;��������� � ������� buf
	mov	rdi, rax
	mov	eax, 0
	call	gets@PLT

	mov	rax, QWORD PTR -40[rbp]	; ��������� � ������� �������� buf
	mov	rdi, rax
	call	atol@PLT

	mov	QWORD PTR -32[rbp], rax	; number == 0 (��������� � number ��������)
	cmp	QWORD PTR -32[rbp], 0	; ���������������� ���������
	jne	.L5						; ������� ������ �� ��������� �������

	mov	rax, QWORD PTR -40[rbp] ; ������� buf[0] != '0' 
	movzx	eax, BYTE PTR [rax]
	cmp	al, 48					; ���������������� ���������
	je	.L5						; ������� ������ �� ��������� �������

	lea	rax, .LC0[rip]			; ������� � ������� ������
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT			; ������� �������

	mov	BYTE PTR -49[rbp], 70	; is_correct = 'F'

	jmp	.L6						; �������� �� �������� while
.L5:							; ����� ������� ����� ������ ������ ������
	mov	rax, QWORD PTR -32[rbp]	; ��������� � ������� �������� number
	cmp	rax, QWORD PTR -72[rbp]	; �������� number � count
	jle	.L7						; ������� ������, ���� ������� �� ������
	
	lea	rax, .LC1[rip]			; �������� ������ � �������
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT			; ������� �������

	mov	BYTE PTR -49[rbp], 70	; is_correct = 'F'
	jmp	.L6						; ������� � ����� while
.L7:							; ����� ������� ���������� �����
	cmp	QWORD PTR -32[rbp], 0	; number < 0
	jns	.L8						; ������� � ��������� ����� else

	lea	rax, .LC2[rip]			; �������� � ������� ������
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT			; ������� �������

	mov	BYTE PTR -49[rbp], 70   ; is_correct = 'F'
	jmp	.L6						; ������� � �������� ������� while
.L8:							; else
	mov	BYTE PTR -49[rbp], 84	; is_correct = 'T'
.L6:							; ���� while
	cmp	BYTE PTR -49[rbp], 70	; ���������� is_correct == 'F'
	je	.L9						; ������� � �������� ������� while

	mov	rax, QWORD PTR -32[rbp] ; ��������� �������� number � rax
	mov	rsp, rbx
	mov	rdx, QWORD PTR -24[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	mov	rbx, QWORD PTR -8[rbp]  ; ���������� �������� �� �������
	leave
	ret
	.size	inputNumber, .-inputNumber
	.section	.rodata
	.align 8
.LC3:
	.string	"Enter text (To complete the text input, type ^END^): "
.LC4:
	.string	"-----------------"
	.align 8
.LC5:
	.string	"\nEnter the segment you want to flip (0, %d)\n"
.LC6:
	.string	"Enter the first number = "
.LC7:
	.string	"\nEnter the second number = "
.LC8:
	.string	"finish."
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80

	mov	DWORD PTR -80[rbp], 0				; ������� count = 0
	mov	QWORD PTR -32[rbp], 10000			; ������� size = 10000

	lea	rax, .LC3[rip]						; �������� ������ � printf
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						; �������� �������

	mov	rax, QWORD PTR -32[rbp]				; �������� �������� size � �������
	mov	rdi, rax
	call	malloc@PLT						; �������� �������
	mov	QWORD PTR -24[rbp], rax				; ���������� �������� �� ������� � ������
	jmp	.L13								; ��������� � ������� ����� while
.L15:										; ���� ����� while
	mov	eax, DWORD PTR -80[rbp]				; ����� �������� count
	movsx	rdx, eax						; ����������� ���
	mov	rax, QWORD PTR -24[rbp]				; ���� ������ �� ������
	add	rax, rdx							; ������ �������� �� �������
	mov	edx, DWORD PTR -68[rbp]				; ����� �������� symbol, ������������� ��� � char
	mov	BYTE PTR [rax], dl					; ��������� � ������� ������ �������� symbol
	add	DWORD PTR -80[rbp], 1				; count ��������� 1
	mov	eax, DWORD PTR -80[rbp]				;

											; ������� �
	cdqe
	lea	rdx, -1[rax]						; ��������� � ������� count - 1
	mov	rax, QWORD PTR -24[rbp]				; ���� ������ �� ������ stroka
	add	rax, rdx							; ������ �������� �� �������
	movzx	eax, BYTE PTR [rax]				; ���������� ������
	cmp	al, 94								; ������� stroka[count - 1] == '^'
	jne	.L13								; ������� � ���� �����, ���� �������
	mov	eax, DWORD PTR -80[rbp]				;

	cdqe
	lea	rdx, -2[rax]						; ��������� � ������� count - 2
	mov	rax, QWORD PTR -24[rbp]				; ���� ������ �� ������ stroka
	add	rax, rdx							; ������ �������� �� �������
	movzx	eax, BYTE PTR [rax]				; ���������� ������
	cmp	al, 68								; ��������� �������� � 'D'
	jne	.L13								; ������� � ���� �����, ���� ������� �������
	mov	eax, DWORD PTR -80[rbp]				;

	cdqe
	lea	rdx, -3[rax]						; ��������� � ������� count - 3
	mov	rax, QWORD PTR -24[rbp]				; ���� ������ �� ������ stroka
	add	rax, rdx							; ������ �������� �� �������
	movzx	eax, BYTE PTR [rax]				; ���������� ������
	cmp	al, 78								; ��������� �������� � 'N'
	jne	.L13								; ������� � ���� �����, ���� ������� �������
	mov	eax, DWORD PTR -80[rbp]				;

	cdqe									
	lea	rdx, -4[rax]						; ��������� � ������� count - 4
	mov	rax, QWORD PTR -24[rbp]				; ���� ������ �� ������ stroka
	add	rax, rdx							; ������ �������� �� �������
	movzx	eax, BYTE PTR [rax]				; ���������� ������
	cmp	al, 69								; ��������� �������� � 'E'
	jne	.L13								; ������� � ���� �����, ���� ������� �������
	mov	eax, DWORD PTR -80[rbp]

	cdqe
	lea	rdx, -5[rax]						; ��������� � ������� count - 5
	mov	rax, QWORD PTR -24[rbp]				; ���� ������ �� ������ stroka
	add	rax, rdx							; ������ �������� �� �������
	movzx	eax, BYTE PTR [rax]				; ���������� ������
	cmp	al, 94								; ������� stroka[count - 1] == '^'
	jne	.L13								; ��������� � ������� ����� while, ���� ������� �� �����

	sub	DWORD PTR -80[rbp], 5				; �������� �� count 5-��
	jmp	.L14								; ������� �� ����� while
.L13:										; ������� ����� while
	call	getchar@PLT						; ��������� �������� � ����������
	mov	DWORD PTR -68[rbp], eax				; ���������� �������� �� getchar

	cmp	DWORD PTR -68[rbp], -1				; ���������� symbol � -1
	jne	.L15								; ���� ������� ��������� ������, �� ������� � ���� �����

	mov	eax, DWORD PTR -80[rbp]				; ���� �������� count
	cdqe
	cmp	QWORD PTR -32[rbp], rax				; ������� count < size
	ja	.L15								; ������� � ���� �����, ���� ������� ������ 
.L14:
	call	getchar@PLT						; ������� ������� getchar (������ ��� �������� ������)

	lea	rax, .LC4[rip]						; �������� ������ � �������
	mov	rdi, rax
	call	puts@PLT						; �������� "-------"

	mov	DWORD PTR -76[rbp], 0				; � i �������� 0
	jmp	.L16								; ������� � ������� ����� for
.L17:										; ���� ����� for
	mov	eax, DWORD PTR -76[rbp]				; ����� ������� �������� i
	movsx	rdx, eax						; ����������� i
	mov	rax, QWORD PTR -24[rbp]				; ����� ����� ������ �������
	add	rax, rdx							; ����� ������� �� �������
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax							; �������� �������� �������� �������� ������� � �������
	call	putchar@PLT						; ������� �������

	add	DWORD PTR -76[rbp], 1				; ++i
.L16:										; ������� ����� for
	mov	eax, DWORD PTR -76[rbp]				; � eax �������� i
	cmp	eax, DWORD PTR -80[rbp]				; ���������� i � count
	jl	.L17								; ���� count < i, �� ������� � ����

	lea	rax, .LC4[rip]						; ����� ����� ��������� "-------"
	mov	rdi, rax
	call	puts@PLT						; ������ ���������

	; ����� ��������� �� �������� ���������
	mov	eax, DWORD PTR -80[rbp]				; ����� �������� count
	sub	eax, 1								; ������ �� ����� �������� 1
	mov	esi, eax							; ��������� ��� ��������

	lea	rax, .LC5[rip]						; ����� ����� ���������
	mov	rdi, rax							; ����������� ��������
	mov	eax, 0
	call	printf@PLT						; ������ ��������� �� �����

	mov	QWORD PTR -64[rbp], 0				; N1 = 0
	mov	QWORD PTR -56[rbp], 0				; N2 = 0

	lea	rax, .LC6[rip]						; ����� ����� ��������� (���� ������� �����)
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						; ������ ��������� �� �����

	mov	eax, DWORD PTR -80[rbp]				; ����� �������� count
	sub	eax, 1								; ������ �� ����� �������� 1

	cdqe
	mov	rdi, rax							; �������� ���������� � �������
	call	inputNumber						; ������� �������
	mov	QWORD PTR -64[rbp], rax				; ������� �� ������� �������� ��� N1

	lea	rax, .LC7[rip]						; ����� ����� ���������  (���� ������� �����)
	mov	rdi, rax
	mov	eax, 0								
	call	printf@PLT						; ������ ��������� �� �����

	mov	eax, DWORD PTR -80[rbp]				; ����� �������� count
	sub	eax, 1								; ������ �� ����� �������� 1
	
	cdqe
	mov	rdi, rax							; �������� �������� count -1 � �������
	call	inputNumber						; ������� �������
	mov	QWORD PTR -56[rbp], rax				; �������� �������� �� ������� ��� N2

	mov	rax, QWORD PTR -64[rbp]				; ����� �������� � N1
	cmp	rax, QWORD PTR -56[rbp]				; �������� N1 > N2
	jle	.L18								; ���� ��� ����, �� ��������� ������

											; ������������ if
	mov	rax, QWORD PTR -64[rbp]				; ����� �������� N1
	mov	QWORD PTR -16[rbp], rax				; ������ long temp = N1
	mov	rax, QWORD PTR -56[rbp]				; ����� N2
	mov	QWORD PTR -64[rbp], rax				; N1 = N2
	mov	rax, QWORD PTR -16[rbp]				; ����� �������� temp
	mov	QWORD PTR -56[rbp], rax				; N2 = temp
.L18:
	mov	rax, QWORD PTR -56[rbp]				; ��������� ���������� N2 - N1 + 1
	sub	rax, QWORD PTR -64[rbp]
	add	rax, 1

	mov	rdi, rax							; ��������� ��������� � �������
	call	malloc@PLT						; ������� �������
	mov	QWORD PTR -8[rbp], rax				; �������� �������� �� �������

	mov	rax, QWORD PTR -56[rbp]				; ����� �������� N2
	mov	QWORD PTR -48[rbp], rax				; ������������������� �� ���������� i
	mov	QWORD PTR -40[rbp], 0				; ������������������ index = 0
	jmp	.L19								; ����� � ������� ����� for
.L20:
	mov	rdx, QWORD PTR -48[rbp]				; ����� �������� i
	mov	rax, QWORD PTR -24[rbp]				; ����� ����� ������ ������� stroka
	add	rax, rdx							; ����� ����� �������� ������� �� �������
	
	mov	rcx, QWORD PTR -40[rbp]				; ����� �������� index
	mov	rdx, QWORD PTR -8[rbp]				; ����� ����� ������� result_string
	add	rdx, rcx							; �������� ����� �������� ������� �� �������
	movzx	eax, BYTE PTR [rax]				; ����� �������� �� ������� stroka
	mov	BYTE PTR [rdx], al					; ��������� ��� �������� � ������� result_index
	sub	QWORD PTR -48[rbp], 1				; i--
	add	QWORD PTR -40[rbp], 1				; index++

.L19:										; ������� ����� for
	mov	rax, QWORD PTR -48[rbp]				; ����� i
	cmp	rax, QWORD PTR -64[rbp]				; �������� i � N1
	jge	.L20								; ���� i >= N1, �� ������� � ���� �����

	mov	DWORD PTR -72[rbp], 0				; ���������������� ����� i
	jmp	.L21								; ��������� � ������� ��� ����� for
.L22:										; ���� ����� for
	mov	eax, DWORD PTR -72[rbp]				; ���� ���������� i
	movsx	rdx, eax						; �������� � �����
	mov	rax, QWORD PTR -8[rbp]				; �������� ������ ������ ������� result_string
	add	rax, rdx							; �������� ����� �������� ��������

	movzx	eax, BYTE PTR [rax]				; ���������� � ���������� � �������, ����� ������� �� �����
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT

	add	DWORD PTR -72[rbp], 1				; i++
.L21:										; ������� ����� for
	mov	rax, QWORD PTR -56[rbp]				; ���� �������� N2
	sub	rax, QWORD PTR -64[rbp]				; N2 - N1
	mov	rdx, rax							; ���������� ���������
	mov	eax, DWORD PTR -72[rbp]				; ���� ���������� i

	cdqe
	cmp	rdx, rax							; ��������� ���������� � i
	jge	.L22								; ���� i < N2 - N1 + 1, ��������� � ���� �����

	mov	edi, 10								; "\n"
	call	putchar@PLT						; �������� �������

	lea	rax, .LC8[rip]						; ���� ����� ���������
	mov	rdi, rax							; �������� ��������� � �������
	call	puts@PLT						; �������� �������

	mov	rax, QWORD PTR -24[rbp]				; ���� ����� ������ ������� stroka
	mov	rdi, rax							; �������� ��� �������� � �������
	call	free@PLT						; �������� �������
	mov	eax, 0								; return 0		
	
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
