%Starts game
guess_a_word:-game(yes).

%End of game
game(no):-
  write('Thanks for a good game!'),nl.

%Game is carried out
game(yes):-
  read_word(Word1),
  read_guess(Word2),
  play(Word1,Word2),
  write('Once more?'),nl,
  read(Answer),
  game(Answer).

%If not game(yes) or game(no), ask again.
game(X):-
  write('Unknown alternative, answer yes or no'),nl,
  read(Answer),
  game(Answer).

%Asks for guess, List is a List of the letters of the guess.
read_guess(List):-
    write('Guess the word'),nl,
    read(Guess),
    atom_chars(Guess, List).

%Asks for word, List is a list of the letters of the word.
read_word(List):-
    write('The game leader gives its word'),nl,
    read(Word),
    atom_chars(Word, List).

%Write correct if the words match.
play(Word,Word):-
    write('Correct!'),nl.

%Not matching words => check for correctly placed letters in guess and occuring letters.
play(Word, Guess):-
    Word\==Guess,
    same_placing(Word,Guess,StarList),
    included_but_not_same_placing(Word,Guess,List),
    output(StarList,List),
    read_guess(NewGuess),
    play(Word, NewGuess).

%If the elements from Word and Guess are the same at the same place,
% include it in StarList else add a star at that position.
same_placing([],_,[]).
same_placing([],[],[]).
same_placing(_,[],[]).
same_placing([A|Word],[B|Guess],[*|StarList]):-
    A\==B,
    same_placing(Word,Guess,StarList).
same_placing([A|Word], [A|Guess], [A|StarList]):-
    same_placing(Word,Guess,StarList).

%Compares the StarList with the actual Word. The letters that are not correctly placed
%in the Word is then compared to the Guess and if they are found in the Guess will be added to
%the result.
included_but_not_same_placing(Word,Guess,Result):-
    same_placing(Word,Guess,Starlist),
    not_correctly_guessed_letters(Starlist,Word, NotCorrectlyGuessed),
    members(NotCorrectlyGuessed,Guess, Result).

%Helper for included_but_not_same_placing
members([],_,[]).
members([A|Tail],List,[A|Result]):-
    member(A,List),!,
    members(Tail,List,Result).
members([A|Tail],List,Result):-
    members(Tail,List,Result).

%Helper for included_but_not_same_placing.
not_correctly_guessed_letters(_,[],[]).
not_correctly_guessed_letters([],[A|Tail],[A]).
not_correctly_guessed_letters([],[],[]).
not_correctly_guessed_letters(Starlist,[A|Tail],[A|Result]):-
    \+member(A,Starlist),
    not_correctly_guessed_letters(Starlist,Tail,Result).
not_correctly_guessed_letters(Starlist,[A|Tail],Result):-
    member(A,Starlist),
    not_correctly_guessed_letters(Starlist,Tail,Result).

output(Starlist,[]):- 
    write(Starlist),nl.

output(Starlist,List):- 
    write(Starlist),
    write('        Occurring letters:'),
    write(List),nl.