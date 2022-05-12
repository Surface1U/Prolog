nod(N,0,N):-!.
nod(N,M,R):-M1 is N mod M,N1 is M,nod(N1,M1,R).

countOfCrossSimpleD(A,X):- cocsD(A,X,A,0).
cocsD(A,R,0,R):-!.
cocsD(A,X,I,R):- I1 is I-1,(nod(A,I1,D),D is 1,R1 is R+1,cocsD(A,X,I1,R1);cocsD(A,X,I1,R)),!.

countOfCrossSimpleU(A,X):- cocsU(A,X,A).
cocsU(A,X,0):-X is 0,!.
cocsU(A,X,I):- I1 is I-1, cocsU(A,X1,I1),(nod(A,I1,D),D is 1,X is X1+1;X is X1),!.
