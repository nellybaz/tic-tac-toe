class Board

    def initialize
        @state = ['0','1','2','3','4','5','6','7','8'] # TODO: initialize with indices
    end


    attr_accessor :state



    # Draw board
    def draw
        # puts "  "+"abc"
        puts "  "+"-"*7
        [0,1,2].each do |index|
            puts " " + self.get_row(index)
        end
        puts "  "+"-"*7
        
    end

    # Return content of a given row
    def get_row(index)
        limit = 3 * index
        row_output = "| "
        for i in limit..limit+3-1
            row_output += @state[i] + " "
        end
        row_output += "|"
        row_output
    end


    def set_cell(cell, symbol)
        @state[cell] = symbol
    end

    def get_cell(cell)
        @state[cell]
    end

    def in_winning_state(symbol)

         # check row 
        winning_state = true

        # index = 0
        (0..2).each do |index|
            limit = 3 * index
            winning_state = true
            for i in limit..limit+3-1
                if @state[i] != symbol
                    winning_state = false
                    break
                end
            end
            # don't check again if there's a winning state in one row
            if winning_state
                return winning_state
            end

            # check col
            winning_state = true
            (index..index+6).step(3) do |col_index|
                if @state[col_index] != symbol
                    winning_state = false
                    break
                end
            end
            if winning_state
                return winning_state
            end
            

        end

        # check diagonals 1
        winning_state = true
        [0,4,8].each do |diag1|
            if @state[diag1] != symbol
                winning_state = false
            end
        end
        if winning_state
            return winning_state
        end

         # check diagonals 2
         winning_state = true
         [2,4,6].each do |diag2|
             if @state[diag2] != symbol
                 winning_state = false
             end
         end

        winning_state
    end

end
