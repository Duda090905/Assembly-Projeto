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
 JOGO0  DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia
        DB     20 DUP('o')                   ; Linha vazia

JOGO1   DB     6  DUP ('.'), 2 DUP ('#'), 12 DUP ('.')      ; Linha com um submarino
        DB     12 DUP ('.'), 4 DUP ('#'), 4  DUP ('.')      ; Linha com encouraçado
        DB     2  DUP ('.'), 3 DUP ('#'), 15 DUP ('.')      ; Linha com fragata
        DB     20 DUP ('.')                                 ; Linha vazia
        DB     20 DUP ('.')                                 ; Linha vazia
        DB     20 DUP ('.')                                 ; Linha vazia
        DB     3  DUP ('.'), 3 DUP ('#'), 14 DUP ('.')      ; Linha com um hidroavião (horizontal)
        DB     4  DUP ('.'), '#' , 15 DUP ('.')             ; Linha com parte de um hidroavião (horizontal)
        DB     20 DUP ('.')                                 ; Linha vazia
        DB     20 DUP ('.')                                 ; Linha vazia
        DB     20 DUP ('.')                                 ; Linha vazia
        DB     20 DUP ('.')                                 ; Linha vazia 
        DB     9  DUP ('.'), 2 DUP ('#'), 9  DUP ('.')      ; Linha com outro Submarino
        DB     20 DUP ('.')                                 ; Linha vazia
        DB     15 DUP ('.'), '#' , 4 DUP ('.')              ; Linha com parte do outro hidroavião (vertical)
        DB     15 DUP ('.'), 2 DUP ('#'), 3  DUP ('.')      ; Linha com outro hidroavião (vertical)
        DB     15 DUP ('.'), '#' , 4 DUP ('.')              ; Linha com parte do outro hidroavião (vertical)
        DB     20 DUP ('.')                                 ; Linha vazia
        DB     20 DUP ('.')                                 ; Linha vazia
        DB     20 DUP ('.')                                 ;
;INDICADOR DE NAVIOS:

; NUMERO 1 = ENCOURAÇADO
; NUMERO 2 = FRAGATA
; NUMERO 3 = SUBMARINO
; NUMERO 4 = HIDROAVIÃO


;JOGO GABARITO 1

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

CONSTANTE EQU 20

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
    CALL @ESCOLHA                             ;CHAMADA DO PROCEDIMENTO CUJA FUNCAO EH A ESCOLHA DE QUAL JOGO SERA UTILIZADO

    LIMPA
    SOBE 
    PULA_LINHA

    CALL @COORDENADAS                          ;CHAMADA DO PROCEDIMENTO CUJA FUNCAO EH A IMPRESSAO DA MATRIZ JOGO0 (ACERTOS E ERROS DO USUARIO)
    CALL @RODADAS                            ;CHAMADA DO PROCEDIMENTO CUJA FUNCAO EH RESOLVER QUESTOES RELACIONADAS AS RODADAS DA PARTIDA

PULA_LINHA

IMPRIMIR DENOVO                             ;MACRO QUE IMPRIME A STRING DENOVO 
DNV:
    MOV AH,1                                 ;PERGUNTA SE O USUARIO QUER JOGAR DE NOVO OU NAO (S OU N)
    INT 21H
    CMP AL,'S'                               ;SE S (SIM),CONTINUA
    JNE FINALIZA                             ;SE N (NÃO),PULA PARA 'FINALIZA'
    LIMPA                       
    SOBE 
    JMP INICIO                               ;COMECA NOVAMENTE
FINALIZA:

    CMP AL,'N'                               ;SE IGUAL A 'N', CONTINUA, SE NAO = MENSAGEM DE ERRO
    JE CONTI
    IMPRIMIR INCORRETO                      ;MENSAGEM DE ERRO CASO NAO SEJA NENHUMA DAS OPCOES SOLICITADAS
    JMP DNV                                 ;VAI PARA A LABEL VOLTAR E SOLICITA NOVAMENTE UMA ENTRADA DE CARACTERE CORRETA
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

@START PROC             ;PROCEDIMENTO PARA COMECAR OU FINALIZAR O JOGO                             

VOLTAR:

    MOV AH,1            ;ENTRADA DE 1 OU 0 PARA DETERMINADA EXECUCAO
    INT 21H             ;ARMAZENA NO REGISTRADOR AL
    CMP AL,'1'          ;COMPARA COM O CARACTERE '1'
    JE COMECA           ;SE = '1', COMECA O JOGO
    CMP AL,'0'          ;COMPARA COM O CARACTERE '0'
    JE FINALIZA         ;SE = '0', FINALIZA O JOGO 

    
    IMPRIMIR INCORRETO  ;MENSAGEM DE ERRO CASO NAO SEJA NENHUMA DAS OPCOES SOLICITADAS

    JMP VOLTAR          ;VAI PARA A LABEL VOLTAR E SOLICITA NOVAMENTE UMA ENTRADA DE CARACTERE CORRETA

