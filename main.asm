[org 0x7c00]

mov si, STR
call printf

mov si, STR_B
call printf

jmp $

printf:
    pusha
    str_loop:
      mov al, [si]      ; move first char of STR to a-low
      cmp al, 0         ; look for null terminator
      jne print_char    ; continue to print each char in STR
      popa              ; pop all stack values 
      ret

    print_char:
      mov ah, 0x0E      ; call our BIOS code for cursor shift
      int 0x10          
      add si, 1         ; move forward memory location by one
      jmp str_loop

STR: db 'Bootsector loaded successfully', 0x0A, 0x0D, 0
STR_B: db "Dummy OS - Power off the machine to load a real OS", 0x0A, 0x0D, 0 

; padding & magic number
times 510-($-$$) db 0
dw 0xAA55 ; initiliaze boot sector


