;-----------------------------------------------------------------------
;	Projet D'Assembleur
;	BAGGIO-KOST Franck
;	MULLER Léane
;-----------------------------------------------------------------------
; "Programme MAIN"
;-----------------------------------------------------------------------
PILE SEGMENT PARA STACK 'PILE'
        DW 512 DUP(00)                                                  ;DW = Allocates and optionally initializes a word (2 bytes) of storage for each initializer. Can also be used as a type specifier anywhere a type is legal. DW is a synonym of WORD.
PILE  ENDS

DONNEE SEGMENT		
_fish		DB		'			  ___======____=---=)',10,'			/T            \_--===)',10,'			L \ (@)   \~    \_-==)',10,'			  \      / )J≈    \-=)',10,'			  \\___/  )JJ≈    \)',10,'			   \_____/JJJ≈      \',10,'			  / \  , \J≈≈      \',10,'			  (-\)\=|  \≈~        L__',10,'			  (\\)  ( -\)_            ==__',10,'			   \V    \-\) ===_____  J\   \\',10,'  			       \V)     \_) \   JJ J\)',10,'			                      /J JT\JJJJ)',10,'			                      (JJJ| \UUU)',10,'			                      (UU)	',10,'				              ___',10,'				Poisson d avril !!			',10							
;Partie affichage
	_main_menu			DB	    ' 1: Decimal',10,' 2: Hexadecimal ',10,' Taper le numero de votre operation: $',10
	;_nope				DB		'nope'
	;%INCL

	;start:
	;INCLUDE decimal.asm
	;INCLUDE hexa.asm
	;JMP start
DONNEE  ENDS

CODE    SEGMENT
;-----------------------------------------------------------------------PROCEDURE DE RETOUR A LA LIGNE	
	PROG_MAIN PROC FAR
		ASSUME CS:code,DS:DONNEE,SS:pile
		; Initialisation
			PUSH CS
			PUSH 0
			MOV	        AX,DONNEE 										;On initialise le segment DONNEE
			MOV	        DS,AX
			JMP DEBmenu
		;Ici, c'est l'affichage du menu qui est concerné
	RETURN_MAIN PROC FAR
		PUSH        AX													;save the register value, insert in order
		PUSH        DX													;save the register value, insert in order
		MOV         DL,10
		MOV         AH,2
		INT         21H
		POP         DX													;take back reg value, take from reverse because push POP function is stack
		POP         AX													;take back reg value, take from reverse because push POP function is stacks
		RET																;quit procedure
	RETURN_MAIN ENDP															;fin de procedure

		_main_menu
			;fish
			;	MOV		AH,9
			;	LEA		DX,_fish
			;	INT 	21H
			
			;affichage du menu			
DEBmenu:			
				MOV         AH,9
				LEA         DX,_main_menu
				INT         21H
			;On choisit l'opération a effectuer :
				MOV         AH,1 										;Ici : 1 car on ne demande qu'un seul caracère qui est un nombre
				INT         21H
				CALL        RETURN_MAIN
			;Puis on teste la selection pour vérifier que l'utilisateur n'entre pas n'importe quoi ._.
		_decimal:
				CMP         AL,'1'										;Si le nombre entré est > 1
				JNE         _hexadecimal						            ;On va à l'étiquette du menu suivante
				;INCLUDE decimal.asm
				;INCLUDE     D:\Projet assembleur\double.asm
				;MOV     AH,9
				;LEA     DX, _nope
				;INT     21h
		_p_hexadecimal:
				CMP         AL,'2'										;Si le nombre entré est > 2
				JNE         _main_menu                						;On va à l'étiquette du menu suivante
				;INCLUDE HEXA.ASM
				;CALL       decimal.asm
				;RET				
	
		_p_end:
			RET
			;MOV			AX,4C00H ;Retour au dos
			;INT			21H
	PROG_MAIN  	ENDP
CODE ENDS
END PROG_MAIN