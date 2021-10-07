
# divides a list into two lists with the two first elements in one and the rest in the second.
divide_list([A,B|Tail], [A,B], Tail).

# Result is every second element from a list.
every_second([], []).
every_second([A], []).
every_second([A,B], [B]).
every_second([A,B|Tail], [B|Result]):-
    every_second(Tail, Result).

#Number guesser
secret_number(48).
guess(X,'To big!') :-
    secret_number(Num),
    X > Num.
guess(X,'To small!') :-
    secret_number(Num),
    X < Num.
guess(X,'Correct') :-
    secret_number(Num),
    X = Num.
    
#Advanced number guesser
guess_a_number(X,X):-
    write('Correct'),nl.
guess_a_number(X,Y):-
    X < Y,
    write('To small!'),nl,
    write('Give an integer:'),nl,
    read(Guess),
    guess_a_number(Guess, Y).
guess_a_number(X,Y):-
    X > Y,
    write('To big!'),nl,
    write('Give an integer:'),nl,
    read(Guess),
    guess_a_number(Guess, Y).
guess_a_number:-
    secret_number(Num),
    write('Give an integer:'), nl,
    read(Guess),
    guess_a_number(Guess, Num).
                           