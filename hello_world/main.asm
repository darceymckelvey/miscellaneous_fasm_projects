;; EXECUTABLE AND LINKABLE FORMAT version 3
;; Defines the output file format as 64-bit ELF executable (standard Linux format)
format ELF64 executable 3

;; ENTRY POINT DEFINITION
;; Tells the linker where program execution should begin
entry start

;; CODE SEGMENT
;; This segment contains executable code and is readable but not writable
segment readable executable

start:
        ;; SYSTEM CALL: WRITE TO STDOUT
        mov rax, 1        ; System call number 1 = sys_write
        mov rdi, 1        ; File descriptor 1 = standard output
        mov rsi, hello    ; Pointer to the message buffer
        mov rdx, hello_len ; Length of message in bytes
        syscall           ; Invoke the kernel to perform the write operation

        ;; SYSTEM CALL: EXIT PROGRAM
        mov rax, 60       ; System call number 60 = sys_exit
        xor rdi, rdi      ; Set rdi to 0 (exit code 0 = success)
                          ; xor is a faster way to zero a register than mov rdi, 0
        syscall           ; Invoke the kernel to terminate the program

;; DATA SEGMENT
;; This segment contains data and is both readable and writable
segment readable writable

hello:
        file "message.txt" ; Include the contents of message.txt at this position
                          ; This creates our string literal from an external file

;; CALCULATE STRING LENGTH
;; $ represents the current address, so this calculates
;; the difference between current position and the start of 'hello'
hello_len = $ - hello     ; Dynamically determine message length at assembly time
