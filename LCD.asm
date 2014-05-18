                #INCLUDE<P16F84A.INC>
                __CONFIG    _XT_OSC & _PWRTE_ON

                #DEFINE RS  PORTA,0
                #DEFINE E   PORTA,1
                #DEFINE BUS PORTB

                CBLOCK  0CH
                CMD
                DATO
                V2
                V1
                ENDC

                ORG 000H

                BSF 	STATUS,RP0
                CLRF	TRISA
                MOVLW	0F0H
                MOVWF	TRISB
                BCF		STATUS,RP0

                CLRF	PORTA
                CLRF	PORTB

                CALL	LCD_INI
                CALL	LCD_CONFIG

                MOVLW	'Y'
                CALL	LCD_DATO

                MOVLW	'A'
                CALL	LCD_DATO

                MOVLW	' '
                CALL	LCD_DATO

                MOVLW	'C'
                CALL	LCD_DATO

                MOVLW	'A'
                CALL	LCD_DATO

                MOVLW	'S'
                CALL	LCD_DATO

                MOVLW	'I'
                CALL	LCD_DATO

                MOVLW	' '
                CALL	LCD_DATO

                GOTO	$

LCD_INI:        CALL 	T15MS
                MOVLW	03H
		CALL 	CMD_SIG
		CALL	T5MS
		MOVLW	03H
		CALL	CMD_SIG
		CALL	T100US
		MOVLW	03H
		CALL	CMD_SIG
		CALL	T40US
		MOVLW	02H
		CALL	CMD_SIG
		CALL	T40US
		RETURN

CMD_SIG:	MOVWF	BUS
		BCF		RS
		BSF		E
		BCF		E
		BCF		RS
		CLRF	BUS
		RETURN

LCD_CMD:	MOVWF	CMD
		SWAPF	CMD,W
		ANDLW	0FH
		CALL	CMD_SIG
		MOVF	CMD,W
		ANDLW	0FH
		CALL	CMD_SIG
		CALL	T40US
		RETURN

LCD_CONFIG:	MOVLW	2CH		;PARA UNA PANTALLA DE 16X2
		CALL	LCD_CMD
		MOVLW	0FH
                CALL	LCD_CMD
                MOVLW	06H
                CALL	LCD_CMD
                RETURN

DATO_SIG:	MOVWF	BUS
		BSF		RS
		BSF		E
		BCF		E
		BCF		RS
		CLRF	BUS
		RETURN

LCD_DATO:	MOVWF	DATO
		SWAPF	DATO,W
                ANDLW	0FH
                CALL	DATO_SIG
                MOVF	DATO,W
                ANDLW	0FH
                CALL	DATO_SIG
                CALL	T40US
                RETURN

;-----------------------------RUTINAS DE TIEMPO------------------------------

T40US:		MOVLW	d'8'
		MOVWF	V1
		NOP
		DECFSZ	V1,1
		GOTO	$-2
		RETURN

T400US:		MOVLW	d'98'
		MOVWF	V1
		NOP
		DECFSZ	V1,1
		GOTO	$-2
		RETURN

T100US:		MOVLW	d'23'
		MOVWF	V1
		NOP
		DECFSZ	V1,1
		GOTO	$-2
		RETURN

T5MS:		MOVLW	d'5'
		MOVWF	V2
		MOVLW	d'248'
		MOVWF	V1
		NOP
		DECFSZ	V1,1
		GOTO	$-2
		DECFSZ	V2,1
		GOTO	$-6
		RETURN

T15MS:  	MOVLW	d'15'
		MOVWF	V2
		MOVLW	d'248'
		MOVWF	V1
		NOP
		DECFSZ	V1,1
		GOTO	$-2
		DECFSZ	V2,1
		GOTO	$-6
		RETURN

            	END
