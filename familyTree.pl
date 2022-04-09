/* Family Tree Program */

/* facts */
male(jack).
male(bill).
male(john).
female(dorothy).
female(evelyn).
female(grace).
female(liz).
parent(dorothy, evelyn).
parent(jack, evelyn).
parent(jack, grace).
parent(bill, liz).
parent(evelyn, liz).
parent(bill, john).
parent(evelyn, john).

/* rules */
mother(M,X):-
parent(M,X),
female(M).

father(F,X):-
parent(F,X),
male(F).

grandparent(G, X):-
parent(G,P),
parent(P,X).

brother(S,X):-
parent(Z,X),
parent(Z,S),
female(S),
not(S=X).

findMother:-
write('Whose mother do you want to find? '),
read(Name),
mother(X,Name),
write('The mother of '), write(Name), write(' is '), write(X), nl.
