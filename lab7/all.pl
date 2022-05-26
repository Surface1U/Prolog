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
%3 Дан список. Построить массив из элементов, делящихся на свой номер и встречающихся в исходном массиве 1 раз.
isElemUnique(List,Elem):-countOfThisElem(List,Elem,Count),1 is Count.

countOfThisElem([],Elem,Count):- Count is 0,!.
countOfThisElem([H|T],Elem,Count):-
    H = Elem,

    countOfThisElem(T,Elem,Count1),
    Count is 1+Count1;

    countOfThisElem(T,Elem,Count),!.   

listUniqueWithIndex(List,UniList,UniIndexList):-listUniqueWithIndex(List,UniList,UniIndexList,0,List).
listUniqueWithIndex([],UniList,UniIndexList,Index,StartList):-makeEmptyList(UniList),makeEmptyList(UniIndexList),!.
listUniqueWithIndex([H|T],UniList,UniIndexList,Index,StartList):-
    I1 is Index+1,
    (
        isElemUnique(StartList,H),

        listUniqueWithIndex(T,UniList1,UniIndexList1,I1,StartList),
        append([H],UniList1,UniList),
        append([I1],UniIndexList1,UniIndexList);

        listUniqueWithIndex(T,UniList,UniIndexList,I1,StartList)
    ),!.

listDelOnAnotherList([],[],NewList).
listDelOnAnotherList([UH|UT],[IH|IT],NewList):-
    0 is UH mod IH,

    listDelOnAnotherList(UT,IT,NewList1),
    append([UH],NewList1,NewList),!;

    listDelOnAnotherList(UT,IT,NewList),!.

listDelOnIndexAndUnique(List,NewList):-
    listUniqueWithIndex(List,UniList,UniIndexList),
    listDelOnAnotherList(UniList,UniIndexList,NewList).

task3:- read(N),readList(List,N),listDelOnIndexAndUnique(List,NewList),writeList(NewList),!.
%4 Беседует трое друзей: Белокуров, Рыжов, Чернов. Брюнет
% сказал Белокурову: “Любопытно, что один из нас блондин, другой брюнет,
% третий - рыжий, но ни у кого цвет волос не соответствует фамилии”. Какой
% цвет волос у каждого из друзей?
inList([],_):-fail.
inList([X|_],X).
inList([_|T],X):-inList(T,X).

task4:- 
    Hairs=[_,_,_],
    inList(Hairs,[belov,_]),
    inList(Hairs,[chernov,_]),
    inList(Hairs,[rijov,_]),
    inList(Hairs,[_,rij]),
    inList(Hairs,[_,blond]),
    inList(Hairs,[_,brunet]),
    not(inList(Hairs,[belov,blond])),
    not(inList(Hairs,[chernov,brunet])),
    not(inList(Hairs,[rijov,rij])),
    write(Hairs),
    !.

%5 Три подруги вышли в белом, зеленом и синем платьях и туфлях. Известно, что только у Ани цвета платья и туфлей совпадали.
% Ни туфли, ни платье Вали не были белыми. Наташа была в зеленых туфлях. Определить цвета платья и туфель на каждой из подруг.
task5:- 
    Kortej=[_,_,_],
    inList(Kortej,[anya,X,X]),
    inList(Kortej,[valya,_,_]),
    inList(Kortej,[nastya,zel,_]),
    inList(Kortej,[_,bel,_]),
    inList(Kortej,[_,sin,_]),
    inList(Kortej,[_,zel,_]),
    inList(Kortej,[_,_,bel]),
    inList(Kortej,[_,_,sin]),
    inList(Kortej,[_,_,zel]),
    not(inList(Kortej,[valya,bel,_])),
    not(inList(Kortej,[valya,_,bel])),
    not(inList(Kortej,[nastya,Y,Y])),
    write(Kortej),
    !.
%6 На заводе работали три друга: слесарь, токарь и сварщик. Их фамилии Борисов, Иванов и Семенов. У слесаря нет ни братьев, ни сестер. Он
%самый младший из друзей. Семенов, женатый на сестре Борисова, старше токаря. Назвать фамилии слесаря, токаря и сварщика.
task6:- 
    Kortej=[_,_,_],
    inList(Kortej,[slesar,_,0,0,_]),
    inList(Kortej,[tokar,_,_,1,_]),
    inList(Kortej,[svarshick,_,_,_,_]),
    inList(Kortej,[_,semenov,_,2,borisov]),
    inList(Kortej,[_,ivanov,_,_,_]),
    inList(Kortej,[_,borisov,1,_,_]),
    write(Kortej),
    !.