COMECA:
    RET                 ;RETORNA PARA O PROGRAMA PRINCIPAL

@START ENDP             ;FINALIZA O PROCEDIMENTO

@ESCOLHA PROC            ;PROCEDIMENTO QUE ESCOLHE O JOGO QUE SERA UTILIZADO COMO GABARITO

    PULA_LINHA
    IMPRIMIR OPÇÕES

ESCOLHER_JOGO:          ;COMPARA COM AS 5 OPCOES, CASO IGUAIS, PULAM PARA SUAS DEVIDAS LABELS
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

    
    IMPRIMIR INCORRETO   ;MENSAGEM DE ERRO CASO NAO SEJA NENHUMA DAS OPCOES SOLICITADAS
    JMP ESCOLHER_JOGO    ;VAI PARA A LABEL VOLTAR E SOLICITA NOVAMENTE UMA ENTRADA DE CARACTERE CORRETA


ESCOLHA_JOGO1:           ;LABELS ESPECIFICAS PARA CADA OPCAO DE JOGO
    LEA SI, JOGO1        ;LEA SI, JOGOX -> DETERMINA A ORIGEM 
    JMP COPIA_JOGO       ;PULA PARA COPIA_JOGO

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

    LEA DI, JOGOESCOLHIDO  ;DEFINE O "JOGO ESCOLHIDO" COMO DESTINO 
    MOV CX, 100            ;COPIA 100 BYTES (10X10)
    REP MOVSB              ;COPIA O CONTEUDO DE SI (ORIGEM) PARA DI(DESTINO)
    RET                    ;RETORNA PARA O PROGRAMA PRINCIPAL

@ESCOLHA ENDP               ;FINALIZA O PROCEDIMENTO


@COORDENADAS PROC          ;PROCEDIMENTO PARA IMPRIMIR AS COORDENADAS SUPERIOR

    PUSH CX                
    XOR BX,BX
    MOV CX,CONSTANTE       ;CONSTANTE = 10, PARA IMPRESSAO DAS COORDENADAS DE 0 A 9 
    PULA_LINHA
    TABFAKE1               

RETORNA:                                         

    MOV AX,BX              ;MOVE O VALOR DE BX PARA AX 
    CALL @SAIDEC            ;CHAMADA DE PROCEDIMENTO SAIDEC (SAIDA DE DECIMAL) CASO TESTE DE MATRIZ MAIOR QUE 10X10
    CMP AX,9               ;COMPARA AX COM 9 
    JLE PULODUP            ; < OU = 9  -> PULODUP (FINS ESTETICOS)
    ESPAÇO                 ; > 9  -> UM ESPACO (FINS ESTETICOS)
    JMP CONTINUA           

PULODUP:                   ;DOIS ESPACOS

    ESPAÇO
    ESPAÇO

CONTINUA:               

    INC BX                 ;INCREMENTO DE BX PARA IMPRESSAO DO PROXIMO NUMERO
    LOOP RETORNA
    POP CX

    RET                    ;RETORNO PARA O PROCEDIMENTO IMPRIMIR
@COORDENADAS ENDP          ;FIM DO PROCEDIMENTO 

@IMPRIMIR PROC             ;PROCEDIMENTO PARA IMPRESSAO DA MATRIZ JOGO0 (ACERTOS E ERROS DO USUARIO)

    CALL @COORDENADAS      ;CHAMA O PROCEDIMENTO COORDENADAS

    IMPRIMIR DECO          ;IMPRIMIR A STRING DECO (FINS ESTETICOS)

    PUSH CX
    XOR BX,BX
    XOR DL,DL
    MOV DI,CONSTANTE       ;CONTADOR DAS LINHAS DA MATRIZ
    PULA_LINHA
    MOV LATERAIS,41h       ;MOVE O VALOR 41H ('A') PARA LATERAIS

    IMPRIME_LINHA:         ;LABEL QUE VAI SERVIR PARA O LOOP DA IMPRESSAO DE LINHAS

    TABFAKE2               ;FINS ESTETICOS
    MOV AH,2
    MOV DL,LATERAIS        ;IMPRESSAO DA COORDENADA LATERAL
    INT 21H
    ADD LATERAIS,1         ;ADD PARA PASSAGEM DE PROXIMA LETRA
    MOV AH,2
    MOV DL,'.'             ;FINS ESTETICOS
    INT 21H

    ESPAÇO

    XOR SI,SI
    MOV CX,CONSTANTE       ;CONTADOR DAS COLUNAS DA MATRIZ
    MOV AH,2

