require_relative "./board"



class Game
    def initialize
        puts "Welcome to Tic-Tac-Toe"
        puts
        @game_is_playing = false
        @current_player = 1
        @board = Board.new
        @valid_games = {"0" => 0, "1" => 1, "2"=>2, "3"=>3, "4"=>4, "5"=>5, "6"=>6, "7"=>7, "8"=>8}
    end

    attr_reader :game_is_playing, :current_player, :valid_games



    def current_symbol
        return @current_player == 1 ? "X" : "O"
    end


    def is_valid_move(game)
        @valid_games.key?(game)
    end


    def next_player
        if @current_player == 1
            @current_player = 2
        else
            @current_player = 1
        end
    end

    def start
        @board.draw
        @game_is_playing = true
        while @game_is_playing || true # TODO: implement the win, draw, or out of move function 
            puts "Player #{@current_player}'s turn [e.g a0, b2, c1]:"
            game = gets.chomp

            while !self.is_valid_move(game)
                puts "Invalid move, retry"
                game = gets.chomp
            end

            # TODO: check if cell is empty

            cell = @valid_games[game]
            @board.set_cell(cell, self.current_symbol)
            @board.draw
            self.next_player
            #@game_is_playing = false
            
        end

    end

end

