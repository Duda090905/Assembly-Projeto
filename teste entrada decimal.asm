
; Procedimento de entrada de decimal (ideia 1)
ENTDEC PROC
    PUSH CX
    PUSH BX
    PUSH DX
ENT:
    ; Limpa os registradores BX e CX
    XOR BX, BX
    XOR CX, CX

    ; Leitura do primeiro caractere
    MOV AH, 1
    INT 21h

    ; Checa se o número é negativo
    CMP AL, '-'
    JE NEGT
    CMP AL, '+'
    JE POST
    JMP REP
NEGT:
    MOV CX, 1          ; Marca o número como negativo
POST:
    INT 21h
REP:
    CMP AL, '0'        ; Verifica se o caractere é um dígito
    JNGE NUM
    CMP AL, '9'
    JNLE NUM
    AND AX, 000Fh      ; Converte o caractere em valor numérico
    PUSH AX

    MOV AX, 10
    MUL BX             ; Multiplica BX por 10
    POP BX
    ADD BX, AX         ; Adiciona o dígito convertido

    MOV AH, 1
    INT 21h
    CMP AL, 13         ; Verifica se Enter foi pressionado
    JNE REP

    MOV AX, BX
    OR CX, CX
    JE SAI
    NEG AX             ; Negativar o valor, se necessário
    JMP SAI
NUM:
    MOV AH, 2
    MOV DL, 0Dh        ; Imprime uma nova linha
    INT 21h
    MOV DL, 0Ah
    INT 21h
    JMP ENT
SAI:
    POP DX
    POP BX
    POP CX
    RET
ENTDEC ENDP

;procedimento de entrada de numeros decimais (ideia 2)
EntDec proc
 xor bx, bx
 mov ah,9
 lea dx,msg3
 int 21h

ler_dec:
 mov ah,1
 int 21h
 cmp al, 13
 je fim_dec
 and al, 0Fh
 xor ah, ah
 push ax
 mov ax,10
 mul bx
 pop bx
 add bx, ax
 jmp ler_dec
fim_dec:
 ret
EntDec endp
END MAIN
