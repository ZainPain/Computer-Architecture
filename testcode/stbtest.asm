ORIGIN 4x0000

    ;; Refer to the LC-3b manual for the operation of each
    ;; instruction.  (LDR, STR, ADD, AND, NOT, BR)

SEGMENT  CodeSegment:

START:
	 
	lea r1, var
	ldr r2, r0, var
	stb r2, r1, 3
	
HALT:                   ; Infinite loop to keep the processor
	BRnzp HALT      ; from trying to execute the data below.
                        ; Your own programs should also make use
     



var:    DATA2 4xABCD
ONE:    DATA2 4xEF57
RESULT: DATA2 4x7799
INPUT:  DATA2 4xABEF
GOOD:   DATA2 4x600D

