ORIGIN 4x0000
SEGMENT  CodeSegment:
    add r1, r1, 15	; 15
    add r1, r1, 15	;r1 = 30
    nop
    add r2, r1, r1	;r2 = 60
    nop

    add r3, r2, r1	;r3 = 90
    add r3, r3, r3	;r3 = 180

DONE:
	BRnzp DONE
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP ; 26

DSP:    DATA2 DataSeg

SEGMENT DataSeg:
A:  DATA2 4x0011 ; 30
NOP
NOP
NOP
NOP
NOP
W:  DATA2 4x0009
X:  DATA2 4x0002
; cache line boundary
Y:  DATA2 4x0001
Z:  DATA2 4x0003
