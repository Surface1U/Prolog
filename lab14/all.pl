makeEmptyList([]).

readS(Str,N,IsLast):-get0(Char),readS(Char,Str,[],N,0,IsLast). % чтение строки из файла
readS(-1,Str,Str,N,N,1):-!.
readS(10,Str,Str,N,N,0):-!.
readS(Char,Str,NowStr,N,I,IsLast):-I1 is I+1,append(NowStr,[Char],NowStr1),get0(Char1),readS(Char1,Str,NowStr1,N,I1,IsLast).

readOneS(Str,N):-get0(Char),readOneS(Char,Str,[],N,0). % чтение одной строки из файла
readOneS(10,Str,Str,N,N):-!.
readOneS(-1,Str,Str,N,N):-!.
readOneS(Char,Str,NowStr,N,I):-I1 is I+1,append(NowStr,[Char],NowStr1),get0(Char1),readOneS(Char1,Str,NowStr1,N,I1).

readListS(List):-readS(Str,_,IsLast),readListS([Str],List,IsLast). % чтение из файла списка строк
readListS(List,List,1):-!.
readListS(Cur_list,List,0):-
	readS(Str,_,IsLast),append(Cur_list,[Str],C_l),readListS(C_l,List,IsLast).
	
readS(Str,N):-readS(Str,N,0). % чтение строки длины N

writeS([]):-!. %вывод стринга
writeS([H|T]):-put(H),writeS(T).

writeListS([]):-!. %вывод списка стрингов
writeListS([H|T]):-writeS(H),nl,writeListS(T).

writeList([]):-!.
writeList([H]):-write(H).
writeList([H|T]):- write(H),write(' '),writeList(T).

append([],X,X).
append([X|T],Y,[X|T1]) :- append(T,Y,T1).

listLength([],0).
listLength([_|T],I):-listLength(T,I1),I is I1 + 1.
%1.1 Дана строка. Вывести ее три раза через запятую и показать количество символов в ней.
task11:-readS(Str,N,0),writeS(Str),write(", "),writeS(Str),write(", "),writeS(Str),write(" , "),write(N).
%1.2 Дана строка. Найти количество слов.
countOfWords([],Count):-Count is 1,!.
countOfWords([H|T],Count):-
	(
		H is 32,
		
		countOfWords(T,Count1),
		Count is Count1+1;

		countOfWords(T,Count)
	),!.

task12:-readS(Str,N,0),countOfWords(Str,Count),write(Count).
%1.3 Дана строка, определить самое частое слово
getListOfWordsFromStr(Str,List):-getListOfWordsFromStr(Str,List,[]).
getListOfWordsFromStr([],WordsList,NowWord):-append([NowWord], [],WordsList).
getListOfWordsFromStr([H|T],WordsList,NowWord):-
	(
		not(H is 32),
		
		append(NowWord,[H],NowWord1),
		getListOfWordsFromStr(T,WordsList,NowWord1);

		getListOfWordsFromStr(T,WordsList1,[]),
		append([NowWord],WordsList1,WordsList)
	),!.

mostRatedWordFromList(WordsList,Word):-mostRatedWordFromList(WordsList,Word,[],-1,WordsList).
mostRatedWordFromList([],Word,NowWord,Count,StartList):-append([],NowWord,Word),!.
mostRatedWordFromList([WordsListH|WordsListT],Word,NowWord,Count,StartList):-
	countOfThisWordInList(StartList,WordsListH,NowCount),
	(
		NowCount>Count,

		mostRatedWordFromList(WordsListT,Word,WordsListH,NowCount,StartList);

		mostRatedWordFromList(WordsListT,Word,NowWord,Count,StartList)
	),!.
countOfThisWordInList([],Word,NowCount):- NowCount is 0,!.
countOfThisWordInList([StartListH|StartListT],Word,NowCount):-
	StartListH = Word,

	countOfThisWordInList(StartListT,Word,NowCount1),
	NowCount is NowCount1+1,!;

	countOfThisWordInList(StartListT,Word,NowCount),!.

mostRatedWordFromStr(Str,Word):-
	getListOfWordsFromStr(Str,WordsList),
	mostRatedWordFromList(WordsList,Word).

task13:-readS(Str,N,0),mostRatedWordFromStr(Str,Word),writeS(Word).

%1.4 Дана строка. Вывести первые три символа и последний три символа, если длина строки больше 5, иначе вывести первый символ столько раз, какова длина строки.
writeFirstAndLastThree([Fchar|StrT]):- writeFirstAndLastThree([Fchar|StrT],3),!.
writeFirstAndLastThree([Fchar|StrT],N):-
	N>0,
	cutLastChar(StrT,NewStr,Lchar),
	write(Fchar),
	N1 is N-1,
	writeFirstAndLastThree(NewStr, N1),
	write(Lchar),!;
	1 is 1,!.

cutLastChar([Lchar],NewStr,Lchar):-makeEmptyList(NewStr),!.
cutLastChar([StrH|StrT],NewStr,Lchar):-
	cutLastChar(StrT,NewStr1,Lchar),
	append([StrH],NewStr1,NewStr),!.

writeNTimesFirst([StrH|StrT],N):-
	N>0,
	write(StrH),
	N1 is N-1,
	writeNTimesFirst([StrH|StrT],N1),!;
	1 is 1,!.

task14:-
	readS(Str,N,0),
	(
		N>5,

		writeFirstAndLastThree(Str),!;
		writeNTimesFirst(Str,N)
	),!.
