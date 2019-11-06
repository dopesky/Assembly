MAX_INT equ 2147483647
CF equ 0xa

%macro define_byte 3 ; defines a byte and its length.
  %1 db %2
  %3 equ $- %1 
%endmacro

%macro define_byte_endl 3 ; defines a byte with a cf and nl character and its length.
  %1 db %2, 0xa, 0xd
  %3 equ $- %1 
%endmacro

%macro define_word_array 2 ; defines a zero-filled array of length %2
  %1 times %2 dw 0
%endmacro

%macro cout 2 ; outputs %1 to console.
  mov eax, 4
  mov ebx, 1
  mov ecx, %1
  mov edx, %2
  int 80h
%endmacro

%macro cin 2 ; prompts user for input and stores it at the top of the stack
  mov eax, 3
  mov ebx, 0
  mov ecx, %1
  mov edx, %2
  int 80h
%endmacro

%macro cin_num 2
  cin %1, %2
  lea esi, [%1]
  call readNum
  push ebx
%endmacro

%macro cin_int 2
  cin %1, %2
  lea esi, [%1]
  call readInt
  push ebx
%endmacro

%macro exit 1 ; exits the program with exit code %1
  mov eax, 1
  mov ebx, %1
  int 80h
%endmacro

readNum:
  xor ebx,ebx

  movzx eax, byte [esi]
  cmp eax, '-'
  jnz .next_digit
  inc esi

  .next_digit:
    movzx eax, byte [esi]

    cmp al, '9'
    jg .exit

    sub al, '0'
    js .exit

    imul ebx, 10
    add ebx, eax

    cmp ebx, MAX_INT
    jg .exit

    inc esi
    cmp byte [esi], CF
    jne .next_digit
    ret
  .exit:
    mov ebx, CF
    ret

readInt:
  xor ebx,ebx
  xor ecx, ecx

  movzx eax, byte [esi]
  cmp eax, '-'
  jnz .next_digit
  inc esi
  mov ecx, '-'

  .next_digit:
    movzx eax, byte [esi]

    cmp al, '9'
    jg .exit

    sub al, '0'
    js .exit

    imul ebx, 10
    add ebx, eax

    cmp ebx, MAX_INT
    jg .exit

    inc esi
    cmp byte [esi], CF
    jne .next_digit
    cmp ecx, '-'
    jnz .ret
    neg ebx
    .ret:
      ret
  .exit:
    mov ebx, CF
    ret