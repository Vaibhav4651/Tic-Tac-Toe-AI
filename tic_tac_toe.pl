
% To start the game, query:
% ?- play.


play :-
    write('Welcome to Tic-Tac-Toe!'), nl,
    initial_board(Board),
    display_board(Board),
    % Start the game loop with player 'x'
    game_loop(Board, x).

initial_board([1,2,3,
              4,5,6,
              7,8,9]).

game_loop(Board, Player) :-

    format('Player ~w, enter your move (1-9): ', [Player]),
    read(Move),
    (
        valid_move(Board, Move) ->
            make_move(Board, Move, Player, NewBoard),
            display_board(NewBoard),
            (
                winner(NewBoard, Player) ->
                    format('Player ~w wins! Congratulations!', [Player]), !
                ;
                draw(NewBoard) ->
                    write('The game is a draw!'), !
                ;
                    switch_player(Player, NextPlayer),
                    game_loop(NewBoard, NextPlayer)
            )
        ;
            write('Invalid move. Please try again.'), nl,
            game_loop(Board, Player)
    ).

valid_move(Board, Move) :-
    integer(Move),
    Move >= 1, Move =< 9,
    nth1(Move, Board, Value),
    number(Value).

make_move(Board, Move, Player, NewBoard) :-
    replace(Board, Move, Player, NewBoard).


replace([_|T], 1, X, [X|T]).
replace([H|T], N, X, [H|R]) :-
    N > 1,
    N1 is N -1,
    replace(T, N1, X, R).

switch_player(x, o).
switch_player(o, x).


display_board(Board) :-
    nl,
    format(' ~w | ~w | ~w ', [Board[1], Board[2], Board[3]]), nl,
    write('---+---+---'), nl,
    format(' ~w | ~w | ~w ', [Board[4], Board[5], Board[6]]), nl,
    write('---+---+---'), nl,
    format(' ~w | ~w | ~w ', [Board[7], Board[8], Board[9]]), nl, nl.


win_combination([A,B,C|_], Player) :-
    A = Player, B = Player, C = Player.
win_combination([_|T], Player) :-
    win_combination(T, Player).

winner(Board, Player) :-
    win_combination(Board, Player).

draw(Board) :-
    \+ member(X, Board), 
    \+ integer(X).     

element_at(List, Index, Element) :-
    nth1(Index, List, Element).

display_board(Board) :-
    nl,
    element_at(Board, 1, E1),
    element_at(Board, 2, E2),
    element_at(Board, 3, E3),
    format(' ~w | ~w | ~w ', [E1, E2, E3]), nl,
    write('---+---+---'), nl,
    element_at(Board, 4, E4),
    element_at(Board, 5, E5),
    element_at(Board, 6, E6),
    format(' ~w | ~w | ~w ', [E4, E5, E6]), nl,
    write('---+---+---'), nl,
    element_at(Board, 7, E7),
    element_at(Board, 8, E8),
    element_at(Board, 9, E9),
    format(' ~w | ~w | ~w ', [E7, E8, E9]), nl, nl.
