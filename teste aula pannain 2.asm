.MODEL SMALL
.STACK 100H

PULA_LINHA MACRO  

    MOV AH,2                 
    MOV DL,10 
    INT 21H 

ENDM

IMPRIMIR MACRO MSG

    MOV AH,9
    LEA DX,MSG
    INT 21H

ENDM

ESPAÇO MACRO
    PUSH AX
    PUSH DX
    MOV AH,2
    MOV DL,' '
    INT 21H
    POP DX
    POP AX

ENDM

LIMPA MACRO
    mov ah, 06h       ; Função para scroll up
    mov al, 0         ; Número de linhas (0 limpa toda a tela)
    mov bh, 07h       ; Atributo de fundo (branco no preto, por exemplo)
    mov cx, 0         ; Linha superior da área a ser limpa
    mov dh, 24        ; Linha inferior (última linha)
    mov dl, 79        ; Coluna inferior (última coluna)
    int 10h           ; Chamada da interrupção de vídeo
ENDM

SOBE MACRO
    mov ah, 02h       ; Função para mover o cursor
    mov bh, 0         ; Página do vídeo (0 = página principal)
    mov dx, 0         ; Linha 0 (primeira linha)
    int 10h           ; Chamada da interrupção para posicionar o cursor
ENDM

TAB MACRO
    PUSH AX 
    PUSH DX
    MOV AH, 02H          ; Função para mover o cursor
    MOV BH, 0            ; Página de vídeo 0
    MOV DH, 4          ; Linha central da tela
    MOV DL, 26           ; Coluna central para início da mensagem
    INT 10H              ; Move o cursor para a posição central
    POP DX
    POP AX
ENDM
.DATA 

JOGO0   DB     10 DUP('o')                   ; Linha vazia
        DB     10 DUP('o')                   ; Linha vazia
        DB     10 DUP('o')                   ; Linha vazia
        DB     10 DUP('o')                   ; Linha vazia
        DB     10 DUP('o')                   ; Linha vazia
        DB     10 DUP('o')                   ; Linha vazia
        DB     10 DUP('o')                   ; Linha vazia
        DB     10 DUP('o')                   ; Linha vazia
        DB     10 DUP('o')                   ; Linha vazia
        DB     10 DUP('o')                   ; Linha vazia


