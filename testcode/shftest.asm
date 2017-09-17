ORIGIN 4x0000

    ;; Refer to the LC-3b manual for the operation of each
    ;; instruction.  (LDR, STR, ADD, AND, NOT, BR)

SEGMENT  CodeSegment:

START:
	ADD R1, R1, 15
	ADD R1, R1, 1
	LSHF R2, R1,3
	
	
HALT:                   ; Infinite loop to keep the processor
	BRnzp HALT      ; from trying to execute the data below.
                        ; Your own programs should also make use
                        ; of an infinite loop at the end.
TEST:
	ADD R1, R1, 10
	LEA R7, HALT
	RET



ZERO:   DATA2 4x0000
ONE:    DATA2 4x0010
RESULT: DATA2 4x000E
INPUT:  DATA2 4xABCD
GOOD:   DATA2 4x600D

