class Player
    def initialize(game)
        @score = 0
        @linesCleared = 0
        @game = game
        @board = Board.new
    end
end
