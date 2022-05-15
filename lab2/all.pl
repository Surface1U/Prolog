%11

nod(N,0,N):-!.
nod(N,M,R):-M1 is N mod M,N1 is M,nod(N1,M1,R).

countOfCrossSimpleD(A,X):- cocsD(A,X,A,0).
cocsD(A,R,0,R):-!.
cocsD(A,X,I,R):- I1 is I-1,(nod(A,I1,D),D is 1,R1 is R+1,cocsD(A,X,I1,R1);cocsD(A,X,I1,R)),!.

countOfCrossSimpleU(A,X):- cocsU(A,X,A).
cocsU(A,X,0):-X is 0,!.
cocsU(A,X,I):- I1 is I-1, cocsU(A,X1,I1),(nod(A,I1,D),D is 1,X is X1+1;X is X1),!.


%2 Найти делитель числа, являющийся взаимно простым с наибольшим количеством цифр данного числа.
delNum(A,X):- dwmcs(X,A,A,0,0).

dwmcs(X,A,1,CMD,MD):-X is MD,!. 
dwmcs(X,A,I,CMD,MD):- 
    I1 is I-1,
    (
        0 is (A mod I),
        codwsc(COUNT_CROSS_SIMPLE,A,I),
        (
            COUNT_CROSS_SIMPLE >= CMD,
            dwmcs(X,A,I1,COUNT_CROSS_SIMPLE,I);
            dwmcs(X,A,I1,CMD,MD)
        );
        dwmcs(X,A,I1,CMD,MD)
    ),
    !.

codwsc(COUNT_CROSS_SIMPLE,0,DEL):- COUNT_CROSS_SIMPLE is 0,!.
codwsc(COUNT_CROSS_SIMPLE,NUM,DEL):-
    NUM1 is NUM div 10,
    (
        nod(NUM mod 10,DEL,D),
        D is 1,
        codwsc(COUNT_CROSS_SIMPLE1,NUM1,DEL),
        COUNT_CROSS_SIMPLE is COUNT_CROSS_SIMPLE1+1;
        codwsc(COUNT_CROSS_SIMPLE,NUM1,DEL)
    ),
    !.
