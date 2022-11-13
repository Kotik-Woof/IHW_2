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

	mov	rbp, rsp					; запомнили последнее положение в стеке
	push	rbx
	sub	rsp, 72
	mov	QWORD PTR -72[rbp], rdi				; инициализация count (передача в функцию)
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -24[rbp], rax		
	xor	eax, eax
	mov	rax, rsp
	mov	rbx, rax

	mov	eax, 10
	cdqe
	sub	rax, 1
	mov	QWORD PTR -48[rbp], rax				; создание пременной is_correct
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
.L9:							 		; цикл while
	mov	rax, QWORD PTR -40[rbp]  				; поместили в фунцкию buf
	mov	rdi, rax
	mov	eax, 0
	call	gets@PLT

	mov	rax, QWORD PTR -40[rbp]					; поместили в функцию значение buf
	mov	rdi, rax
	call	atol@PLT

	mov	QWORD PTR -32[rbp], rax					; number == 0 (поместили в number значение)
	cmp	QWORD PTR -32[rbp], 0					; непосредственное сравнение
	jne	.L5							; перешли дальше на следующее условие

	mov	rax, QWORD PTR -40[rbp] 				; строчка buf[0] != '0' 
	movzx	eax, BYTE PTR [rax]
	cmp	al, 48							; непосредственное сравнение
	je	.L5							; перешли дальше на следующее условие

	lea	rax, .LC0[rip]						; помесли в функцию строку
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						; вызвали функцию

	mov	BYTE PTR -49[rbp], 70					; is_correct = 'F'

	jmp	.L6							; прыгнули на проверку while
.L5:									; когда введено число больше длинны текста
	mov	rax, QWORD PTR -32[rbp]					; поместили в регистр значение number
	cmp	rax, QWORD PTR -72[rbp]					; сравнили number с count
	jle	.L7							; перешли дальше, если условие не прошло
		
	lea	rax, .LC1[rip]						; передали строку в функцию
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						; вызвали функцию

	mov	BYTE PTR -49[rbp], 70					; is_correct = 'F'
	jmp	.L6							; перейти к циклу while
.L7:									; когда введено негативное число
	cmp	QWORD PTR -32[rbp], 0					; number < 0
	jns	.L8							; прыгаем в последнюю ветку else

	lea	rax, .LC2[rip]						; передать в функцию строку
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						; вызвать функцию

	mov	BYTE PTR -49[rbp], 70   				; is_correct = 'F'
	jmp	.L6							; перейти к проверке условия while
.L8:									; else
	mov	BYTE PTR -49[rbp], 84					; is_correct = 'T'
