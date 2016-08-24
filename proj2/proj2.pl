:- use_module(library(clpfd)).

puzzle_solution([H|T]):-
(   ground([H|T])->  
    true;
    length([H|T],N),
    diaIsSame([H|T],2,N),
    transpose([H|T],L),
    tail(L,Ls),
    valid(T),
    valid(Ls)
    ).


diaIsSame([_|T],X,N):-
    diagonal(T,X,N).

diagonal(_,X,X).
diagonal([H,Q|T],X,N):-  
    P is X +1,
    element(X,H,A),
    element(P,Q,B),
    A #= B,
    diagonal([Q|T],P,N).

equal([H|T]):-
    all_between1and9(T),
    all_different(T),
    (   sum(T,#=,H);
    isProduct([H|T])).

all_between1and9([]).
all_between1and9([H|T]):-
    H #>0,
    H #<10,
    label([H]),
    all_between1and9(T).


isProduct([H|T]):-
    product(T,H).
product([X1],X1).
product([H1|T],X):-
    product(T,P),
    X #= P*H1.
    
valid([]).
valid([H|T]):-
    equal(H),
    valid(T).

tail([_|T],Ls):-
    Ls = T.
    
