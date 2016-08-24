%% Author:      Ding Wang 
%% Student ID:  718712
%% Login name:  dingw2
%% Date: 11 Oct 2015

%% Program description: This program is used to solve the number puzzles problem.

%% Problem Description:
%% -- A number puzzle is a square grid of squares, each to be 
%% -- filled in with a single digit 1–9 (zero is not permitted) 
%% -- satisfying these constraints:
%% --   * each row and each column contains no repeated digits;
%% --   * all squares on the diagonal line from upper left to 
%% --       lower right contain the same value;
%% --   * the heading of reach row and column (leftmost
%% --       square in a row and topmost square in a column) holds 
%% --       either the sum or the product of all the digits in that 
%% --       row or column
%% -- The program is used to solve the number puzzle. 
%% -- The input would be a list of lists, for example:
%% --   Puzzle=[[0,14,10,35],[14,_,_,_],[15,_,_,_],[28,_,1,_]], puzzle_solution(Puzzle).
%% -- where "_" denotes the squares to be filled. The first list
%% -- is the header of columns, the first element of each list 
%% -- is the header of the row.

%% Solving strategy: Find the row of the minimum possible answers, fill it first
%% then transpose the puzzle and find the minimum row and fill it again. Then doing
%% this step recursively until solving the whole puzzle.
%%
%% This program will use the library(clpfd).

:- use_module(library(clpfd)).

%% this predicate to solve the puzzle, first get the size of the puzzle, then unify
%% the diagonal of the puzzle, then fill the puzzle
puzzle_solution([H|T]):-
    length([H|T],N),
    diaIsSame([H|T],2,N),
    fill([H|T]).

%% check the whether from Xth to Nth elements in the diagonal unify
diaIsSame([_|T],X,N):-
    diagonal(T,X,N).
%% check whetherthe Xth element of the first row unifies with the X+1 element in the
%% second row, do this recursivly until check the whole rows list 
diagonal(_,X,X).
diagonal([H,Q|T],X,N):-  
    P is X +1,
    element(X,H,A),
    element(P,Q,B),
    A #= B,
    diagonal([Q|T],P,N).

fill([H|T]):-
%% if the puzzle is filled, just return true
    (   ground([H|T])->  
        true;
%% fill the minimum possible row first, test the puzzle is valid, then transpose the 
%% puzzle and test, do this job recursively
        fill_row([H|T]),
        test(T),
        transpose([H|T],[L|Ls]),
        test(Ls),
        fill([L|Ls])
    ).

test([]).
test([H|T]):-
%% if the row is filled, check whether the row is valid, is not filled, do recursively
        (   ground(H)->  
        valid(H),
            test(T);
        test(T)
        ).

%% find out the not filled row and pick the row with minimum possible answers and fill it
fill_row(L):-
    notGroundRows(L,Ls),
    bestrow(Ls,H),
    valid(H).

%% find the unfilled rows and return it
notGroundRows([],[]).
notGroundRows([H|T],Ls):-
    (   ground(H)->  
        notGroundRows(T,Ls);
        append([H],Hs,Ls),
        notGroundRows(T,Hs)
    ).

%% find the row with minimum possible answers     
bestrow([H],H).
bestrow([H1,H2|T],X):-
    numOfPossi(H1,N1),
    numOfPossi(H2,N2),
    (   N1>=N2->  
    bestrow([H2|T],X);
    bestrow([H1|T],X)
    ).

%% calculate the number of all possible answers to fill the row 
numOfPossi(L,N):-
    findall(_,valid(L),Ls),
        length(Ls,N1),
        N = N1.

%% check whether the row is valid, if it is, fill it with one of its answers
valid([H|T]):-
%% the answers number should between 1 and 9
    all_between1and9(T),
%% all the numbers should be different
    all_different(T),
%% the first element in the list should be either the sum or the product of the 
%% remaining numbers
    (   sum(T,#=,H);
    isProduct([H|T])).

%% check the list elements all between 1 and 9. If [H] has multiple possiblities, out
%% put one by one by using label([H])
all_between1and9([]).
all_between1and9([H|T]):-
    H #>0,
    H #<10,
    label([H]),
    all_between1and9(T).

%% check whether the first element of a list is the product of the remaining elements
isProduct([H|T]):-
    product(T,H).
%% output the product of the list[H1|T] to X
product([X1],X1).
product([H1|T],X):-
    product(T,P),
    X #= P*H1.

