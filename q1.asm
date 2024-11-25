section .data
    prompt db "Enter a number: ", 0   ; Prompt message
    positive_msg db "POSITIVE", 0      ; Message for positive number
    negative_msg db "NEGATIVE", 0      ; Message for negative number
    zero_msg db "ZERO", 0              ; Message for zero
    newline db 10, 0                   ; Newline character for formatting

section .bss
    num resb 10                        ; Reserve space for user input (supports up to 10 digits)

section .text
    global _start

_start:
    ; Print prompt to ask for input
    mov eax, 4                       ; sys_write system call
    mov ebx, 1                       ; File descriptor 1 (stdout)
    mov ecx, prompt                  ; Pointer to prompt message
    mov edx, 16                      ; Length of the prompt
    int 0x80                          ; Call kernel

    ; Read user input (number)
    mov eax, 3                       ; sys_read system call
    mov ebx, 0                       ; File descriptor 0 (stdin)
    mov ecx, num                     ; Buffer to store input
    mov edx, 10                       ; Max number of bytes to read (support up to 10 digits)
    int 0x80                          ; Call kernel

    ; Null-terminate the input string
    mov byte [num + eax - 1], 0      ; Null-terminate the input string

    ; Check if the input is empty
    cmp byte [num], 0
    je zero_case

    ; Check for negative sign
    mov al, [num]
    cmp al, '-'
    je negative_case

    ; If not negative, proceed to positive number check
    call check_positive

    jmp end_program                  ; Jump to end

negative_case:
    ; Display negative message
    mov eax, 4                       ; sys_write system call
    mov ebx, 1                       ; File descriptor 1 (stdout)
    mov ecx, negative_msg            ; Pointer to "NEGATIVE" message
    mov edx, 8                       ; Length of the message
    int 0x80                          ; Call kernel
    jmp end_program                  ; Jump to end

check_positive:
    ; Check if the first character is zero
    mov al, [num]
    cmp al, '0'
    je zero_case                     ; Jump to zero_case if the number is zero

    ; Display positive message
    mov eax, 4                       ; sys_write system call
    mov ebx, 1                       ; File descriptor 1 (stdout)
    mov ecx, positive_msg            ; Pointer to "POSITIVE" message
    mov edx, 8                       ; Length of the message
    int 0x80                          ; Call kernel
    jmp end_program                  ; Jump to end

zero_case:
    ; Display zero message
    mov eax, 4                       ; sys_write system call
    mov ebx, 1                       ; File descriptor 1 (stdout)
    mov ecx, zero_msg                ; Pointer to "ZERO" message
    mov edx, 4                       ; Length of the message
    int 0x80                          ; Call kernel

end_program:
    ; Print newline for formatting
    mov eax, 4                       ; sys_write system call
    mov ebx, 1                       ; File descriptor 1 (stdout)
    mov ecx, newline                 ; Pointer to newline
    mov edx, 1                       ; Length of newline character
    int 0x80                          ; Call kernel

    ; Exit the program
    mov eax, 1                       ; sys_exit system call
    xor ebx, ebx                     ; Return code 0
    int 0x80                          ; Call kernel
