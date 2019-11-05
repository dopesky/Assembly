%macro add_nums 2 ; adds 2 numbers from the top of the stack and stores the result in %1
  pop eax
  pop ebx
  add eax, ebx
  mov edi, %1
  call num2str
  sub edi, %1
  mov [%2], edi
  int 80h
%endmacro

%macro subtract_nums 2 ; subtracts 2 numbers from the top of the stack and stores the result in %1
  pop ebx
  pop eax
  sub eax, ebx
  mov edi, %1
  call num2str
  sub edi, %1
  mov [%2], edi
  int 80h
%endmacro

%macro multiply_nums 2 ; multiplies 2 numbers from the top of the stack and stores the result in %1
  pop eax
  pop ebx
  mul ebx
  mov edi, %1
  call num2str
  sub edi, %1
  mov [%2], edi
  int 80h
%endmacro
%macro divide_nums 2 ;divides 2 numbers from the top of the stack and stores the result in %1
  mov edx, 0
  pop ebx
  pop eax
  div ebx
  push edx
  mov edi, %1
  call num2str
  dec edi
  mov byte [edi], 'r'
  inc edi
  pop eax
  call num2str
  sub edi, %1
  mov [%2], edi
  int 80h
%endmacro

num2str: ; converts the byte in eax register to a string in the edi register
  xor ecx, ecx ; clear the ecx register
  mov ebx, 10 ; initialize the divisor to 10
  .loop1:
    xor edx, edx
    div ebx ; divide the contents of eax with ebx.
    push edx ; push the remainder to the stack
    inc ecx ; increment the counter so we use it in loop2
    test eax, eax ; test if eax is 0 to indicate end of loop
    jnz .loop1

  .loop2:
    pop edx ; pop the top of stack
    add edx, '0' ; we assume the result was in decimal thus we convert it back to ascii;
    mov [edi], edx
    inc edi
    loop .loop2
  mov byte [edi], 0xa
  inc edi
  mov byte [edi], 0
  ret




