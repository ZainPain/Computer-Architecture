ORIGIN 4x0000

    ;; Refer to the LC-3b manual for the operation of each
    ;; instruction.  (LDR, STR, ADD, AND, NOT, BR)

SEGMENT  CodeSegment:

    ;; R0 is assumed to contain zero, because of the construction
    ;; of the register file.  (After reset, all registers contain
    ;; zero.)

    ;; Note that the comments in this file should not be taken as
    ;; an example of good commenting style!!  They are merely provided
    ;; in an effort to help you understand the assembly style.

	; R0 is used as one of the arguements for multiplying
	; R1 is the other arguement for multiplying ( multiplication counter)
	; e.g if 2!, R0 = 2, R1 = 1 --> 2 * 1 = 2 etc.
	; R2 is where the RESULT is stored. AT the end of the factorial operation, R2 would have x!
	; R3 contains zeros and is used for things such as ADD R1, R2, R3 where only R2 is getting stored into R1
	; R4 contains only one which is used for decrementing counters
	; R5 is the factorial counter
	; R6 is used to jump when R1 == 1
	; R7 is not used



	LDR R0, R0, INPUT		; This register is where you load your input.. e.g if choosing 5!, input = data2: 4x0005
	LDR R4, R4, ONE			; This register just contains the value 1. this is used for 2's compliment for decrementing values

	ADD R1, R0, R1			; this section of code copies R0 to R1, and then proceeds to decrement R1 by 1.

	NOT R1, R1
	ADD R1, R1, R4
	NOT R1, R1
	ADD R5, R1, R3			; this section of the code decrements the Factorial counter by 1
	NOT R5, R5
	ADD R5, R5, R4
	NOT R5, R5

LOOP:						; MULTIPLICATION LOOP
		
	ADD R2, R2, R0			; ADDING R0 TO RESULT : 5*3 = 5+5+5
	NOT R1, R1
	ADD R1, R4, R1			; DECREMENTING COUNTER
	NOT R1, R1

	ADD R6, R1, R3			; THIS IS CHECKING IF THE MULTIPLICATION COUNTER R1 == 1, IF SO THEN WE BREAK LOOP
	NOT R6, R6
	ADD R6, R6, R3
	NOT R6, R6	
	BRz	OUTERLOOP	
	ADD R1, R1, R3			; ELSE WE SET CC IN ORDER TO BRANCH BACK AND CONTINUE MULTIPLYING
	BRp LOOP
OUTERLOOP:
	ADD R0, R2, R3			; STORING R2 INTO R0 AS R2 IS THE NEXT TARGET FOR MULTIPLICATION -> 5 * 6 = 30 THEN 30 * 4 THEREFORE R0 MUST BE UPDATED

	NOT R5,R5
	ADD R5, R4, R5			; DECREMENT FACTORIAL COUNTER
	NOT R5,R5

	ADD R1, R5, R3
	BRp LOOP				; PERFORM MULTIPLICATION IF NOT OVER
	
HALT:                   ; Infinite loop to keep the processor
    BRnzp HALT          ; from trying to execute the data below.
                        ; Your own programs should also make use
                        ; of an infinite loop at the end.
ZERO:   DATA2 4x0000
ONE:    DATA2 4x0001
RESULT: DATA2 4x0000
INPUT:  DATA2 4x0005
GOOD:   DATA2 4x600D

