require './tetrimino'

class Board
    def initialize(width, height, nextpieces, *tetriminos)
        @width = width
        @height = height
        @nextPieces = Array.new(nextpieces) # nextpieces is an int (number of next pieces)
        @tetriminos = tetriminos
        @currentTetrimino = nil
        @reserve = nil
        @reserve_used = false
        @rng_bag = Array.new(@tetriminos.size)
        @playArea = Array.new(height) { Array.new(width) }
    end

    def get_next_piece
        if @rng_bag.empty?
            @rng_bag = @tetriminos.sample(@tetriminos.size)
        end
        return @rng_bag.shift
    end

    def swap_piece
        if not reserve_used and @reserve
            @currentTetrimino, @reserve = @reserve, @currentTetrimino
            @currentTetrimino.position = Point.new # TODO: Spawn Tetrimino in the middle of the playing area
        end
    end
end
