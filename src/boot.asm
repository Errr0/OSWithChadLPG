; boot.asm
[bits 16]       ; 16-bit mode
[org 0x7C00]    ; load address

start:
    ; Clear screen
    mov ax, 0xB800
    mov es, ax
    xor di, di
    mov cx, 80 * 25
    mov bx, 0x0F   ; white on black
clear_screen:
    mov word [es:di], bx
    add di, 2
    loop clear_screen

    ; Print "Hello, OS!"
    mov si, message
    call print_string
    
    ; Hang the system
hang:
    jmp hang

print_string:
    ; Print string at DS:SI
    mov ah, 0x0E
.print_loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .print_loop
.done:
    ret

message db 'Hello, OS!', 0

times 510 - ($ - $$) db 0 ; Pad to 510 bytes
dw 0xAA55                  ; Boot sector signature
