ORIGIN 4x0000
SEGMENT  CodeSegment:
    add r1, r1, 15
    add r1, r1, 15
    add r2, r1, r1

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
