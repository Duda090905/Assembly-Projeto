.MODEL SMALL
.STACK 100H
PULA_LINHA MACRO  

MOV AH,2                 
MOV DL,13  
INT 21H 
MOV DL,10 
INT 21H 

ENDM

.DATA 
JOGO1   DB     20 DUP(0)                     ; Linha vazia
        DB     12 DUP(0), 4 DUP(1), 4 DUP(0) ; Linha com encouraçado
        DB     1 DUP(0), 1 DUP(1), 3 DUP(1), 15 DUP(0) ; Linha com fragata
        DB     3 DUP(20 DUP(0))              ; Três linhas vazias
        DB     3 DUP(1), 17 DUP(0)           ; Linha com navio
        DB     1 DUP(0), 1 DUP(1), 18 DUP(0) ; Ponto isolado de navio
        DB     4 DUP(20 DUP(0))              ; Quatro linhas vazias
        DB     9 DUP(0), 2 DUP(1), 9 DUP(0)  ; Outro navio
        DB     10 DUP(20 DUP(0))             ; Dez linhas vazias
        DB     11 DUP(0), 1 DUP(1), 8 DUP(0) ; Ponto de navio isolado
        DB     11 DUP(0), 1 DUP(1), 8 DUP(0) ; Outro ponto isolado
        DB     2 DUP(20 DUP(0))              ; Duas linhas vazias
        DB     12 DUP(0), 1 DUP(1), 7 DUP(0) ; Ponto de navio
        DB     12 DUP(0), 2 DUP(1), 6 DUP(0) ; Outro ponto de navio
        DB     12 DUP(0), 1 DUP(1), 7 DUP(0) ; Ponto de navio
        DB     4 DUP(20 DUP(0))              ; Quatro linhas vazias

INICIAL DB 10,13, "VAMOS JOGAR BATALHA NAVAL!!! $"

INTRODUCAO DB 10,13, "PARA COMECAR O JOGO, TEMOS UM TABULEIRO DE 20 LINHAS E 20 COLUNAS QUE TERAO AS EMBARCACOES $"
INSTRUCOES DB 10,13, "PARA JOGAR, EH NECESSARIO QUE SE INSIRA O VALOR DA LINHA E COLUNA DESEJADO PARA DAR O TIRO E DESCOBRIR SE FOI ATINGIDO UMA EMBARCACAO, PARA GANHAR EH NECESSARIO QUE SE ACHEM TODAS AS EMBARCACOES $"

LINHAS DB 10,13, "INSIRA A LINHA DESEJADA PARA ATIRAR: $"

COLUNAS DB 10,13, "INSIRA A COLUNA DESEJADA PARA ATIRAR: $"

.CODE 

MAIN PROC  

MOV AX,@DATA
MOV DS,AX

MOV AH,9
LEA DX, INICIAL 
INT 21H

PULA_LINHA    ; Pulando uma linha após a mensagem inicial

MOV AH,9
LEA DX, INTRODUCAO 
INT 21H

PULA_LINHA 

MOV AH,9
LEA DX, INSTRUCOES 
INT 21H

PULA_LINHA 

CALL @IMPRIMIR

FINALIZA:
MOV AH,4CH
INT 21H
MAIN ENDP 

@IMPRIMIR PROC
 XOR BX,BX
 XOR DL,DL
 MOV DI,20
 MOV AH,2
 IMPRIME2:
 XOR SI,SI
 MOV CX,20
 IMPRIME:
 MOV DL,JOGO1[BX+SI]
 OR DL,30h
 INT 21H
 INC SI
 LOOP IMPRIME
 push dx
 PULA_LINHA
 pop dx
 ADD BX,20
 DEC DI
 JNZ IMPRIME2
 RET
@IMPRIMIR ENDP
END MAIN
