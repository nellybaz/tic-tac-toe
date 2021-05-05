class Board

    def initialize()
        @state = ['.','.','.','.','.','.','.','.','.']
    end

    # Set state
    def state=(state)
        @state = state
    end

    # Get state
    def state()
        @state
    end


    # Draw board
    def draw()
        puts "  "+"abc"
        puts "  "+"-"*3
        [0,1,2].each do |index|
            puts "#{index}" + self.get_row(index)
        end
        puts "  "+"-"*3
        
    end

    # Return content of a given row
    def get_row(index)
        limit = 3 * index
        row_output = "|"
        for i in limit..limit+3-1
            row_output += @state[i]
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


end
