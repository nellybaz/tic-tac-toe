class Board

    def initialize()
        @state = ['.','.','.','.','.','.','.','.','.']
        print "Welcome to Tic-Tac-Toe"
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
        print "  "+"abc"
        puts
        print "  "+"-"*3
        puts ""
        print "0" + self.get_row(0)
        puts ""
        print "1" + self.get_row(1)
        puts ""
        print "2" + self.get_row(2)
        puts
        print "  "+"-"*3
        puts
        
        puts
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

end
