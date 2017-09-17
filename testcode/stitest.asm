ORIGIN 4x0000

    ;; Refer to the LC-3b manual for the operation of each
    ;; instruction.  (LDR, STR, ADD, AND, NOT, BR)

SEGMENT  CodeSegment:

START:
	LDR R6,R6, GOOD 
	LEA R1, ONE
	STI R6, R1, 1
	LDR R2, R2, var
	
HALT:                   ; Infinite loop to keep the processor
	BRnzp HALT      ; from trying to execute the data below.
                        ; Your own programs should also make use
     



var:    DATA2 4x000a
ONE:    DATA2 4xEF57
RESULT: DATA2 4x0010
INPUT:  DATA2 4x000a
GOOD:   DATA2 4x600D

