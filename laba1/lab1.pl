man(ruslan).
man(rasul).
man(ruzik).
man(rolan).
man(rodovid).
man(rasheet).
man(ramzan).
man(rafik).

woman(razina).
woman(rufina).
woman(roof).
woman(rusalina).
woman(rimma).
woman(rafshana).
woman(roberta).
woman(rikarda).

parent(rimma,ruslan).
parent(rasheet,ruslan).
parent(rimma,razina).
parent(rasheet,razina).

parent(rafik,rasheet).
parent(roof,rasheet).
parent(rafik,rufina).
parent(roof,rufina).

parent(ramzan,roof).
parent(rusalina,roof).

parent(roberta,rimma).
parent(ruzik,rimma).
parent(roberta,rasul).
parent(ruzik,rasul).

parent(rolan,ruzik).
parent(rafshana,ruzik).

men:-man(X),write(X),nl,fail.

%11
son(X,Y):-parent(Y,X),man(X).
son(X):-parent(X,Y),man(Y),write(Y).

%12
sister(X,Y):-parent(Z,X),parent(Z,Y),woman(X),!.
sisters(X):-sister(Y,X), write(Y).

%13
grand_ma(X,Y):-parent(X,Z),parent(Z,Y),woman(X).
grand_max(X):-grand_ma(Y,X),write(Y),nl,fail.
%14
grand_ma_and_da(X,Y):-(
    parent(X,Z),parent(Z,Y),man(X),woman(Y);
    parent(Y,Z),parent(Z,X),woman(X),man(Y)
).

%15
maxup(X,X):-X<10,!.
maxup(X,Max):-
    X1 is X div 10,
    X2 is X mod 10,

maxup(X1,Max1),
(X2<Max1, Max is Max1; Max is X2).

%16
maxdown(X,Max):-maxdown(X,0,Max).
maxdown(0,Max,Max):-!.
maxdown(X,C,Max):-
    X1 is X div 10,
    D1 is X mod 10,
    D1>C, !,
    maxdown(X1,D1,Max);
    X2 is X div 10,
    maxdown(X2,C,Max).
    
%17
sm(0,0):-!.
sm(X,Y):-X1 is X mod 10, X2 is X div 10,sm(X2,Y1),Y is Y1+X1,
    0 is X1 mod 3,!.
sm(X,Y):-X2 is X div 10,sm(X2,Y).

%19
fib(1,1).
fib(0,0).
fib(X,Y):-
    X>1,X1 is X-1,
    X2 is X-2,
    fib(X1,Y1),
    fib(X2,Y2),
    Y is Y1+Y2.

%20
fib1(N,X):-fib1(0,1,1,N,X).
 fib1(_,Res,N,N,Res):-!.
fib1(X1,X2,I,N,Res):-
    X is X1+X2,
    I1 is I+1,
    fib1(X1,X,I1,N,Res).
    
%18
sum(X,R):-sum(X,0,R).
sum(0,T,T):-!.
sum(X,P,R):-D is X mod 10,
    0 is D mod 3,
    P1 is (D+P),
    X1 is X div 10,
    sum(X1,P1,R);
    X2 is X div 10,
    sum(X2,P,R).







