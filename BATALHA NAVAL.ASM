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
JOGO0   DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia
        DB    20 DUP(0)                     ; Linha vazia

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

IMPRIMIR INICIAL

PULA_LINHA    ; Pulando uma linha após a mensagem inicial

IMPRIMIR INTRODUCAO 

PULA_LINHA 

IMPRIMIR INSTRUCOES 

PULA_LINHA 

CALL @IMPRIMIR

PULA_LINHA 

IMPRIMIR LINHAS
XOR BX,BX 
MOV AH,1
INT 21H
MOV BL ,AL 
PULA_LINHA 

IMPRIMIR COLUNAS 

MOV AH,1
INT 21H
XOR AH,AH  
MOV SI ,AX 

PULA_LINHA 

COMPARA:
 CMP JOGO1[BX+SI],1
 JNE FINALIZA
 MOV JOGO0[BX+SI],1
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
 MOV DL,JOGO0[BX+SI]
 OR DL,30h
 INT 21H
 mov ah,2
 mov dl,' '
 int 21h
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
