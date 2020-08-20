TITLE CS2810 Assembler Template

; Student Name: Cecilia Harvey
; Assignment Due Date: 8/9/2020

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "CS 2810 Summer Semester 2020",0 
	vAssignment byte "Assembler Assignment #5",0
	vName byte "Cecilia Harvey",0
	vStartGame byte "Let's play a number guessing game!", 0
	vPrompt byte "Guess a number between 0 to 100: ", 0
	vCarriageReturn byte 13,10,0    
	vTooHigh byte "Your guess was too high.",0
	vTooLow byte "Your guess was too low.",0
	vWin byte "You guessed the right number! You Win!",0
	vAgain byte "Would you like to play again? 1-Yes or 0-No",0
	vThanks byte "Thanks for playing my game!",0

.code
main PROC
	;--------- Enter Code Below Here
	call clrscr
	call Randomize
	call DisplayInfo
	call NewLine
	call NewLine

	mov edx, offset vStartGame
	call writestring
	call RandNum								;generates random number and stores it in the ecx
	mov edx, offset vThanks
	call writestring

	call EndFile

	;---------- write label code Below here
	EndFile: 
		xor ecx, ecx
		call ReadChar
		exit 

	DisplayInfo:
		mov dh, 5
		mov dl, 0
		call gotoxy

		mov edx, offset vSemester
		call writestring

		mov dh, 6
		mov dl, 0
		call gotoxy

		mov edx, offset vAssignment
		call writestring

		mov dh, 7
		mov dl, 0
		call gotoxy

		mov edx, offset vName
		call writestring

		ret

	NewLine:
		mov edx, offset vCarriageReturn
		call writestring
		ret

	RandNum:
		call NewLine
		mov eax, 101
		call RandomRange
		mov ecx, eax							;store randomly generated number
		call GameLoop
		ret

	GameLoop:
		mov edx, offset vPrompt					;prompt for user guess between 0-100
		call writestring
		call NewLine
		call ReadDec							;accept input as decimal
		cmp eax, ecx
		jg TooHigh								;conditional jump (if greater than) to High (which will print a statement that says your guess was too high then unconditionally jump back to GameLoop)
		cmp eax, ecx
		jl TooLow								;conditional jump if less than to Low which will print a statemnt and then unconditionally jump back to the GameLoop
		cmp eax, ecx
		jz Win									;conditional jump (if it is equal) to Win (which will print a statement that says you won, ask if you want to play again 1 yes 0 no)
		ret

	TooHigh:
		mov edx, offset vTooHigh				;print statement your guess was too high.  
		call writestring
		call NewLine							;call NewLine
		jmp GameLoop

	TooLow: 
		mov edx, offset vTooLow					;print statement your guess was too low.  
		call writestring
		call NewLine							;call NewLine
		jmp GameLoop

	Win:
		mov edx, offset vWin					;print statement Congratulations! You guessed right!
		call writestring						;print statement do you want to play again? Press 1 for yes or 0 for no
		call NewLine
		mov edx, offset vAgain					
		call writestring						;ask if they want to play again
		call NewLine
		call ReadDec							;accept input
		call NewLine
		cmp eax, 1								;compare input to 1, if true, then go restart the game
		jz NewGame								;conditional jump to play which will produce a random number and call GameLoop
		ret

	NewGame:
		call clrscr
		call RandNum
		ret

main ENDP

END main