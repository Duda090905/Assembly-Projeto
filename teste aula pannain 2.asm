TITLE PROJETO FINAL (BATALHA NAVAL)
.MODEL SMALL
.STACK 100H

PULA_LINHA MACRO   ;MACRO CUJA FUNCAO PULA A LINHA

    MOV AH,2                 
    MOV DL,10 
    INT 21H 

ENDM

IMPRIMIR MACRO MSG  ;MACRO CUJA FUNCAO EH IMPRESSAO DE ALGUMA DETERMINADA STRING

    MOV AH,9
    LEA DX,MSG
    INT 21H

ENDM

ESPAÇO MACRO         ;MACRO CUJA FUNCAO EH DAR ESPACO
    PUSH AX
    PUSH DX
    MOV AH,2
    MOV DL,' '
    INT 21H
    POP DX
    POP AX

ENDM

LIMPA MACRO           ;MACRO CUJA FUNCAO EH LIMPAR A TELA
    
    MOV AH, 06h       ; SCROLL UP
    MOV AL, 0         ; LINHAS:0 (PARA LIMPAR A TELA INTEIRA)
    MOV BH, 02H       ; FUNDO DE TELA 
    MOV CX, 0         ; LINHA SUPERIOR 
    MOV DH, 24        ; LINHA INFERIOR
    MOV DL, 79        ; COLUNA INFERIOR
    INT 10h           ; INTERRUPCAO DE VIDEO
ENDM


SOBE MACRO            ;MACRO CUJA FUNCAO EH VOLTAR AO INICIO DA PAGINA

    mov ah, 02h       ; MOVER O CURSOR
    mov bh, 0         ; PAGINA:0 DE VIDEO (PRINCIPAL)
    mov dx, 0         ; LINHA, INDICA QUE ESTARA NO CANTO ESQUERDO SUPERIOR
    int 10h           ; INTERRUPCAO PARA MOVER O CURSOR

ENDM

TABFAKE1 MACRO        ;MACRO CUJA FUNCAO EH SIMULAR UMA CENTRALIZACAO 

    PUSH CX
    PUSH AX
    PUSH DX
    MOV CX,29          ;DISTANCIA DE 29

@FAKE1:

    MOV AH,2
    MOV DL,' '
    INT 21H
    LOOP @FAKE1
    POP DX
    POP AX 
    POP CX

ENDM

TABFAKE2 MACRO          ;MACRO 2 PARA SIMULAR OUTRO TIPO DE CENTRALIZACAO

    PUSH CX
    PUSH AX
    PUSH DX
    MOV CX,26           ;DISTANCIA DE 26

@FAKE2:
    MOV AH,2
    MOV DL,' '
    INT 21H
    LOOP @FAKE2
    POP DX
    POP AX 
    POP CX

ENDM

.DATA 

;JOGO INICIAL DO USUARIO
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

;INDICADOR DE NAVIOS:

; NUMERO 1 = ENCOURAÇADO
; NUMERO 2 = FRAGATA
; NUMERO 3 = SUBMARINO
; NUMERO 4 = HIDROAVIÃO


