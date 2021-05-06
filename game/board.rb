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


end