JOGO1   DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     3  DUP ('.'), 4 DUP ('#'), 2  DUP ('.'), '#'              ;LINHA COM ENCOURAÇADO(HORIZONTAL) E PARTE DO SUBMARINO 1(VERTICAL)
        DB     9  DUP ('.'), '#'                                         ;LINHA COM A OUTRA PARTE DO SUBMARINO 1(VERTICAL)
        DB     '.', '#', 8 DUP('.')                                      ;LINHA COM PARTE1 DO HIDROAVIÃO 1(VERTICAL)
        DB     '.', 2 DUP ('#'), 2 DUP ('.'), 3 DUP ('#'), 2 DUP ('.')   ;LINHA COM PARTE2 DO HIDROAVIÃO 1(VERTICAL) E FRAGATA(HORIZONTAL)
        DB     '.', '#', 8 DUP ('.')                                     ;LINHA COM PARTE3 DO HIDROAVIÃO 1(VERTICAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     6  DUP ('.'), 3 DUP ('#'), '.'                            ;LINHA COM PARTE1 DO HIDROAVIÃO 2(HORIZONTAL)
        DB     2  DUP ('.'), 2 DUP ('#'), 3 DUP ('.'), '#', 2 DUP ('.')  ;LINHA COM SUBMARINO 2(HORIZONTAL) E PARTE2 DO HIDROAVIÃO 2(HORIZONTAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA

JOGO2   DB     2 DUP ('#'), 5 DUP('.'), 3 DUP ('#')  
        DB     8 DUP ('.'), '#', '.'
        DB     10 DUP ('.') 
        DB     10 DUP ('.') 
        DB     3 DUP ('#'), 7 DUP ('.')  
        DB     '.', '#', 4 DUP ('.'), '#', 3 DUP ('.') 
        DB     6 DUP ('.'), '#', 2 DUP('.'), '#' 
        DB     9 DUP ('.'), '#'
        DB     3 DUP ('#'), 6 DUP ('.'), '#' 
        DB     9 DUP ('.'), '#'

JOGO3   DB     6 DUP ('.'), 2 DUP ('#'), 2 DUP ('.')
        DB     3 DUP ('#'), 7 DUP ('.')
        DB     '.','#', 7 DUP ('.'), '#'
        DB     9 DUP ('.'), '#' 
        DB     9 DUP ('.'), '#'   
        DB     2 DUP ('.'), 4 DUP ('#'), 4 DUP ('.')
        DB     10 DUP ('.')
        DB     10 DUP ('.')
        DB     '#', 7 DUP ('.'), '#', '.'
        DB     '#', 6 DUP ('.'),3 DUP ('#')

JOGO4   DB     5 DUP ('.'),'#', 4 DUP ('.')
        DB     '.', 2 DUP ('#'), 2 DUP ('.'),'#', 4 DUP ('.')
        DB     5 DUP ('.'),'#', 4 DUP ('.')
        DB     8 DUP ('.'), '#', '.'
        DB     7 DUP ('.'), 2 DUP ('#'), '.'  
        DB     '#', 2 DUP ('.'), '#', 4 DUP ('.'), '#', '.'
        DB     '#', '.', 3 DUP ('#'), 5 DUP ('.')
        DB     '#',9 DUP ('.')
        DB     '#', 5 DUP ('.'), 2 DUP ('#'), 2 DUP ('.')
        DB     10 DUP ('.')

JOGO5   DB     2 DUP ('#'),8 DUP ('.')
        DB     10 DUP ('.')
        DB     2 DUP ('.'),'#','.', 3 DUP ('#'), 3 DUP ('.')
        DB     2 DUP ('.'),'#',2 DUP ('.'), '#', 4 DUP ('.')
        DB     2 DUP ('.'),'#',7 DUP ('.')  
        DB     '#','.','#',7 DUP ('.')
        DB     '#',9 DUP ('.')
        DB     5 DUP ('.'), '#', 4 DUP ('.')
        DB     4 DUP ('.'), 2 DUP ('#'), 4 DUP ('.')
        DB     3 DUP ('#'), 2 DUP ('.'), '#', 4 DUP ('.')



INICIAL DB 10,13, "                         VAMOS JOGAR BATALHA NAVAL!!! $"

INTRODUCAO DB 10,13, "PARA COMECAR O JOGO, TEMOS UM TABULEIRO DE 20 LINHAS E 20 COLUNAS QUE TERAO AS EMBARCACOES $"

INSTRUCOES DB 10,13, "PARA JOGAR, EH NECESSARIO QUE SE INSIRA O VALOR DA LINHA E COLUNA DESEJADO PARA DAR O TIRO E DESCOBRIR SE FOI ATINGIDO UMA EMBARCACAO, PARA GANHAR EH NECESSARIO QUE SE ACHEM TODAS AS EMBARCACOES $"

COMECO DB 10,13, "             PRESSIONE (1) PARA COMECAR O JOGO OU (0) PARA FINALIZAR:  $ "

INCORRETO DB 10,13, "                     INSIRA UM NUMERO VALIDO PARA PROSSEGUIR:$"

LINHAS DB 10,13, "                       INSIRA A LINHA DESEJADA PARA ATIRAR: $"

COLUNAS DB 10,13, "                      INSIRA A COLUNA DESEJADA PARA ATIRAR: $"

CONSTANTE EQU 10

ACERTOU DB 10,13,'                               VC ACERTOU UM BARCO!!$'

ERROU  DB 10,13,'                             POXA, NAO FOI DESSA VEZ...$'

FINAL DB 10,13,'                                   FIM DE JOGO!$'

DECO DB 10,13,'                          ...............................$'

LATERAIS DB ?

OPÇÕES DB 13,10,'                         ESCOLHA UM TIPO DE JOGO(1-5):$'

NUMJOGO DB 'J','O','G','O',?,'$'

DENOVO DB 13,10,'           QUER JOGAR NOVAMENTE? DIGITE S PARA SIM E N PARA NAO: $'

RESTANTE DB 13,10,'                          NUMERO DE RODADAS RESTANTES: $'


.CODE 

MAIN PROC  

    MOV AX,@DATA
    MOV DS,AX

INICIO:
LIMPA
SOBE 
IMPRIMIR INICIAL

PULA_LINHA    

IMPRIMIR INTRODUCAO 

PULA_LINHA 

IMPRIMIR INSTRUCOES 

PULA_LINHA 

IMPRIMIR COMECO 


CALL @START
;CALL @ESCOLHA
LIMPA
SOBE 
PULA_LINHA

CALL @IMPRIMIR
CALL RODADAS

PULA_LINHA

IMPRIMIR DENOVO

MOV AH,1
INT 21H
CMP AL,'S'
JNE FINALIZA
LIMPA
SOBE 
JMP INICIO
FINALIZA:
    IMPRIMIR FINAL
    MOV AH,4CH
    INT 21H
MAIN ENDP 

@START PROC                                    

VOLTAR:

    MOV AH,1            ; Lê um caractere do teclado
    INT 21H             ; AL contém o caractere digitado
    CMP AL,'1'          ; Compara com o caractere ASCII '1' (49)
    JE COMECA           ; Se for igual a '1', vai para COMECA
    CMP AL,'0'          ; Compara com o caractere ASCII '0' (48)
    JE FINALIZA             ; Se for igual a '0', vai para FIM

    ; Mensagem de erro, entrada inválida
    IMPRIMIR INCORRETO
    JMP VOLTAR           ; Volta para pedir nova entrada

COMECA:
    RET                 ; Retorna para o fluxo principal após entrada válida

@START ENDP

@ESCOLHA PROC
    PUSH CX
    PULA_LINHA
    IMPRIMIR OPÇÕES
PULO:
    MOV AH,1
    INT 21h
    CMP AL, '1'        ; Verifica se o caractere é um dígito
    JNE SALT2
SALT2:
    CMP AL, '2'
    JNE SALT3
SALT3:
    CMP AL, '3'
    JNE SALT4
SALT4:
    CMP AL, '4'
    JNE SALT5
SALT5:
    CMP AL, '5'
    JNE ACAB
ACAB:
    IMPRIMIR INCORRETO
    JMP PULO
    RET
@ESCOLHA ENDP

@COORDENADAS PROC
    PUSH CX
    XOR BX,BX
    MOV CX,CONSTANTE
    PULA_LINHA

@DECO:

    MOV AX,BX
    CALL SAIDEC
    CMP AX,9
    JLE PULODUP
    ESPAÇO
    JMP CONTINUA

PULODUP:

    ESPAÇO
    ESPAÇO

CONTINUA:

    INC BX
    LOOP @DECO
    POP CX
    RET
@COORDENADAS ENDP

@IMPRIMIR PROC
    CALL @COORDENADAS
    IMPRIMIR DECO

    PUSH CX
    XOR BX,BX
    XOR DL,DL
    MOV DI,CONSTANTE
    PULA_LINHA
    mov LATERAIS,41h
    IMPRIME2:
    MOV AH,2
    MOV DL,LATERAIS
    INT 21H
    ADD LATERAIS,1
    MOV AH,2
    MOV DL,'.'
    INT 21H
    ESPAÇO
    XOR SI,SI
    MOV CX,CONSTANTE
    MOV AH,2

IMPRIME:
    MOV DL,JOGO0[BX+SI]
    INT 21H
    ESPAÇO
    ESPAÇO
    INC SI
    LOOP IMPRIME
    PUSH DX
    PULA_LINHA
    POP DX
    ADD BX,CONSTANTE
    DEC DH
    
    DEC DI
    JNZ IMPRIME2
    POP CX
    RET
@IMPRIMIR ENDP

RODADAS PROC

    MOV CX,3

RODADA:

MOV AX,CX
PUSH AX
PULA_LINHA
IMPRIMIR RESTANTE
POP AX
CALL SAIDEC 

PULA_LINHA

    IMPRIMIR LINHAS
    MOV AH,1
    INT 21H
    XOR AH,AH
    SUB AL,65D
    MOV BX,AX
    MOV AX, 10
    MUL BX 
    MOV BX,AX

PULA_LINHA 

    IMPRIMIR COLUNAS
    CALL ENTDEC
    XOR AH,AH  
    MOV SI ,AX
PULA_LINHA 

COMPARA:
    CMP JOGO1[BX+SI],'#'
    JNE VAZIO
    MOV JOGO0[BX+SI],'#'
    CALL @IMPRIMIR
    IMPRIMIR ACERTOU
    DEC CX
    CMP CX,0
    JZ SALTA
    JMP RODADA 

VAZIO:
    MOV JOGO0[BX+SI],'.'
    CALL @IMPRIMIR
    IMPRIMIR ERROU
    DEC CX
    CMP CX,0
    JZ SALTA
    JMP RODADA 

SALTA:
    IMPRIMIR FINAL
    RET

RODADAS ENDP

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

SAIDEC PROC

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    OR AX,AX      
    JGE @END_IF1

    PUSH AX     
    MOV DL, '-'
    MOV AH,2
    INT 21H      
    POP AX          
    NEG AX

@END_IF1:

    XOR CX,CX      
    MOV BX,10
    
@REP1:

    XOR DX,DX     
    DIV BX         
    PUSH DX      
    INC CX        


    OR AX,AX       
    JNE @REP1    
    MOV AH,2

@IMP_LOOP:

    POP DX        
    OR DL,30H
    INT 21H
    LOOP @IMP_LOOP


    POP DX
    POP CX
    POP BX
    POP AX
    RET

SAIDEC ENDP
END MAIN