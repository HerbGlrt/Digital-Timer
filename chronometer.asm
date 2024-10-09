org 00h ; A origem do programa é definida em 00h.

TIME_REGISTER EQU R1    ; Admite que a 'TIME_REGISTER' é equivalente à palavra-chave R1, o registrador destina à contagem.
SWITCH0 EQU P2.0    ; Admite que a 'SWITCH0' é equivalente à palavra-chave P2.0, o primeiro switch.
SWITCH1 EQU P2.1    ; Admite que a 'SWITCH1' é equivalente à palavra-chave P2.1, o segundo switch.
SEVEN_SEG_DISPLAY EQU P1  ; Admite que a 'SEVEN_SEG_DISPLAY' é equivalente à palavra-chave 'P1', os sete segmentos do primeiro display.

begin:
	MOV DPTR, #ALGS ; Inicializa o ponteiro DPTR com o algarismo inicial do conjunto 'ALGS'.

main: 
	JNB SWITCH0, update    ; Caso o SWITCH0 tenha sido pressionado, salte para a sub-rotina update.
	JNB SWITCH1, update   ; Caso o SW1 tenha sido pressionado, salte para a sub-rotina update.
	SJMP MAIN    ; Caso ambos não tenham sido pressionados, salte à sub-rotina main, formando um loop.

update:
	CLR A    ; Esvazia o conteúdo do acumulador A.
	MOVC A, @A+DPTR   ; Atualiza o valor do algarismo para o próximo sequencialmente.
	MOV SEVEN_SEG_DISPLAY, A   ; Atualiza o algarismo do display.
	INC DPTR    ; Incrementa o registrador DPTR, atualizando o algarismo do display.
	JMP delay_choose   ; Salta o 'delay_choose' a fim de determinar o período.

delay_choose:
	JNB SWITCH0, sleep_025s   ; Inicia a sub-rotina da contagem com período de um quarto de segundo.
	JNB SWITCH1, sleep_1s   ; Inicia a sub-rotina da contagem com período de um segundo.
	JMP main   ; Caso nenhum switch esteja pressionado, retorne à main.

sleep_1s:
	MOV R0, #200   ; Move o valor 200 para R0.
	ACALL loop_1s   ; Invoca a sub-rotina 'loop_1s' para iniciar os loops de um segundo.
	CJNE A, #090h, update    ; Caso a contagem até o nove tenha terminado, reinicie a contagem com uma chamada para a sub-rotina 'update'.
	ACALL reset_alg   ; Reinicie o ponteiro DPTR na sub-rotina 'reset_alg'.
	JMP main   ; Retorna à main para encerrar a contagem.

loop_1s:
	MOV TIME_REGISTER, #1000   ; Inicializa o 'TIME_REGISTER' com o valor 1000, para 1000ms.
	DJNZ TIME_REGISTER, $   ; Decrementa o 'TIME_REGISTER' até que seja nulo.
	DJNZ R0, loop_1s   ; Decrementa R0 e, caso não seja nulo, retorna ao loop.
	RET   ; Finaliza a sub-rotina.

sleep_025s:
	MOV R0, #100   ; Move o valor 100 para R0.
	ACALL   loop_025s ; Invoca a sub-rotina 'loop_025s' para iniciar os loops de um quarto de segundo.
	CJNE A, #090h, update   ; Caso a contagem até o nove tenha terminado, reinicie a contagem com uma chamada para a sub-rotina 'update'.
	ACALL reset_alg   ; Reinicie o ponteiro DPTR na sub-rotina 'reset_alg'.
	JMP main   ; Retorna à main para encerrar a contagem.

loop_025s:
	MOV TIME_REGISTER, #250   ; Inicializa o 'TIME_REGISTER' com o valor 250, para 250ms.
	DJNZ TIME_REGISTER, $   ; Decrementa o 'TIME_REGISTER' até que seja nulo.
	DJNZ R0, loop_025s   ; Decrementa R0 e, caso não seja nulo, retorna ao loop.
	RET   ; Finaliza a sub-rotina.

reset_alg:
	MOV DPTR, #ALGS; Move o endereço da 'ALGS' para DPTR.
	RET   ; Retorna da sub-rotina.

ALGS:
	DB 0C0h, 0F9h, 0A4h, 0B0h, 099h, 092h, 082h, 0F8h, 080h, 090h   ; Algarismos possíveis do display.