.L6:									; цикл while
	cmp	BYTE PTR -49[rbp], 70					; сравниваем is_correct == 'F'
	je	.L9							; прыгаем в проверку условия while

	mov	rax, QWORD PTR -32[rbp] 				; поместили значение number в rax
	mov	rsp, rbx	
	mov	rdx, QWORD PTR -24[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	mov	rbx, QWORD PTR -8[rbp] 					 ; возвращаем значение из функции
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

	mov	DWORD PTR -80[rbp], 0					; строчка count = 0
	mov	QWORD PTR -32[rbp], 10000				; строчка size = 10000

	lea	rax, .LC3[rip]						; помещаем строку в printf
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						; вызываем функцию

	mov	rax, QWORD PTR -32[rbp]					; помещаем значение size в функцию
	mov	rdi, rax
	call	malloc@PLT						; вызываем функцию
	mov	QWORD PTR -24[rbp], rax					; возвращаем значение из функции в массив
	jmp	.L13							; переходим в условие цикла while
.L15:									; тело цикла while
	mov	eax, DWORD PTR -80[rbp]					; взяли значение count
	movsx	rdx, eax						; скопировали его
	mov	rax, QWORD PTR -24[rbp]					; берём ссылку на массив
	add	rax, rdx						; взятие элемента по индексу
	mov	edx, DWORD PTR -68[rbp]					; взяли значение symbol, преобразовали его в char
	mov	BYTE PTR [rax], dl					; перенесли в текущий индекс значение symbol
	add	DWORD PTR -80[rbp], 1					; count прибавили 1
	mov	eax, DWORD PTR -80[rbp]					;

									; условие И
	cdqe
	lea	rdx, -1[rax]						; обращение к индексу count - 1
	mov	rax, QWORD PTR -24[rbp]					; берём ссылку на массив stroka
	add	rax, rdx						; взятие элемента по индексу
	movzx	eax, BYTE PTR [rax]					; копируются данные
	cmp	al, 94							; строчка stroka[count - 1] == '^'
	jne	.L13							; переход в тело цикла, если неверно
	mov	eax, DWORD PTR -80[rbp]					;

	cdqe
	lea	rdx, -2[rax]						; обращение к индексу count - 2
	mov	rax, QWORD PTR -24[rbp]					; берём ссылку на массив stroka
	add	rax, rdx						; взятие элемента по индексу
	movzx	eax, BYTE PTR [rax]					; копируются данные
	cmp	al, 68							; сравнение элемента с 'D'
	jne	.L13							; переход в тело цикла, если условие неверно
	mov	eax, DWORD PTR -80[rbp]					;

	cdqe
	lea	rdx, -3[rax]						; обращение к индексу count - 3
	mov	rax, QWORD PTR -24[rbp]					; берём ссылку на массив stroka
	add	rax, rdx						; взятие элемента по индексу
	movzx	eax, BYTE PTR [rax]					; копируются данные
	cmp	al, 78							; сравнение элемента с 'N'
	jne	.L13							; переход в тело цикла, если условие неверно
	mov	eax, DWORD PTR -80[rbp]					;

	cdqe									
	lea	rdx, -4[rax]						; обращение к индексу count - 4
	mov	rax, QWORD PTR -24[rbp]					; берём ссылку на массив stroka
	add	rax, rdx						; взятие элемента по индексу
	movzx	eax, BYTE PTR [rax]					; копируются данные
	cmp	al, 69							; сравнение элемента с 'E'
	jne	.L13							; переход в тело цикла, если условие неверно
	mov	eax, DWORD PTR -80[rbp]

	cdqe
	lea	rdx, -5[rax]						; обращение к индексу count - 5
	mov	rax, QWORD PTR -24[rbp]					; берём ссылку на массив stroka
	add	rax, rdx						; взятие элемента по индексу
	movzx	eax, BYTE PTR [rax]					; копируются данные
	cmp	al, 94							; строчка stroka[count - 1] == '^'
	jne	.L13							; переходим в условие цикла while, если условие не верно

	sub	DWORD PTR -80[rbp], 5					; вычитаем из count 5-ку
	jmp	.L14							; выходим из цикла while
.L13:									; условие цикла while
	call	getchar@PLT						; считываем значение с клавиатуры
	mov	DWORD PTR -68[rbp], eax					; возвращаем значение из getchar

	cmp	DWORD PTR -68[rbp], -1					; сравниваем symbol и -1
	jne	.L15							; если условие оказалось верным, то заходим в тело цикла

	mov	eax, DWORD PTR -80[rbp]					; берём значение count
	cdqe
	cmp	QWORD PTR -32[rbp], rax					; условие count < size
	ja	.L15							; заходим в тело цикла, если условие верное 
.L14:
	call	getchar@PLT						; вызвали функцию getchar (просто для отчистки потока)

	lea	rax, .LC4[rip]						; передача строки в функцию
	mov	rdi, rax
	call	puts@PLT						; печатаем "-------"

	mov	DWORD PTR -76[rbp], 0					; в i помещаем 0
	jmp	.L16							; заходим в условие цикла for
.L17:									; тело цикла for
	mov	eax, DWORD PTR -76[rbp]					; взяли текущее значение i
	movsx	rdx, eax						; скопировали i
	mov	rax, QWORD PTR -24[rbp]					; взяли адрес начала массива
	add	rax, rdx						; взяли элемент по индексу
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax						; передали значение текущего элемента массива в функцию
	call	putchar@PLT						; вызвали функцию

	add	DWORD PTR -76[rbp], 1					; ++i
.L16:									; условие цикла for
	mov	eax, DWORD PTR -76[rbp]					; в eax помещаем i
	cmp	eax, DWORD PTR -80[rbp]					; сравниваем i и count
	jl	.L17							; если count < i, то заходим в цикл

	lea	rax, .LC4[rip]						; взяли адрес сообщения "-------"
	mov	rdi, rax
	call	puts@PLT						; вывели сообщение

								; вывод сообщения об желаемом интервале
	mov	eax, DWORD PTR -80[rbp]					; взяли значение count
	sub	eax, 1							; отняли из этого значения 1
	mov	esi, eax						; перенесли это значение

	lea	rax, .LC5[rip]						; взяли адрес сообщения
	mov	rdi, rax						; переместили значение
	mov	eax, 0
	call	printf@PLT						; вывели сообщение на экран

	mov	QWORD PTR -64[rbp], 0					; N1 = 0
	mov	QWORD PTR -56[rbp], 0					; N2 = 0

	lea	rax, .LC6[rip]						; взяли адрес сообщения (ввод первого числа)
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT						; вывели сообщение на экран

	mov	eax, DWORD PTR -80[rbp]					; взяли значение count
	sub	eax, 1							; отняли из этого значения 1

	cdqe
	mov	rdi, rax						; передали переменную в функцию
	call	inputNumber						; вызвали функцию
	mov	QWORD PTR -64[rbp], rax					; вернули из функции значение для N1

	lea	rax, .LC7[rip]						; взяли адрес сообщения  (ввод второго числа)
	mov	rdi, rax
	mov	eax, 0								
	call	printf@PLT						; вывели сообщение на экран

	mov	eax, DWORD PTR -80[rbp]					; взяли значение count
	sub	eax, 1							; отняли из этого значения 1
	
	cdqe
	mov	rdi, rax						; передали значение count -1 в функцию
	call	inputNumber						; вызвали функцию
	mov	QWORD PTR -56[rbp], rax					; получили значение из функции для N2

	mov	rax, QWORD PTR -64[rbp]					; взяли значение у N1
	cmp	rax, QWORD PTR -56[rbp]					; сравнили N1 > N2
	jle	.L18							; если это ложь, то переходим дальше

									; внутренность if
	mov	rax, QWORD PTR -64[rbp]					; взяли занчение N1
	mov	QWORD PTR -16[rbp], rax					; строка long temp = N1
	mov	rax, QWORD PTR -56[rbp]					; взяли N2
	mov	QWORD PTR -64[rbp], rax					; N1 = N2
	mov	rax, QWORD PTR -16[rbp]					; взяли значение temp
	mov	QWORD PTR -56[rbp], rax					; N2 = temp
.L18:
	mov	rax, QWORD PTR -56[rbp]					; происходи вычисление N2 - N1 + 1
	sub	rax, QWORD PTR -64[rbp]
	add	rax, 1

	mov	rdi, rax						; поместили результат в функцию
	call	malloc@PLT						; вызвали функцию
	mov	QWORD PTR -8[rbp], rax					; получили значение из функции

	mov	rax, QWORD PTR -56[rbp]					; взяли занчение N2
	mov	QWORD PTR -48[rbp], rax					; проинициализировали им переменную i
	mov	QWORD PTR -40[rbp], 0					; проиницализировали index = 0
	jmp	.L19							; зашли в условие цикла for
.L20:
	mov	rdx, QWORD PTR -48[rbp]					; взяли значение i
	mov	rax, QWORD PTR -24[rbp]					; взяли адрес начала массива stroka
	add	rax, rdx						; взяли адрес элемента массива по индексу
	
	mov	rcx, QWORD PTR -40[rbp]					; взяли занчение index
	mov	rdx, QWORD PTR -8[rbp]					; взяли адрес массива result_string
	add	rdx, rcx						; получили адрес элемента массива по индексу
	movzx	eax, BYTE PTR [rax]					; взяли значение из массива stroka
	mov	BYTE PTR [rdx], al					; присвоили это значение в массива result_index
	sub	QWORD PTR -48[rbp], 1					; i--
	add	QWORD PTR -40[rbp], 1					; index++

.L19:									; условие цикла for
	mov	rax, QWORD PTR -48[rbp]					; взяли i
	cmp	rax, QWORD PTR -64[rbp]					; сравнили i и N1
	jge	.L20							; если i >= N1, то заходим в тело цикла

	mov	DWORD PTR -72[rbp], 0					; инициализировали новую i
	jmp	.L21							; переходим в условие для цикла for
.L22:									; тело цикла for
	mov	eax, DWORD PTR -72[rbp]					; берём переменную i
	movsx	rdx, eax						; копируем её адрес
	mov	rax, QWORD PTR -8[rbp]					; получаем адресс начала массива result_string
	add	rax, rdx						; получаем адрес текущего элемента

	movzx	eax, BYTE PTR [rax]					; преобразум и отправляем в функцию, чтобы вывести на экран
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT

	add	DWORD PTR -72[rbp], 1					; i++
.L21:									; условие цикла for
	mov	rax, QWORD PTR -56[rbp]					; берём значение N2
	sub	rax, QWORD PTR -64[rbp]					; N2 - N1
	mov	rdx, rax						; запоминаем результат
	mov	eax, DWORD PTR -72[rbp]					; берём переменную i

	cdqe
	cmp	rdx, rax						; сравнение результата и i
	jge	.L22							; если i < N2 - N1 + 1, переходим в тело цикла

	mov	edi, 10							; "\n"
	call	putchar@PLT						; вызываем функцию

	lea	rax, .LC8[rip]						; берём адрес сообщения
	mov	rdi, rax						; помещаем сообщение в функцию
	call	puts@PLT						; вызываем функцию

	mov	rax, QWORD PTR -24[rbp]					; берём адрес начала массива stroka
	mov	rdi, rax						; помещаем это значение в функцию
	call	free@PLT						; вызываем функцию
	mov	eax, 0							; return 0		
	
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
