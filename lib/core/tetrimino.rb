require './utility/point'
require './color'

# Represents a Tetrimino object or, a piece in Tetris.
# Params:
# Blocks: a 2-Dimensions array of 1 (blocks) and 0 (empty space)
# to represent the Tetrimino from top to bottom, left to right.
#
# Example:
# Tetrimino.new([[0, 1, 1], [1, 1, 0]])
# would create an S-shape Tetrimino:
#  ██
# ██
class Tetrimino
    # Constructor of the Tetrimino
    def initialize(blocks, color)
        @anchorPosition = Point.new
        @blocks = blocks
        @cache = blocks
        @dirty = false
        @angle = [:TOP, :LEFT, :BOTTOM, :RIGHT]
        @color = color
    end

    # Returns the angle of the Tetrimino.
    def angle
        @angle.first
    end

    def color
        @color
    end

    def color=(val)
        @color = val
    end

    def position
        @anchorPosition
    end

    def position=(val)
        @anchorPosition = val
    end

    # Returns if the cache is considered dirty or not (true / false).
    def dirty?
        @dirty
    end

    # Returns the length (x-axis) of the Tetrimino.
    def length
        @blocks[0].size
    end

    # Alias for length
    def width
        length
    end

    # Returns the height (y-axis) of the Tetrimino.
    def height
        @blocks.size
    end

    # Returns an array containing the definition of the Tetrimino.
    # Positions containing 1 are solid cubes while the ones containing 0
    # are empty cubes.
    def array
        if self.dirty?
            case self.angle
            when :TOP
                @cache = @blocks
            when :LEFT
                @cache = @blocks.transpose.reverse
            when :BOTTOM
                @cache = @blocks.reverse.map { |x| x.reverse}
            when :RIGHT
                @cache = @blocks.transpose.map { |x| x.reverse }
            end
            @dirty = false
        end
        return @cache
    end

    # Returns 2 list of points that should be checked while handling x-axis collisions.
    # The first list contains the points on the left of the Tetrimino, while the
    # second contains the points on the right of the Tetrimino.
    def x_points
        blocks = self.array
        points = [[],[]]

        (0...blocks.size).each { |y|
            (0...blocks[0].size).each { |x|
                if blocks[y][x] == 1 && (x - 1 < 0 || blocks[y][x - 1] == 0)
                    points[0] << Point.new(x - 1, y)
                end

                if blocks[y][x] == 1 && (x + 1 >= length || blocks[y][x + 1] == 0)
                    points[1] << Point.new(x + 1, y)
                end
            }
        }

        return points
    end

    # Returns a list of points that should be checked while handling y-axis collisions.
    # These positions are only the ones bellow the Tetrimino since the Tetrimino can only fall.
    def y_points
        blocks = array
        points = []
        (0...blocks[0].size).each{ |x|
            (0...blocks.size).reverse_each{ |y|
                if blocks[y][x] == 1 && (y + 1 >= height || blocks[y + 1][x] == 0)
                    points << Point.new(x, y + 1)
                end
            }
        }

        return points
    end

    # Rotates the Tetrimino clockwise.
    def rotate_cw
        @angle.rotate!(-1)
        @dirty = true
        return self
    end

    # Rotates the Tetrimino counter clockwise.
    def rotate_ccw
        @angle.rotate!(1)
        @dirty = true
        return self
    end

    # Converts the Tetrimino to a string.
    def to_s
        return self.array.map{|x| x.map {|y| y == 1 ? '█' : ' '}.join }.join("\n")
    end
end
