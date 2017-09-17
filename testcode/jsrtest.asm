ORIGIN 4x0000

    ;; Refer to the LC-3b manual for the operation of each
    ;; instruction.  (LDR, STR, ADD, AND, NOT, BR)

SEGMENT  CodeSegment:

START:
	jsr TEST
	
HALT:           
	add r1, r1, 5        ; Infinite loop to keep the processor
	BRnzp HALT      ; from trying to execute the data below.
                        ; Your own programs should also make use
                        ; of an infinite loop at the end.
TEST:
	ADD R1, R1, 10
	LEA R7, HALT
	RET



ZERO:   DATA2 4x0000
ONE:    DATA2 4x0001
RESULT: DATA2 4x0000
INPUT:  DATA2 4x0007
GOOD:   DATA2 4x600D