;JOGO GABARITO 1
JOGO1   DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     3  DUP ('.'), 4 DUP ('1'), 2  DUP ('.'), '3'              ;LINHA COM ENCOURAÇADO(HORIZONTAL) E PARTE DO SUBMARINO 1(VERTICAL)
        DB     9  DUP ('.'), '3'                                         ;LINHA COM A OUTRA PARTE DO SUBMARINO 1(VERTICAL)
        DB     '.', '4', 8 DUP('.')                                      ;LINHA COM PARTE1 DO HIDROAVIÃO 1(VERTICAL)
        DB     '.', 2 DUP ('4'), 2 DUP ('.'), 3 DUP ('2'), 2 DUP ('.')   ;LINHA COM PARTE2 DO HIDROAVIÃO 1(VERTICAL) E FRAGATA(HORIZONTAL)
        DB     '.', '4', 8 DUP ('.')                                     ;LINHA COM PARTE3 DO HIDROAVIÃO 1(VERTICAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     6  DUP ('.'), 3 DUP ('4'), '.'                            ;LINHA COM PARTE1 DO HIDROAVIÃO 2(HORIZONTAL)
        DB     2  DUP ('.'), 2 DUP ('3'), 3 DUP ('.'), '4', 2 DUP ('.')  ;LINHA COM SUBMARINO 2(HORIZONTAL) E PARTE2 DO HIDROAVIÃO 2(HORIZONTAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA

;JOGO GABARITO 2

JOGO2   DB     2 DUP ('3'), 5 DUP('.'), 3 DUP ('4')                      ;LINHA COM SUBMARINO1 (HORIZONTAL) E LINHA PARTE1 DO HIDROAVIAO1 (HORIZONTAL)
        DB     8 DUP ('.'), '4', '.'                                     ;LINHA COM PARTE2 DO HIDROAVIAO1 (HORIZONTAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     3 DUP ('4'), 7 DUP ('.')                                  ;LINHA COM PARTE1 DO HIDROAVIAO2 (HORIZONTAL)
        DB     '.', '4', 4 DUP ('.'), '3', 3 DUP ('.')                   ;LINHA COM PARTE2 DO HIDROAVIAO2 (HORIZONTAL) E LINHA COM PARTE1 DO SUBMARINO2 (VERTICAL)
        DB     6 DUP ('.'), '3', 2 DUP('.'), '1'                         ;LINHA COM PARTE2 DO SUBMARINO2 (VERTICAL) E PARTE1 DO ENCOURACADO (VERTICAL)
        DB     9 DUP ('.'), '1'                                          ;LINHA COM PARTE2 DO ENCOURACADO (VERTICAL)
        DB     3 DUP ('2'), 6 DUP ('.'), '1'                             ;LINHA COM O FRAGATA (HORIZONTAL) E COM PARTE3 DO ENCOURACADO (VERTICAL)
        DB     9 DUP ('.'), '1'                                          ;LINHA COM PARTE4 DO ENCOURACADO (VERTICAL)

JOGO3   DB     6 DUP ('.'), 2 DUP ('3'), 2 DUP ('.')                     ;LINHA COM SUBMARINO1 (HORIZONTAL) 
        DB     3 DUP ('4'), 7 DUP ('.')                                  ;LINHA COM PARTE1 DO HIDROAVIÃO1 (HORIZONTAL)
        DB     '.','4', 7 DUP ('.'), '2'                                 ;LINHA COM PARTE2 DO HIDROAVIÃO1 (HORIZONTAL) E COM PARTE1 DO FRAGATA (VERTICAL)
        DB     9 DUP ('.'), '2'                                          ;LINHA COM PARTE2 DO FRAGATA (VERTICAL)
        DB     9 DUP ('.'), '2'                                          ;LINHA COM PARTE3 DO FRAGATA (VERTICAL)
        DB     2 DUP ('.'), 4 DUP ('1'), 4 DUP ('.')                     ;LINHA COM ENCOURACADO (HORIZONTAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     '3', 7 DUP ('.'), '4', '.'                                ;LINHA COM PARTE1 DO SUBMARINO2 (VERTICAL) E COM PARTE1 DO HIDROAVIÃO2 (HORIZONTAL)
        DB     '3', 6 DUP ('.'),3 DUP ('4')                              ;LINHA COM PARTE2 DO SUBMARINO2 (VERTICAL) E COM PARTE2 DO HIDROAVIÃO2 (HORIZONTAL)

JOGO4   DB     5 DUP ('.'),'2', 4 DUP ('.')                              ;LINHA COM PARTE1 DO FRAGATA (VERTICAL)
        DB     '.', 2 DUP ('3'), 2 DUP ('.'),'2', 4 DUP ('.')            ;LINHA COM SUBMARINO1 (HORIZONTAL) E COM PARTE2 DO FRAGATA (VERTICAL)
        DB     5 DUP ('.'),'2', 4 DUP ('.')                              ;LINHA COM PARTE3 DO FRAGATA (VERTICAL)
        DB     8 DUP ('.'), '4', '.'                                     ;LINHA COM PARTE1 DO HIDROAVIÃO1 (VERTICAL)
        DB     7 DUP ('.'), 2 DUP ('4'), '.'                             ;LINHA COM PARTE2 DO HIDROAVIÃO1 (VERTICAL)
        DB     '1', 2 DUP ('.'), '4', 4 DUP ('.'), '4', '.'              ;LINHA COM PARTE1 DO ENCOURACADO (VERTICAL), COM PARTE1 DO HIDROAVIÃO2 (HORIZONTAL) E PARTE3 DO HIDROAVIÃO1 (VERTICAL)
        DB     '1', '.', 3 DUP ('4'), 5 DUP ('.')                        ;LINHA COM PARTE2 DO ENCOURACADO (VERTICAL) E COM PARTE2 DO HIDROAVIÃO2
        DB     '1',9 DUP ('.')                                           ;LINHA COM PARTE3 DO ENCOURACADO (VERTICAL)
        DB     '1', 5 DUP ('.'), 2 DUP ('3'), 2 DUP ('.')                ;LINHA COM PARTE4 DO ENCOURACADO (VERTICAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA

JOGO5   DB     2 DUP ('3'),8 DUP ('.')                                   ;LINHA COM SUBMARINO1 (HORIZONTAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     2 DUP ('.'),'1','.', 3 DUP ('4'), 3 DUP ('.')             ;LINHA COM PARTE1 DO ENCOURACADO (VERTICAL) E COM PARTE1 DO HIDROAVIÃO1 (HORIZONTAL)
        DB     2 DUP ('.'),'1',2 DUP ('.'), '4', 4 DUP ('.')             ;LINHA COM PARTE2 DO ENCOURACADO (VERTICAL) E COM PARTE2 DO HIDROAVIÃO1 (HORIZONTAL)
        DB     2 DUP ('.'),'1',7 DUP ('.')                               ;LINHA COM PARTE3 DO ENCOURACADO (VERTICAL)
        DB     '3','.','1',7 DUP ('.')                                   ;LINHA COM PARTE1 DO SUBMARINO2 (VERTICAL) E COM PARTE4 DO ENCOURACADO (VERTICAL)
        DB     '3',9 DUP ('.')                                           ;LINHA COM PARTE2 DO SUBMARINO2 (VERTICAL)
        DB     5 DUP ('.'), '4', 4 DUP ('.')                             ;LINHA COM PARTE1 DO HIDROAVIÃO2 (VERTICAL)
        DB     4 DUP ('.'), 2 DUP ('4'), 4 DUP ('.')                     ;LINHA COM PARTE2 DO HIDROAVIÃO2 (VERTICAL)
        DB     3 DUP ('2'), 2 DUP ('.'), '4', 4 DUP ('.')                ;LINHA COM FRAGATA (HORIZONTAL) E COM PARTE3 DO HIDROAVIÃO2 (VERTICAL)


;MATRIZ QUE RECEBE O JOGO QUE SERA ESCOLHIDO PELO USUARIO

JOGOESCOLHIDO       DB 10 DUP (?)
                    DB 10 DUP (?)
                    DB 10 DUP (?)
                    DB 10 DUP (?)
                    DB 10 DUP (?)
                    DB 10 DUP (?)
                    DB 10 DUP (?)
                    DB 10 DUP (?)
                    DB 10 DUP (?)
                    DB 10 DUP (?)


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


ENCOURACADO_ACERTO DB 0
FRAGATA_ACERTO DB 0
SUBMARINO_ACERTO DB 0
HIDROAVIAO_ACERTO DB 0

FIMENCOURACADO DB 10,13,"                            VOCE ACERTOU O ENCOURACADO!! $"
FIMFRAGATA DB 10,13,"                                VOCE ACERTOU O FRAGATA!! $"
FIMSUBMARINO DB 10,13,"                              VOCE ACERTOU O SUBMARINO!! $"
FIMHIDROAVIAO DB 10,13,"                             VOCE ACERTOU O HIDROAVIAO!! $"

FINAL DB 10,13,'                                   FIM DE JOGO!$'

DECO DB 10,13,'                          ...............................$'

LATERAIS DB ?

OPÇÕES DB 13,10,'                         ESCOLHA UM TIPO DE JOGO(1-5):$'

DENOVO DB 13,10,'              QUER JOGAR NOVAMENTE? DIGITE S PARA SIM E N PARA NAO: $'

RESTANTE DB 13,10,'                          NUMERO DE RODADAS RESTANTES: $'


.CODE 

;PROCEDIMENTO PRINCIPAL
MAIN PROC  

    MOV AX,@DATA                       ;INICIALIZACAO DO SEGMENTO DE DADOS
    MOV DS,AX                           
    MOV ES,AX  

INICIO:

    LIMPA                                   ;CHAMADA DE DIFERENTES TIPOS DE MACROS 
    SOBE 
    IMPRIMIR INICIAL

    PULA_LINHA    

    IMPRIMIR INTRODUCAO                     ;IMPRIME A STRING INTRODUCAO

    PULA_LINHA 

    IMPRIMIR INSTRUCOES                     ;IMPRIME A STRING INSTRUCOES 

    PULA_LINHA 

    IMPRIMIR COMECO                         ;IMPRIME A STRING COMECO

;CHAMADA DE DIFERENTES PROCEDIMENTOS


    CALL @START                              ;CHAMADA DO PROCEDIMENTO CUJA FUNCAO EH INICIAR O JOGO OU NAO DE ACORDO COM O USUARIO                 
    CALL ESCOLHA                             ;CHAMADA DO PROCEDIMENTO CUJA FUNCAO EH A ESCOLHA DE QUAL JOGO SERA UTILIZADO

    LIMPA
    SOBE 
    PULA_LINHA

    CALL @IMPRIMIR                           ;CHAMADA DO PROCEDIMENTO CUJA FUNCAO EH A IMPRESSAO DA MATRIZ JOGO0 (ACERTOS E ERROS DO USUARIO)
    CALL RODADAS                             ;CHAMADA DO PROCEDIMENTO CUJA FUNCAO EH RESOLVER QUESTOES RELACIONADAS AS RODADAS DA PARTIDA

PULA_LINHA

IMPRIMIR DENOVO                          ;MACRO QUE IMPRIME A STRING DENOVO 
DNV:
    MOV AH,1                                 ;PERGUNTA SE O USUARIO QUER JOGAR DE NOVO OU NAO (S OU N)
    INT 21H
    CMP AL,'S'                               ;SE S (SIM),CONTINUA
    JNE FINALIZA                             ;SE N (NÃO),PULA PARA 'FINALIZA'
    LIMPA                       
    SOBE 
    JMP INICIO                               ;COMECA NOVAMENTE
FINALIZA:

    CMP AL,'N'                               ;SE IGUAL A 'N', CONTINUA
    JE CONTI
    IMPRIMIR INCORRETO                       ;SE NÃO, IMPRIME A STRING 'INCORRETO' E PEDE PARA O USUARIO DIGITAR O CORRETO NOVAMENTE
    JMP DNV                                 
CONTI:
    LIMPA                   
    SOBE       
    MOV AH,2 
    MOV DH,12                                ;CENTRALIZA A MENSAGEM
    INT 10H
    IMPRIMIR FINAL                           ;IMPRIME A STRING 'FINAL'
    MOV AH,4CH                               ;FINALIZA O PROGRAMA
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

ESCOLHA PROC
    PULA_LINHA
    IMPRIMIR OPÇÕES

ESCOLHER_JOGO:
    MOV AH, 1
    INT 21h
    CMP AL, '1'
    JE ESCOLHA_JOGO1
    CMP AL, '2'
    JE ESCOLHA_JOGO2
    CMP AL, '3'
    JE ESCOLHA_JOGO3
    CMP AL, '4'
    JE ESCOLHA_JOGO4
    CMP AL, '5'
    JE ESCOLHA_JOGO5

    ; Entrada inválida: repetir a pergunta
    IMPRIMIR INCORRETO
    JMP ESCOLHER_JOGO

ESCOLHA_JOGO1:
    LEA SI, JOGO1
    JMP COPIA_JOGO

ESCOLHA_JOGO2:
    LEA SI, JOGO2
    JMP COPIA_JOGO

ESCOLHA_JOGO3:
    LEA SI, JOGO3
    JMP COPIA_JOGO

ESCOLHA_JOGO4:
    LEA SI, JOGO4
    JMP COPIA_JOGO

ESCOLHA_JOGO5:
    LEA SI, JOGO5

COPIA_JOGO:
    LEA DI, JOGOESCOLHIDO
    MOV CX, 100          ; Copiar 100 bytes (10x10)
    REP MOVSB            ; Copiar conteúdo de [SI] para [DI]
    RET
ESCOLHA ENDP


@COORDENADAS PROC
    PUSH CX
    XOR BX,BX
    MOV CX,CONSTANTE
    PULA_LINHA
    TABFAKE1
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
    TABFAKE2
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
    DEC DI
    JNZ IMPRIME2
    POP CX
    RET
@IMPRIMIR ENDP

RODADAS PROC

    MOV CX,2

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

    CMP JOGOESCOLHIDO[BX+SI],'1'
    JE ENCOURACADO
    CMP JOGOESCOLHIDO[BX+SI],'2'
    JE FRAGATA 
    CMP JOGOESCOLHIDO[BX+SI],'3'
    JE SUBMARINO               
    CMP JOGOESCOLHIDO[BX+SI],'4'
    JE  HIDROAVIAO 

    JNE VAZIO 

    ENCOURACADO: 

    INC ENCOURACADO_ACERTO
    CMP ENCOURACADO_ACERTO,4 
    JNE SEGUE   

    IMPRIMIR FIMENCOURACADO

    JMP SEGUE    

    FRAGATA:

    INC FRAGATA_ACERTO
    CMP FRAGATA_ACERTO,3
    JNE SEGUE   

    IMPRIMIR FIMFRAGATA

    JMP SEGUE   

    SUBMARINO: 

    INC SUBMARINO_ACERTO
    CMP SUBMARINO_ACERTO,2 
    JNE SEGUE   


    IMPRIMIR FIMSUBMARINO

    
    MOV SUBMARINO_ACERTO,0

    JMP SEGUE    

HIDROAVIAO: 

    INC HIDROAVIAO_ACERTO
    CMP HIDROAVIAO_ACERTO,4 
    JNE SEGUE   

    IMPRIMIR FIMHIDROAVIAO
    MOV HIDROAVIAO_ACERTO,0

SEGUE:

    PULA_LINHA
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