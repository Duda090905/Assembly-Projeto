.MODEL SMALL
.STACK 100H
PULA_LINHA MACRO  

MOV AH,2                 
MOV DL,13  
INT 21H 
MOV DL,10 
INT 21H 

ENDM

IMPRIMIR MACRO MSG

 MOV AH,9
 LEA DX,MSG
 INT 21H

ENDM

.DATA 

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

JOGO1   DB     6 DUP ('.'),2 DUP('#'),12 DUP('.')  ; Linha vazia
        DB     12 DUP('.'), 4 DUP('#'), 4 DUP('.') ; Linha com encouraçado
        DB     2 DUP('.'), 3 DUP('#'), 15 DUP('.') ; Linha com fragata
        DB     3 DUP(20 DUP('.'))              ; Três linhas vazias
        DB     3 DUP ('.'),3 DUP('#'), 14 DUP('.')           ; Linha com navio
        DB     4 DUP('.'), 1 DUP('#'), 15 DUP('.') ; Ponto isolado de navio
        DB     4 DUP(20 DUP('.'))              ; Quatro linhas vazias
        DB     9 DUP('.'), 2 DUP('#'), 9 DUP('.')  ; Outro navio
        DB     10 DUP(20 DUP('.'))             ; Dez linhas vazias
        DB     11 DUP('.'), 1 DUP('#'), 8 DUP('.') ; Ponto de navio isolado
        DB     11 DUP('.'), 1 DUP('#'), 8 DUP('.') ; Outro ponto isolado
        DB     2 DUP(20 DUP('.'))              ; Duas linhas vazias
        DB     12 DUP('.'), 1 DUP('#'), 7 DUP('.') ; Ponto de navio
        DB     12 DUP('.'), 2 DUP('#'), 6 DUP('.') ; Outro ponto de navio
        DB     12 DUP('.'), 1 DUP('#'), 7 DUP('.') ; Ponto de navio
        DB     4 DUP(20 DUP('.'))              ; Quatro linhas vazias

INICIAL DB 10,13, "VAMOS JOGAR BATALHA NAVAL!!! $"

INTRODUCAO DB 10,13, "PARA COMECAR O JOGO, TEMOS UM TABULEIRO DE 20 LINHAS E 20 COLUNAS QUE TERAO AS EMBARCACOES $"
INSTRUCOES DB 10,13, "PARA JOGAR, EH NECESSARIO QUE SE INSIRA O VALOR DA LINHA E COLUNA DESEJADO PARA DAR O TIRO E DESCOBRIR SE FOI ATINGIDO UMA EMBARCACAO, PARA GANHAR EH NECESSARIO QUE SE ACHEM TODAS AS EMBARCACOES $"

LINHAS DB 10,13, "INSIRA A LINHA DESEJADA PARA ATIRAR: $"

COLUNAS DB 10,13, "INSIRA A COLUNA DESEJADA PARA ATIRAR: $"

CONSTANTE EQU 20

ACERTOU DB 10,13,'VC ACERTOU UM BARCO!!$'

ERROU  DB 10,13,'POXA, NAO FOI DESSA VEZ...$'

FINAL DB 10,13,'FIM DE JOGO!$'

.CODE 

MAIN PROC  

MOV AX,@DATA
MOV DS,AX

IMPRIMIR INICIAL

PULA_LINHA    ; Pulando uma linha após a mensagem inicial

IMPRIMIR INTRODUCAO 

PULA_LINHA 

IMPRIMIR INSTRUCOES 

PULA_LINHA 

CALL @IMPRIMIR

PULA_LINHA

CALL RODADAS

IMPRIMIR FINAL 

FINALIZA:
MOV AH,4CH
INT 21H
MAIN ENDP 

@IMPRIMIR PROC
 PUSH CX
 XOR BX,BX
 XOR DL,DL
 MOV DI,CONSTANTE
 PULA_LINHA
 MOV AH,2
 IMPRIME2:
 XOR SI,SI
 MOV CX,CONSTANTE
 IMPRIME:
 MOV DL,JOGO0[BX+SI]
 
 INT 21H
 mov ah,2
 mov dl,' '
 int 21h
 INC SI
 LOOP IMPRIME
 push dx
 PULA_LINHA
 pop dx
 ADD BX,CONSTANTE
 DEC DI
 JNZ IMPRIME2
 POP CX
 RET
@IMPRIMIR ENDP

RODADAS PROC
 MOV CX,CONSTANTE

RODADA:
IMPRIMIR LINHAS
XOR BX,BX 
MOV AH,1
INT 21H
MOV BL ,AL 
AND BL,0FH

PULA_LINHA 

IMPRIMIR COLUNAS 

MOV AH,1
INT 21H
XOR AH,AH  
MOV SI ,AX 
AND SI,0FH

PULA_LINHA 

COMPARA:
 CMP JOGO1[BX+SI],'#'
 JNE VAZIO
 MOV JOGO0[BX+SI],'#'
 CALL @IMPRIMIR
 IMPRIMIR ACERTOU
 LOOP RODADA
 VAZIO:
 MOV JOGO0[BX+SI],'.'
 CALL @IMPRIMIR
 IMPRIMIR ERROU
 LOOP RODADA
 RET
RODADAS ENDP
END MAIN