IMPRIME_COLUNA:            ;LABEL QUE VAI SERVIR PARA O LOOP DA IMPRESSAO DE COLUNAS

    MOV DL,JOGO0[BX+SI]    ;IMPRESSAO DO CONTEUDO DENTRO DE JOGO0, DE ACORDO COM COLUNA E LINHA
    INT 21H
    ESPAÇO
    ESPAÇO
    INC SI                 ;PROXIMA COLUNA
    LOOP IMPRIME_COLUNA    
    PUSH DX
    PULA_LINHA
    POP DX
    ADD BX,CONSTANTE       ;PASSA PARA A PROXIMA LINHA DA MATRIZ JOGO0
    DEC DI                 ;DECREMENTA O CONTADOR DE LINHAS (DI) 
    JNZ IMPRIME_LINHA      ;SE DIFERENTE DE 0, RECOMECA O PROCESSO PARA IMPRIMIR NOVA LINHA
    POP CX
    RET                    ;RETORNA PARA O PROGRAMA PRINCIPAL
@IMPRIMIR ENDP             ;FIM DO PROCEDIMENTO

@RODADAS PROC               ;PROCEDIMENTOS QUE INCLUE TUDO QUE ENVOLVE RODADAS

    MOV CX,2               ;CONTADOR INICIALIZADO COM 50 (LIMITES DE RODADAS)

RODADA:                    ;LABEL RODADA PARA O LOOPING

MOV AX,CX                  ;MOVE CX PARA AX
PUSH AX
PULA_LINHA
IMPRIMIR RESTANTE          ;IMPRIMINDO A STRING RESTANTE
POP AX
CALL @SAIDEC               ;CHAMADA DO PROCEDIMENTO SAIDA DE DECIMAL PELO FATO DE TER UMA QUANTIDADE DE RODADAS ACIMA DE 9

PULA_LINHA

    IMPRIMIR LINHAS        ;IMPRIME A STRING LINHAS (USUARIO DEVE ESCOLHER A LINHA)
    MOV AH,1               ;USUARIO INSERE A LINHA DESEJADA
    INT 21H
    XOR AH,AH
    SUB AL,65D             ;TRANSFORMACAO DE LETRA EM NUMERO
    MOV BX,AX              ;PASSAGEM DE AX PARA BX PARA PODER FAZER A MULTIPLICACAO
    MOV AX, CONSTANTE      ;MOVE CONSTANTE (10) PARA AX PORQUE O COMANDO MUL, MULTIPLA BX COM O VALOR DE AX
    MUL BX                 ;MULTIPLICA BX COM AX PARA OBTER O RESULTADO DA LINHA CORRETA
    MOV BX,AX              ;O RESULTADO EH SEMPRE ARMAZENADO NO REGISTRADOR AX, PORTANTO, PASSAGEM DE AX PARA BX POR CONTA DO ENDERECO DA MATRIZ (USA BX)

PULA_LINHA 

    IMPRIMIR COLUNAS       ;IMPRIME A STRING COLUNAS
    CALL @ENTDEC           ;CHAMADA DO PROCEDIMENTO DE ENTRADA DE DECIMAL
    XOR AH,AH  
    MOV SI ,AX             ;PASSAGEM DE AX PARA SI PELO FATO DE SER O INDICADOR DE COLUNA DA MATRIZ

PULA_LINHA 

COMPARA:                              ;LABEL QUE SERVE PARA LOOPING

    CMP JOGOESCOLHIDO[BX+SI],'1'      ;COMPARA 1 COM A POSICAO ESCOLHIDA PELO JOGADOR (1=ENCOURACADO)
    JE ENCOURACADO
    CMP JOGOESCOLHIDO[BX+SI],'2'      ;COMPARA 2 COM A POSICAO ESCOLHIDA PELO JOGADOR (2=FRAGATA)
    JE FRAGATA
    CMP JOGOESCOLHIDO[BX+SI],'3'      ;COMPARA 3 COM A POSICAO ESCOLHIDA PELO JOGADOR (3=SUBMARINO)
    JE SUBMARINO               
    CMP JOGOESCOLHIDO[BX+SI],'4'      ;COMPARA 4 COM A POSICAO ESCOLHIDA PELO JOGADOR (4=HIDROAVIAO)
    JE  HIDROAVIAO 

    JNE VAZIO                         ;CASO O USUARIO NAO TENHA ACERTADO NENHUM BARCO, PULA PARA VAZIO                  

    ENCOURACADO:                      ;LABEL SE FOR ENCOURACADO

    INC ENCOURACADO_ACERTO            ;INCREMENTA A ESTRUTA DE DADOS QUE ORIGINALMENTE VALE 0
    CMP ENCOURACADO_ACERTO,4          ;COMPARA A ESTRUTURA DE DADOS COM 4 PARA SABER SE JA FOI PERCORRIDO O BARCO INTEIRO
    JNE SEGUE                         ;CASO NAO TENHA OCORRIDO 4 ACERTOS NO ENCOURACADO

    IMPRIMIR FIMENCOURACADO           ;CASO SIM, IMPRIME A STRING FIMENCOURACADO

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

