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

 JOGO0  DB     10 DUP('o')                   ; Linha vazia
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
        DB     9  DUP ('.'), "#"                                         ;LINHA COM A OUTRA PARTE DO SUBMARINO 1(VERTICAL)
        DB     '.', '#', 8 DUP('.')                                      ;LINHA COM PARTE1 DO HIDROAVIÃO 1(VERTICAL)
        DB     '.', 2 DUP ('#'), 2 DUP ('.'), 3 DUP ('#'), 2 DUP ('.')   ;LINHA COM PARTE2 DO HIDROAVIÃO 1(VERTICAL) E FRAGATA(HORIZONTAL)
        DB     '.', '#', 8 DUP ('.')                                     ;LINHA COM PARTE3 DO HIDROAVIÃO 1(VERTICAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA
        DB     6  DUP ('.'), 3 DUP ('#'), '.'                            ;LINHA COM PARTE1 DO HIDROAVIÃO 2(HORIZONTAL)
        DB     2  DUP ('.'), 2 DUP ('#'), 3 DUP ('.'), '#', 2 DUP ('.')  ;LINHA COM SUBMARINO 2(HORIZONTAL) E PARTE2 DO HIDROAVIÃO 2(HORIZONTAL)
        DB     10 DUP ('.')                                              ;LINHA VAZIA

INICIAL DB 10,13, "VAMOS JOGAR BATALHA NAVAL!!! $"

INTRODUCAO DB 10,13, "PARA COMECAR O JOGO, TEMOS UM TABULEIRO DE 20 LINHAS E 20 COLUNAS QUE TERAO AS EMBARCACOES $"
INSTRUCOES DB 10,13, "PARA JOGAR, EH NECESSARIO QUE SE INSIRA O VALOR DA LINHA E COLUNA DESEJADO PARA DAR O TIRO E DESCOBRIR SE FOI ATINGIDO UMA EMBARCACAO, PARA GANHAR EH NECESSARIO QUE SE ACHEM TODAS AS EMBARCACOES $"

LINHAS DB 10,13, "INSIRA A LINHA DESEJADA PARA ATIRAR: $"

COLUNAS DB 10,13, "INSIRA A COLUNA DESEJADA PARA ATIRAR: $"

CONSTANTE EQU 10

ACERTOU DB 10,13,'VC ACERTOU UM BARCO!!$'

ERROU  DB 10,13,'POXA, NAO FOI DESSA VEZ...$'

FINAL DB 10,13,'FIM DE JOGO!$'

DECO DB 10,13,'...............................$'

LATERAIS DB ?

.CODE 

MAIN PROC  

MOV AX,@DATA
MOV DS,AX

IMPRIMIR INICIAL

PULA_LINHA    ; Pulando uma linha após a mensagem inicial

IMPRIMIR INTRODUCAO 

PULA_LINHA 

IMPRIMIR INSTRUCOES 

PULA_LINHA ;esse pula linha nao esta funcionando pq?

CALL @IMPRIMIR
CALL RODADAS

PULA_LINHA

FINALIZA:
MOV AH,4CH
INT 21H
MAIN ENDP 

@COORDENADAS PROC
 XOR BX,BX
 MOV CX,CONSTANTE
 PULA_LINHA
 MOV AH,2
 MOV DL,' '
 INT 21H
 MOV AH,2
 MOV DL,' '
 INT 21H
 MOV AH,2
 MOV DL,' '
 INT 21H
@DECO:
 MOV AX,BX
 CALL SAIDEC
 CMP AX,9
 JLE PULODUP
 MOV AH,2
 MOV DL,' '
 INT 21H
 JMP CONTINUA
PULODUP:
 MOV AH,2
 MOV DL,' '
 INT 21H
 MOV AH,2
 MOV DL,' '
 INT 21H
CONTINUA:
 INC BX
 LOOP @DECO
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
 MOV AH,2
 MOV DL,' '
 INT 21H
 XOR SI,SI
 MOV CX,CONSTANTE
 MOV AH,2
 IMPRIME:
 MOV DL,JOGO0[BX+SI]
 INT 21H
 MOV AH,2
 MOV DL,' '
 INT 21H
 MOV AH,2
 MOV DL,' '
 INT 21H
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
CALL ENTDEC
XOR BX,BX 
MOV BX ,AX

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

 SAIDEC PROC
; imprime numero decimal sinalizado em AX
; entrada AX
; saida nenhuma
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
; if AX < 0
    OR AX,AX      ; AX < 0 ?
    JGE @END_IF1
;then
    PUSH AX     ;salva o numero
    MOV DL, '-'
    MOV AH,2
    INT 21H         ; imprime -
    POP AX          ; restaura numero
    NEG AX

; digitos decimais
@END_IF1:
    XOR CX,CX      ; contador de d?gitos
    MOV BX,10      ; divisor
@REP1:
    XOR DX,DX      ; prepara parte alta do dividendo
    DIV BX         ; AX = quociente   DX = resto
    PUSH DX        ; salva resto na pilha
    INC CX         ; contador = contador +1

;until
    OR AX,AX       ; quociente = 0?
    JNE @REP1      ; nao, continua

; converte digito em caractere
    MOV AH,2

; for contador vezes
@IMP_LOOP:
    POP DX        ; digito em DL
    OR DL,30H
    INT 21H
    LOOP @IMP_LOOP
; fim do for

    POP DX
    POP CX
    POP BX
    POP AX
    RET
SAIDEC ENDP
END MAIN