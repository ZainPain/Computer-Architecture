ORIGIN 4x0000
SEGMENT  CodeSegment:
    add r1, r1, 15	; 15
    add r1, r1, 15	;r1 = 30
    add r2, r1, r1	;r2 = 60
    add r3, r2, r1	;r3 = 90
    add r3, r3, r3	;r3 = 180
	lea r7, A
	add r3, r3, r3
	stb r3, r7, 1
	ldr r6, r7, 0
	nop
	nop
	nop
	nop
	nop
	lea r6, B
	stb r3, r6, 0
	ldr r5, r7, 0



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
A:  DATA2 4xCD11 ; 30
B:  DATA2 4xEF22
NOP
NOP
NOP
NOP
W:  DATA2 4x0009
X:  DATA2 4x0002
; cache line boundary
Y:  DATA2 4x0001
Z:  DATA2 4x0003
