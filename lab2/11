is_prime(1) :- !,fail.
is_prime(X) :- is_prime(2,X).
is_prime(X, X) :- !.
is_prime(K, X) :- Ost is X mod K, Ost = 0, !, fail. % Число делится на K, число не простое.
is_prime(K, X) :- K1 is K+1, is_prime(K1,X). % Проверяем дальше

nod(A, 0, A) :- !.
nod(A, B, X) :- C is A mod B, nod(B, C, X).

fact(N, X, N, X) :- !.
fact(N, X, N1, X1) :- N2 is N1 + 1, X2 is N2 * X1, fact(N, X, N2, X2).
fact(N, X) :- fact(N, X, 0, 1).

read_list(0, []) :- !.
read_list(I, [X|T]) :- read(X), I1 is I - 1, read_list(I1, T).

write_list([]) :- !.
write_list([X|T]) :- write(X), nl, write_list(T).

% 11. Найти сумму непростых делителей числа (рек. вверх)
snd(X, Result) :- snd(X, X, Result).
snd(_, 2, 1) :- !.
snd(X, CurDel, Result) :- NewDel is CurDel - 1, snd(X, NewDel, R1), Ost is X mod CurDel, (Ost = 0, is_prime(CurDel), Result is R1 + CurDel; Result is R1),!.
