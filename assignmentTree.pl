/* Family Tree Program */

/* facts */
wife(george, mum).
wife(spencer, kydd).
wife(philip, elizabeth).
wife(charles, diana).
wife(mark, anne).
wife(andrew, sarah).
son(elizabeth, charles).
son(elizabeth, andrew).
son(elizabeth, edward).
son(philip, charles).
son(philip, andrew).
son(philip, edward).
son(diana, william).
son(diana, harry).
son(charles, william).
son(charles, harry).
son(mark, peter).
son(anne, peter).
daughter(elizabeth, anne).
daughter(philip, anne).
daughter(mark, zara).
daughter(anne, zara).
daughter(andrew, eugenie).
daughter(andrew, beatrice).
daughter(sarah, eugenie).
daughter(sarah, beatrice).
daughter(spencer, diana).
daughter(kydd, diana).
daughter(george, margaret).
daughter(mum, margaret).
daughter(mum, elizabeth).
daughter(george, elizabeth).

/* rules */
husband(H,X):-
wife(X,H).

spouse(S,X):-
wife(X,S);
husband(X,S).

child(P,X):-
son(P,X);
daughter(P,X).

parent(C,X):-
child(X,C).

grandchild(G, X):-
child(G,P),
child(P,X).

grandparent(G, X):-
parent(G, P),
parent(P, X).

greatGrandparent(Child, GGrandparent):-
grandparent(Child, Grandparent),
parent(Grandparent, GGrandparent).

brother(B, X):-
child(P, B),
son(P,X),
not(daughter(P,X)),
not(wife(P,_)),
not(B=X).

sister(S, X):-
child(P, S),
daughter(P,X),
not(son(P,X)),
not(husband(P,_)),
not(S=X).

sibling(Person, Sibling):-
brother(Person, Sibling);
sister(Person, Sibling).

sisterInLaw(Person, Sister):-
(
sibling(Person, Sibling),
wife(Sibling, Sister)
);
(
  spouse(Person, Spouse),
  sibling(Spouse, Sibling),
  wife(Sibling, Sister)
);
(
  spouse(Person, Spouse),
  sister(Spouse, Sister)
).

brotherInLaw(Person, Brother):-
(
sibling(Person, Sibling),
husband(Sibling, Brother)
);
(
  spouse(Person, Spouse),
  sibling(Spouse, Sibling),
  husband(Sibling, Brother)
);
(
  spouse(Person, Spouse),
  brother(Spouse, Brother)
).

uncle(Child, Uncle):-
parent(Child, Parent),
(
  brother(Parent, Uncle);
  (
    sister(Parent, Sister),
    husband(Sister, Uncle)
  )
).

aunt(Child, Aunt):-
parent(Child, Parent),
(
  sister(Parent, Aunt);
  (
    brother(Parent, Sister),
    wife(Sister, Aunt)
  )
).

firstCousin(Person, Cousin):-
grandparent(Person, Grandparent),
wife(Grandparent, _),
grandparent(Cousin, Grandparent),
not(sibling(Person,Cousin)),
not(Person=Cousin).