DATOS SEGMENT PARA 'DATA'
TIME DB '00:00$'
MSG DB 'INGRESA UNA CADENA DE TEXTO: $'  
NP LABEL BYTE                  
MAXLEN  DB    30              
NML DB    ?              
NMC DB  30 DUP(' ')
FIL     DB  0
COL     DB  0
A2   DB  0
A7   DB  0 
A8   DB  0
A4   DB  0
VERI    DB  0
VERI2   DW  0
TEMP    DB  0
DATOS ENDS
PILA SEGMENT PARA STACK 'STACK'
DW 100 DUP (0)
PILA ENDS
CODIGO SEGMENT PARA 'CODE'
ASSUME DS:Datos, CS:Codigo, SS:Pila, ES:Nothing

PGMA PROC FAR
	MOV AX, Datos
	MOV DS, AX
	MOV ES, AX
    LEA DX, MSG
    CALL EBE
	CALL CLS
	CALL CT_U	      
	REPET:
    MOV AH, 01H
    INT 16H 	              
	CMP AL, 0DH
    JE FINAL 
	CALL CT                 
    JMP REPET
    FINAL:
    MOV AH, 4CH          
    INT 21H
	RET 
PGMA ENDP

CLS PROC NEAR        
    MOV AX, 00
    MOV BX, 00
    MOV CX, 00
    MOV DX, 00
    RET                  
CLS ENDP
EBE PROC NEAR
	MOV AH,09H
	INT 21H
    MOV DL, ' ' 
    MOV AH, 02H
    INT 21H
	RET    
EBE ENDP
CT_U PROC NEAR                
    MOV AH, 0AH     
    LEA DX, NP 
    INT 21H
    CMP NML, 00 
    JZ D90          
    MOV AL, 20H     
    SUB CH, CH
    MOV CL, NML 
    LEA DI, NMC
    ADD DI, CX     
    NEG DX         
    ADD CX, 30     
    MOV BH, 00
    MOV BL, NML
    MOV NMC[BX], 07
    MOV NMC[BX+1], '$'
    D90:
    RET                            
CT_U ENDP
CSR PROC NEAR    
    CALL CLS
    MOV AH,02H
    MOV DH, FIL
    MOV DL, COL
    CALL MOVER
    INT 10H
    RET
CSR ENDP
MOVER PROC NEAR    
    CMP DX, 0000H    
    JE A1
    CMP DX, 1745H
    JE A5
    CMP DX, 0045H
    JE A6 
    CMP DX, 1700H
    JE A3
    JMP VR
    A1:
    MOV A4, 0 
    MOV A2, 1
    JMP VR
    A5:
    MOV A2, 0
    MOV A7, 1
    JMP VR
    A6:
    MOV A7, 0
    MOV A8, 1
    JMP VR
    A3:
    MOV A8, 0
    MOV A4, 1
    JMP VR
    VR:
    CMP A2, 1
    JE MOV1
    CMP A7, 1
    JE MOV2
    CMP A8, 1
    JE MOV3 
    CMP A4, 1
    JE MOV4
    MOV1:                          
    ADD FIL, 1H
    ADD COL, 3H
    RET
    MOV2:
    DEC FIL
    RET 
    MOV3:
    INC FIL
    SUB COL, 3H
    RET
    MOV4:
    DEC FIL
    RET
MOVER ENDP
CLS_P PROC NEAR
    MOV AX, 0600H  
    MOV BH, 01110000B
    MOV CX, 0000H
    MOV DX, 184FH
    INT 10H
    RET 
CLS_P ENDP 
CT PROC NEAR
    LEA BX, TIME                   
    CALL G_T
    CMP TEMP, 1
    JNE CF
    CALL CLS_P              
	CALL CSR 
    LEA DX, NMC           
    CALL EBE                               
    LEA DX, TIME        
    CALL EBE  
    CALL RESET                   
    CF:
    RET
CT ENDP
G_T PROC
    PUSH AX                       
    PUSH CX                       
    MOV AH, 2CH                
    INT 21H                       
    MOV AL, CH                   
    CALL CV                 
    MOV [BX], AX                
    MOV AL, CL              
    CALL CV              
    MOV [BX+3], AX                                                                                                                        
    POP CX                        
    POP AX                        
    RET                           
G_T ENDP                  
CV PROC 
    PUSH DX                       
    MOV AH, 0                    
    MOV DL, 10                   
    DIV DL                       
    OR AX, 3030H                 
    CALL TTR
    POP DX                        
    RET                           
CV ENDP
TTR PROC
    CMP VERI, AH 
    JE DIF             
    MOV VERI, AH
    INC VERI2
    CALL VRR
    DIF:
    RET                 
TTR ENDP
VRR PROC           
    CMP VERI2, 1200H
    JNE DIF2
    MOV TEMP, 1 
    DIF2:
    RET                           
VRR ENDP   
RESET PROC    
    MOV VERI2, 0
    MOV TEMP, 0
    RET
RESET ENDP
CODIGO ENDS
END PGMA