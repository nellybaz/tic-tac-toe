require_relative "./board"



class Game
    def initialize
        puts "Welcome to Tic-Tac-Toe"
        puts
        @game_is_playing = false
        @current_player = 1
        @board = Board.new
        @valid_games = {"0" => 0, "1" => 1, "2"=>2, "3"=>3, "4"=>4, "5"=>5, "6"=>6, "7"=>7, "8"=>8}
        @againts_computer = false
    end

    attr_reader :game_is_playing, :current_player, :valid_games, :board



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
        puts "Enter Y to play against the computer"
        decision = gets.chomp
        if decision == 'Y' or decision == 'y'
            @againts_computer = true
        end

        @board.draw
        @game_is_playing = true
        while @game_is_playing
            puts self.game_turn_text

            cell = self.get_and_validate_user_input
            
            @board.set_cell(cell, self.current_symbol)
            @board.draw
            if !self.check_winner
                self.check_draw
            end
            self.next_player
            
        end

    end

    def game_turn_text
        return @againts_computer && @current_player == 1 ? "Computer's turn": 
        @againts_computer && @current_player == 2 ?  "Your turn": "Player #{@current_player}'s turn [e.g 1,4,7,0]"
    end

    def game_winner_text
        return @againts_computer && @current_player == 1 ? "🤖 Computer 🤖 won": 
        @againts_computer && @current_player == 2 ? "You won" :"Player #{@current_player} won"
    end

    def check_winner
        if @board.in_winning_state(self.current_symbol)
            @game_is_playing = false
            puts self.game_winner_text
            puts "Game over 😎"
            true
        end
        false
    end

    def check_draw
        if @board.in_draw_state
            @game_is_playing = false
            puts "It's a draw"
            puts "Game over 😎"
        end
    end

    def get_and_validate_user_input

        # If computer is playing, make move here
        if @againts_computer && @current_player == 1
            cell = self.get_computer_move
            puts "🤖 Computer played #{cell} 🤖"
            return cell
        end

        move = gets.chomp
        while !self.is_valid_move(move)
            puts "Invalid move, retry"
            move = gets.chomp
        end

        cell = @valid_games[move]
        current_cell = @board.get_cell(cell)
        while current_cell == 'X' || current_cell == 'O'
            puts 'Cell is not empty, please retry'
            move = gets.chomp

            #simply this
            cell = @valid_games[move]
            current_cell = @board.get_cell(cell)
        end

        cell
    end

    def get_computer_move
        move = rand(9)
        current_cell = @board.get_cell(move)
        while current_cell == 'X' || current_cell == 'O'
            move = rand(9)
            current_cell = @board.get_cell(move)
        end

        move
    end

end

