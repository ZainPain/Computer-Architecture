ORIGIN 4x0000
SEGMENT  CodeSegment:
nop
nop
nop
nop
nop
    lea r0, DataSeg0
    LDR R0, R0, 0
    nop
    nop
nop
nop
nop
    LDR R1, R0, 0
	

DONE:
	BRnzp DONE
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP ; 26

SEGMENT DataSeg0:
A:  DATA2 4xFFFF ; 30
B:  DATA2 4xBBBB
NOP
NOP
NOP
NOP
NOP
NOP

