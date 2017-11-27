ORIGIN 4x0000
SEGMENT  CodeSegment:
    ;LDR R0, R0,  A;DataSeg0
   ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
 ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
 ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
 ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
 ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
 ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
 ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
 ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
    ADD R0, R0, 1
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
A:  DATA2 4xAAAA ; 30
B:  DATA2 4xBBBB
NOP
NOP
NOP
NOP
NOP
NOP

