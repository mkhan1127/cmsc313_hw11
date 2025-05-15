section .data
inputBuf:    db  0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
inputLen:    equ 8

section .bss
outputBuf:   resb 80

section .text
global _start

_start:
    mov esi, inputBuf
    mov edi, outputBuf
    mov ecx, inputLen

translate_loop:
    lodsb
    mov ah, al

    ; isolates and translates 1st 4 bits
    shr al, 4
    cmp al, 9
    jbe high_is_digit
    add al, 0x37
    jmp store_high
high_is_digit:
    add al, 0x30
store_high:
    stosb

    ; isolates and translates 2nd 4 bits
    mov al, ah
    and al, 0x0F
    cmp al, 9
    jbe low_is_digit
    add al, 0x37
    jmp store_low
low_is_digit:
    add al, 0x30
store_low:
    stosb

    ; adds a space after each byte
    mov al, ' '
    stosb

    loop translate_loop

    ; replacec final space with newline
    dec edi
    mov byte [edi], 0x0A

    ; write formatted ASCII hex output to stdout
    mov eax, 4
    mov ebx, 1
    mov ecx, outputBuf
    mov edx, inputLen
    imul edx, edx, 3
    int 0x80

    ; exits program
    mov eax, 1
    xor ebx, ebx
    int 0x80
