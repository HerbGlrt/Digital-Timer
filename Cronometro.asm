; Programa: Cronômetro Digital 8051
; Microcontrolador: 8051
; Simulador: EdSim51
; Objetivo: Controlar um cronômetro que conta de 0 a 9 em um display de 7 segmentos
; utilizando dois botões para alternar o intervalo de tempo (0.25s e 1s)

ORG 0000H           ; Ponto de início do programa
    SJMP MAIN       ; Pula para a rotina principal

; Interrupções
ORG 0003H
    RETI            ; Nenhuma interrupção usada

MAIN:               
    MOV P1, #0FFH   ; Inicializa o Port P1 (Desativa o display de 7 segmentos)
    MOV P3, #0FFH   ; Inicializa o Port P3 (Configura os botões como entradas)

    MOV R0, #00H    ; Zera o registrador R0 (contador)
    MOV P1, #00H    ; Apaga o display no início

CHECK_BUTTONS:      ; Loop para verificar os botões
    JB P3.0, CALL_DELAY_1S  ; Se SW0 estiver pressionado, vai para 1s de delay
    JB P3.1, CALL_DELAY_025S ; Se SW1 estiver pressionado, vai para 0,25s de delay

CALL_DELAY_1S:                
    CALL DELAY_1S         ; Chama a sub-rotina de 1 segundo
    SJMP UPDATE_DISPLAY   ; Atualiza o display e continua

CALL_DELAY_025S:               
    CALL DELAY_025S       ; Chama a sub-rotina de 0,25 segundo
    SJMP UPDATE_DISPLAY   ; Atualiza o display e continua

UPDATE_DISPLAY:          
    INC R0                ; Incrementa o valor no registrador R0
    MOV A, R0             ; Move o valor do contador para o acumulador
    CALL DISPLAY_NUM      ; Atualiza o display
    CJNE A, #09, CHECK_BUTTONS ; Se o valor for diferente de 9, continua
    MOV R0, #00H          ; Reinicia a contagem quando chega a 9
    SJMP CHECK_BUTTONS    ; Volta para verificar os botões

DISPLAY_NUM:              
    MOV P1, #00H          ; Apaga o display para evitar sombras
    MOVC A, @A+DPTR       ; Carrega o valor correspondente ao número no display
    MOV P1, A             ; Envia o valor para o Port P1 (display)
    RET                   ; Retorna para o loop principal

; Sub-rotinas de delay

DELAY_1S:                 
    MOV R1, #20           ; 20 loops para aproximadamente 1 segundo
DELAY1_LOOP:
    MOV R2, #250          ; Aproximadamente 1ms por loop
DELAY1_MS:
    DJNZ R2, DELAY1_MS    ; Decrementa R2 até 0
    DJNZ R1, DELAY1_LOOP  ; Decrementa R1 até 0
    RET                   ; Retorna após 1s

DELAY_025S:               
    MOV R1, #5            ; 5 loops para aproximadamente 0,25 segundo
DELAY025_LOOP:
    MOV R2, #250          ; Aproximadamente 1ms por loop
DELAY025_MS:
    DJNZ R2, DELAY025_MS  ; Decrementa R2 até 0
    DJNZ R1, DELAY025_LOOP ; Decrementa R1 até 0
    RET                   ; Retorna após 0,25s

END
