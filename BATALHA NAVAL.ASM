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
        DB     20 DUP ('.')                                 ; Linha vazia

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
CALL ENTDEC
XOR BX,BX 
MOV BX ,AX

PULA_LINHA 

CALL ENTDEC1
XOR AH,AH  
MOV SI ,AX

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

ENTDEC PROC
 PUSH CX
 PUSH BX
 PUSH DX
ENT:
 
 IMPRIMIR LINHAS

 XOR BX,BX
 XOR CX,CX

 MOV AH,1
 INT 21H

 CMP AL,'-'
 JE NEGT
 CMP AL,'+'
 JE POST
 JMP REP
NEGT:
 MOV CX,1
POST:
 INT 21H
REP:
 CMP AL,'0'
 JNGE NUM
 CMP AL,'9'
 JNLE NUM
 AND AX,000FH
 PUSH AX

 MOV AX,10
 MUL BX
 POP BX
 ADD BX,AX

 MOV AH,1
 INT 21H
 CMP AL,13
 JNE REP

 MOV AX,BX
 OR CX,CX
 JE SAI
 NEG AX
 JMP SAI
NUM:
 MOV AH,2
 MOV DL,0DH
 INT 21H
 MOV DL,0AH
 INT 21H
 JMP ENT
SAI:
 POP DX
 POP BX
 POP CX
 RET
 ENTDEC ENDP

ENTDEC1 PROC
 PUSH CX
 PUSH BX
 PUSH DX
ENT1:
 
 IMPRIMIR COLUNAS

 XOR BX,BX
 XOR CX,CX

 MOV AH,1
 INT 21H

 CMP AL,'-'
 JE NEGT1
 CMP AL,'+'
 JE POST1
 JMP REP1
NEGT1:
 MOV CX,1
POST1:
 INT 21H
REP1:
 CMP AL,'0'
 JNGE NUM1
 CMP AL,'9'
 JNLE NUM1
 AND AX,000FH
 PUSH AX

 MOV AX,10
 MUL BX
 POP BX
 ADD BX,AX

 MOV AH,1
 INT 21H
 CMP AL,13
 JNE REP1

 MOV AX,BX
 OR CX,CX
 JE SAI
 NEG AX
 JMP SAI
NUM1:
 MOV AH,2
 MOV DL,0DH
 INT 21H
 MOV DL,0AH
 INT 21H
 JMP ENT
SAI1:
 POP DX
 POP BX
 POP CX
 RET
 ENTDEC1 ENDP
END MAIN