%7 В бутылке, стакане, кувшине и банке находятся молоко, лимонад, квас и вода. Известно, что вода и молоко не в бутылке, 
% сосуд с лимонадом находится между кувшином и сосудом с квасом, в банке - не лимонад и не вода. Стакан находится около банки и сосуда с молоком.
% Как распределены эти жидкости по сосудам.
right(_,_,[_]):-fail.
right(A,B,[A|[B|_]]).
right(A,B,[_|List]):-right(A,B,List).

left(_,_,[_]):-fail.
left(A,B,[B|[A|_]]).
left(A,B,[_|List]):-left(A,B,List).

next(A,B,List):-right(A,B,List).
next(A,B,List):-left(A,B,List).

task7:- 
    Kortej=[_,_,_,_],
    inList(Kortej,[bottle,_]),
    inList(Kortej,[glass,_]),
    inList(Kortej,[kuvshin,_]),
    inList(Kortej,[jar,_]),
    inList(Kortej,[_,leche]),
    inList(Kortej,[_,lemonade]),
    inList(Kortej,[_,kvas]),
    inList(Kortej,[_,agua]),
    not(inList(Kortej,[bottle,leche])),
    not(inList(Kortej,[bottle,agua])),
    not(inList(Kortej,[jar,lemonade])),
    not(inList(Kortej,[jar,agua])),
    right([kuvshin,_],[_,lemonade],Kortej),
    right([_,lemonade],[_,kvas],Kortej),
    next([glass,_],[jar,_],Kortej),
    next([glass,_],[_,leche],Kortej),
    write(Kortej),
    !.
%8 
/*
Воронов, Павлов, Левицкий и Сахаров – четыре талантли-
вых молодых человека. Один из них танцор, другой художник, третий-певец,
а четвертый-писатель. О них известно следующее: Воронов и Левицкий си-
дели в зале консерватории в тот вечер, когда певец дебютировал в сольном
концерте. Павлов и писатель вместе позировали художнику. Писатель написал
биографическую повесть о Сахарове и собирается написать о Воронове. Воро-
нов никогда не слышал о Левицком. Кто чем занимается? */
task8 :-
    Kortej = [_,_,_,_],
    inList(Kortej,[voronov,_]),
    inList(Kortej,[pavlov,_]),
    inList(Kortej,[levizkiy,_]),
    inList(Kortej,[saharov,_]),
    inList(Kortej,[_,dancer]),
    inList(Kortej,[_,artist]),
    inList(Kortej,[_,singer]),
    inList(Kortej,[_,writer]),
    not(inList(Kortej,[voronov,singer])),
    not(inList(Kortej,[levizkiy,singer])),
    not(inList(Kortej,[pavlov,writer])),
    not(inList(Kortej,[pavlov,artist])),
    not(inList(Kortej,[saharov,writer])),
    not(inList(Kortej,[voronov,writer])),
    (
        inList(Kortej,[voronov,artist]), % Так как Воронов не слышал о Левицком, то он не мог его рисовать, если он является художником
        not(inList(Kortej,[levizkiy,writer]));

        not(inList(Kortej,[voronov,artist])) % иначе
    ),
    write(Kortej),
    !.

%9
/*
Три друга заняли первое, второе, третье места в соревнова-
ниях универсиады. Друзья разной национальности, зовут их по-разному, и лю-
бят они разные виды спорта. Майкл предпочитает баскетбол и играет лучше,
чем американец. Израильтянин Саймон играет лучше теннисиста. Игрок в кри-
кет занял первое место. Кто является австралийцем? Каким спортом увлека-
ется Ричард?*/
task9:- 
    Kortej = [_,_,_],
    inList(Kortej,[maikl,_,basket,A]),
    inList(Kortej,[saimon,israel,_,C]),
    inList(Kortej,[_,_,cricket,1]),
    inList(Kortej,[richard,_,_,_]),
    inList(Kortej,[_,_,tenis,D]),
    inList(Kortej,[_,american,_,B]),
    inList(Kortej,[_,australian,_,_]),
    inList(Kortej,[_,_,_,2]),
    inList(Kortej,[_,_,_,3]),
    not(inList(Kortej,[maikl,american,_,_])),
    not(inList(Kortej,[saimon,_,tenis,_])),
    A<B,
    C<D,
    write(Kortej),
    !.
