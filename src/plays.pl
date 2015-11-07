% Plays

place_xpiece(Game, Coords, New_game):-
        game_board(Game, Board),
        num_jokers_to_place(Board, 0), !,
        game_player(Game, Player),
        board_xy(Board, Coords, Cell),
        cell_xpiece(Cell, -1),
        cell_spieces(Cell, Spieces),
        cell_spieces(New_cell, Spieces),
        cell_xpiece(New_cell, Player),
        board_set_cell(Board, Coords, New_cell, New_board),
        game_dec_player_num_xpieces(Game, Player, Game1),
        game_set_board(Game1, New_board, New_game).

place_joker(Game, Coords, New_game) :-
        game_board(Game, Board),
        board_xy(Board, Coords, Cell),
        cell_xpiece(Cell, -1),
        cell_spieces(Cell, Spieces),
        cell_spieces(New_cell, Spieces),
        cell_xpiece(New_cell, 0),
        board_set_cell(Board, Coords, New_cell, New_board),
        game_set_board(Game, New_board, New_game),
        check_patterns(New_game, []).