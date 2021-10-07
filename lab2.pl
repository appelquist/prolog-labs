# Result is odd numbers from a List of numbers
odd_numbers([],[]).
odd_numbers([H|Tail],[H|Result]):-
    odd(H),!,
    odd_numbers(Tail, Result).
odd_numbers([H|Tail], Result):-
    even(H),!,
    odd_numbers(Tail, Result).

odd(Number):-
    1 is Number mod 2.
even(Number):-
    0 is Number mod 2.

#Delete element from list
delete(_,[],[]).
delete(Elem, [Elem|List1], List2):-
    delete(Elem, List1, List2).
delete(Elem, [H|List1], [H|List2]):-
    delete(Elem, List1, List2).

#Delete element from list with green cut
delete_green_cut(_,[],[]).
delete_green_cut(Elem, [Elem|List1], List2):-
    delete_green_cut(Elem, List1, List2),!.
delete_green_cut(Elem, [H|List1], [H|List2]):-
    delete_green_cut(Elem, List1, List2).