SEGUE:                            ;CASO QUALQUER BARCO ACERTADO, IMPRIME # PARA INDICACAO

    PULA_LINHA
    MOV JOGO0[BX+SI],'#'          ;MOVE # PARA O TABULEIRO DE ERROS E ACERTOS
    CALL @IMPRIMIR                ;CHAMADA DE PROCEDIMENTO @IMPRIMIR QUE FARA A IMPRESSAO NO JOGO0
    IMPRIMIR ACERTOU              ;IMPRIMIR A STRING ACERTOU
    DEC CX                        ;DECREMENTA PARA INDICAR O FIM DE UMA RODADA 
    JZ SALTA                      ;SE CX=0, PULA PARA SALTA
    JMP RODADA                    ;PULA PARA A LABEL RODADA PARA A PROXIMA RODADA!

VAZIO:                            
    MOV JOGO0[BX+SI],'.'          ;CASO O USUARIO NAO ACERTE NENHUM BARCO, MOVE . PARA O JOGO0
    CALL @IMPRIMIR                ;CHAMADA DE PROCEDIMENTO @IMPRIMIR
    IMPRIMIR ERROU                ;CHAMADA DA STRING ERROU
    DEC CX                        ;DECREMENTA CX PARA SERVIR COMO CONTADOR DAS RODADAS 
    JZ SALTA                      ;SE CX=0, PULA PARA SALTA
    JMP RODADA                    ;SE NAO, VOLTA PARA FAZER O MESMO PROCESSO PARA AS PROXIMAS RODADAS

SALTA:                            
    IMPRIMIR FINAL                ;IMPRIME A STRING FINAL
    RET                           ;RETORNA PARA O PROGRAMA PRINCIPAL

@RODADAS ENDP                     ;FINALIZA O PROCEDIMENTO

@ENTDEC PROC                      ;PROCEDIMENTO CUJA FUNCAO EH A ENTRADA DE NUMEROS DECIMAIS
    PUSH CX
    PUSH BX
    PUSH DX
    
ENT:

    XOR BX, BX
    XOR CX, CX

    MOV AH, 1                     ;INSERÇÃO DE UM CARACTERE
    INT 21h

REPETE:
    CMP AL, '0'        ;VERIFICA SE O CARACTERE DIGITADO EH UM DIGITO, MAIOR OU IGUAL A 0
    JNGE NUM                                                                                                                                  
    CMP AL, '9'        ;VERIFICA SE O CARACTERE DIGITADO EH UM DIGITO, MENOR OU IGUAL A 9
    JNLE NUM
    AND AX, 000Fh      ;CONVERSAO DO CARACTERE EM VALOR NUMERICO
    PUSH AX

    MOV AX, 10
    MUL BX             ;MULTIPLICACAO DE BX COM O VALOR 10 ARMAZENADO EM AX 
    POP BX
    ADD BX, AX         ;ADICAO DO DIGITO CONVERTIDO

    MOV AH, 1
    INT 21h
    CMP AL, 13         ;CONFERE SE O ENTER FOI DIGITADO
    JNE REPETE         ;SE DIFERENTE DE 0, REPETICAO 

    MOV AX, BX         
    OR CX, CX          ;VERIFICA SE EH 1 OU 0
    JE SAI
NUM:
    MOV AH, 2
    MOV DL, 0Dh        ;IMPRIME NOVA LINHA
    INT 21h
    MOV DL, 0Ah
    INT 21h
    JMP ENT
SAI:
    POP DX
    POP BX
    POP CX
    RET                ;RETORNA PARA O PROGRAMA MAIN

@ENTDEC ENDP           ;FINALIZA O PROCEDIMENTO

@SAIDEC PROC           ;PROCEDIMENTO SAIDA DE DECIMAL 

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    OR AX,AX          ;VERIFICA SE EH 1 OU 0

@END_IF1:

    XOR CX,CX      
    MOV BX,10
    
@REP1:                ;REPETICAO

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

@SAIDEC ENDP
END MAIN