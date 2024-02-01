% Represent a state as [CannibalLeft,MissionaryLeft,Boat,CannibalRight,MissionaryRight]
start([3,3,left,0,0]).
goal([0,0,right,3,3]).

%Checks legal moves or states
legal(CL,ML,CR,MR) :-
	ML>=0, CL>=0, MR>=0, CR>=0, %Checks if cannibals and missionaries are not negative
	(ML>=CL ; ML=0), %Checks that there are more missionaries than cannibals on the left side or if there are no cannibals
	(MR>=CR ; MR=0). %Checks that there are more missionaries than cannibals on the right side or if there are no cannibals

%All possible movements
move([CL,ML,left,CR,MR],[CL,ML2,right,CR,MR2]):-
	% Two missionaries cross left to right.
	MR2 is MR+2, %Adds two missionaries on the right side
	ML2 is ML-2, %Substract two missionaries on the left side
	legal(CL,ML2,CR,MR2). %Checks for illegal movements

move([CL,ML,left,CR,MR],[CL2,ML,right,CR2,MR]):-
	% Two cannibals cross left to right.
	CR2 is CR+2, %Adds two cannibals on the right side
	CL2 is CL-2, %Substract two cannibals on the left side
	legal(CL2,ML,CR2,MR). %Checks for illegal movements

move([CL,ML,left,CR,MR],[CL2,ML2,right,CR2,MR2]):-
	%  One missionary and one cannibal cross left to right.
	CR2 is CR+1, %Adds one cannibal on the right side
	CL2 is CL-1, %Substract one cannibal on the left side
	MR2 is MR+1, %Adds one missionary on the right side
	ML2 is ML-1, %Substract one missionary on the left side
	legal(CL2,ML2,CR2,MR2). %Checks for illegal movements

move([CL,ML,left,CR,MR],[CL,ML2,right,CR,MR2]):-
	% One missionary crosses left to right.
	MR2 is MR+1, %Adds one missionary on the right side
	ML2 is ML-1, %substract one missionary on the left side
	legal(CL,ML2,CR,MR2). %Checks for illegal movements

move([CL,ML,left,CR,MR],[CL2,ML,right,CR2,MR]):-
	% One cannibal crosses left to right.
	CR2 is CR+1, %Adds one cannibal on the right side
	CL2 is CL-1, %substract one cannibal on the left side
	legal(CL2,ML,CR2,MR). %Checks for illegal movements

move([CL,ML,right,CR,MR],[CL,ML2,left,CR,MR2]):-
	% Two missionaries cross right to left.
	MR2 is MR-2, %Substract two missionaries on the right side
	ML2 is ML+2, %Adds two missionaries on the left side
	legal(CL,ML2,CR,MR2). %Checks for illegal movements

move([CL,ML,right,CR,MR],[CL2,ML,left,CR2,MR]):-
	% Two cannibals cross right to left.
	CR2 is CR-2, %Substract two cannibals on the right side
	CL2 is CL+2, %Adds two cannibals on the left side
	legal(CL2,ML,CR2,MR). %Checks for illegal movements 

move([CL,ML,right,CR,MR],[CL2,ML2,left,CR2,MR2]):-
	%  One missionary and one cannibal cross right to left.
	CR2 is CR-1,%Substract one cannibal on the right side
	CL2 is CL+1, %Adds one cannibal on the left side
	MR2 is MR-1, %Substract one missionary on the right side
	ML2 is ML+1, %Adds one missionary on the left side
	legal(CL2,ML2,CR2,MR2). %Checks for illegal movements

move([CL,ML,right,CR,MR],[CL,ML2,left,CR,MR2]):-
	% One missionary crosses right to left.
	MR2 is MR-1, %Substract one missionary on the right side
	ML2 is ML+1, %Adds one missionary on the left side
	legal(CL,ML2,CR,MR2). %Checks for illegal movements

move([CL,ML,right,CR,MR],[CL2,ML,left,CR2,MR]):-
	% One cannibal crosses right to left.
	CR2 is CR-1, %Substract one cannibal on the right side
	CL2 is CL+1, %Adds one cannibal on the left side
	legal(CL2,ML,CR2,MR). %Checks for illegal movements


% Recursive call to solve the problem
path([CL1,ML1,B1,CR1,MR1],[CL2,ML2,B2,CR2,MR2],Explored,MovesList) :- %path definition where a inicialState and a finalState is represented
   move([CL1,ML1,B1,CR1,MR1],[CL3,ML3,B3,CR3,MR3]), %calls move where a legal movement will be carried on
   not(member([CL3,ML3,B3,CR3,MR3],Explored)), %Avoids recursive calls
   path([CL3,ML3,B3,CR3,MR3],[CL2,ML2,B2,CR2,MR2],[[CL3,ML3,B3,CR3,MR3]|Explored],[ [[CL3,ML3,B3,CR3,MR3],[CL1,ML1,B1,CR1,MR1]] | MovesList ]). 
   %Calls recursively path for continuing making moves without making the opposite of the past move to avoid cycles
   
% Final solution
path([CL,ML,B,CR,MR],[CL,ML,B,CR,MR],_,MovesList):- 
	output(MovesList). %Moveslist is the list that contains all the moves done correctly

% Printing movesList
output([]) :- nl. 
output([[A,B]|MovesList]) :- 
	output(MovesList), 
   	write(B), write(' -> '), write(A), nl.

% Finds the game solution
gameSolution :- 
   path([3,3,left,0,0],[0,0,right,3,3],[[3,3,left,0,0]],_).