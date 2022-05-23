%1 Дан целочисленный массив и отрезок a..b. Необходимо найти количество элементов, значение которых принадлежит этому отрезку.
append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

readList(X,Y):-readList([],X,0,Y).
readList(A,A,G,G):-!.
readList(A,B,C,D):- C1 is C+1,read(X),append(A,[X],A1),readList(A1,B,C1,D).

writeList([]):-!.
writeList([H]):-write(H).
writeList([H|T]):- write(H),write(' '),writeList(T).

makeEmptyList([]).

countElemInAB([],A,B,Count):-Count is 0,!.
countElemInAB([H|T],A,B,Count):-
    (
        B >= H,
        H >= A,
        countElemInAB(T,A,B,Count1),
        Count is Count1+1;
        countElemInAB(T,A,B,Count)
    ).

task1:- read(N),readList(List,N),read(A),read(B),countElemInAB(List,A,B,Count),write(Count),!.
%2Дан массив чисел. Необходимо проверить, чередуются ли в нем целые и вещественные числа.
isInt(A):-
    IntA is round(A),
    IntA = A.

isFloatIntAlternate([H|T],Flag):- 
    isInt(H),

    isFloatIntAlternate(T,Flag,1);

    isFloatIntAlternate(T,Flag,0).
isFloatIntAlternate([],Flag,NowFlag):-Flag is 1,!.
isFloatIntAlternate([H|T],Flag,NowFlag):-
    (
        isInt(H),
        NowFlag is 0,

        isFloatIntAlternate(T,Flag,1)
    );
    (
        not(isInt(H)),
        NowFlag is 1,

        isFloatIntAlternate(T,Flag,0)
    );
    (
        Flag is 0
    ).
    
task2:- read(N),readList(List,N),isFloatIntAlternate(List,Flag),write(Flag),!.
