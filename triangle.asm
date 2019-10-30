    global _start


    section .text
_start:
    mov rdx,output     ; rdx hold address of next byteto write
    mov r8,1           ; initial line length
    mov r9,0           ; number of stars written on line so far

line:
    mov byte [rdx],"*" ; write single star
    inc rdx            ; advance pointer to next line
    inc r9             ; count number so fa
    cmp r9,r8          ; did we reach tje number of line
    jne line           ; not yet, keep writting on this line

lineDone:
    mov byte [rdx],10  ; write a new line char
    inc rdx            ; and move pointer to where 
    inc r8             ;
    mov r9,0
    cmp r8,maxlines
    jng line

done:
    mov rax, 0x02000004    ; syscall for write
    mov rdi, 1             ; file handle 1 is stdout
    mov rsi, output        ; adress of string to output
    mov rdx, dataSize      ; number of bytes
    syscall
    mov rax, 0x02000001    ; syscall for exit
    xor rdi, rdi
    syscall

    section .bss
maxlines equ 8
dataSize equ 44
output:  resb dataSize
