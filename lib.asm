%macro define_byte 3 ; defines a byte and its length.
  %1 db %2
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
%macro exit 1 ; exits the program with exit code %1
  mov eax, 1
  mov ebx, %1
  int 80h
%endmacro
readNum:
  xor ebx,ebx
  .next_digit:
    movzx eax, byte [esi]
    inc esi
    sub al, '0'
    imul ebx, 10
    add ebx, eax
    cmp byte [esi], 0xA
    jne .next_digit
    ret
readInt:
  xor ebx,ebx
  xor ecx, ecx
  movzx eax, byte [esi]
  xor eax, '-'
  jnz .next_digit
  inc esi
  ;do negative conversions
  .next_digit:
    movzx eax, byte [esi]
    sub al, '0'
    imul ebx, 10
    add ebx, eax
    inc ecx
    
    inc esi
    cmp byte [esi], 0xA
    jne .next_digit
    ret

