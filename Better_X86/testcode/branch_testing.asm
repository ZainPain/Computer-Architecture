ORIGIN 4x0000
SEGMENT  CodeSegment:
	ADD R0, R0, 3
	NOP
	NOP
	NOP
	NOP
	NOP
	ADD R0, R0, 2
	NOP
	NOP
	NOP
	NOP
	NOP
LOOP:
	NOP ; 24
	NOP
	NOP
	NOP
	NOP
	ADD R0, R0, -1 ; 34
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BRp LOOP ; 50
	NOP
	NOP
	NOP
	NOP
	NOP



DONE:
	BRnzp DONE ; 52
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP