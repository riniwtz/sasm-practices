; shift bits in iteration until it is complete

%include "io64.inc"

default rel
section .text
global main
main:
    GET_HEX 8, rax

    ; set loop limit
    ; 64d converts to 0x40
       
    ; clear whole r10 in case of garbage
    xor r10d, r10d
    
    mov ecx, 64
     
again:
    ; shift bit to right
    shr rax, 1
    ; read carry flag, if lsb = 0 then skip
    jnc skip
    inc r10

skip:
    loop again
    
    ; run after all iters
    ; check if lsb is 1 in r10b loc
    test r10b, 1
    jz even
    
    PRINT_STRING "Parity: Odd parity"
    jmp done
    
even:
    PRINT_STRING "Parity: Even parity"
    
done:
    xor eax, eax
    ret
