require_relative "./board"



class Game
    def initialize()
        puts "Welcome to Tic-Tac-Toe"
        puts
        @game_is_playing = false
        @current_player = 1
        @board = Board.new
        @valid_games = {"a0" => 0, "b0" => 1, "c0"=>2, "a1"=>3, "b1"=>4, "c1"=>5, "a2"=>6, "b2"=>7, "c2"=>8}
    end

    # Getters start ==========
    def game_is_playing()
        @game_is_playing
    end

    def current_player()
        @current_player
    end

    def valid_games()
        @valid_games
    end

    # Getters end  =========


    def current_symbol()
        return @current_player == 1 ? "x" : "o"
    end


    def is_valid_move(game)
        @valid_games.key?(game)
    end


    def next_player()
        if @current_player == 1
            @current_player = 2
        else
            @current_player = 1
        end
    end

    def start()
        @board.draw
        @game_is_playing = true
        while @game_is_playing || true # TODO: implement the win, draw, or out of move function 
            puts "Player #{@current_player}'s turn [e.g a0, b2, c1]:"
            game = gets.chomp

            while !self.is_valid_move(game)
                puts "Invalid move, retry"
                game = gets.chomp
            end

            cell = @valid_games[game]
            @board.set_cell(cell, self.current_symbol)
            @board.draw
            self.next_player
            @game_is_playing = false
            
        end

    end

end

