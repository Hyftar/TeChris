require './utility/point'
require './core/color'
require './core/block'
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
  attr_accessor :color, :position

  # Constructor of the Tetrimino
  def initialize(blocks)
    @position = Point.new
    @angles =
      [blocks,
       blocks.transpose.reverse,
       blocks.reverse.map(&:reverse),
       blocks.transpose.map(&:reverse)]
  end

  # Returns the length (x-axis) of the Tetrimino.
  def length
    array.first.size
  end

  alias width length

  # Returns the height (y-axis) of the Tetrimino.
  def height
    array.size
  end

  alias size height

  # Returns an array containing the definition of the Tetrimino.
  # Positions containing 1 are solid blocks while the ones containing 0
  # are empty blocks.
  def array
    @angles.first
  end

  alias blocks array

  # Returns 2 list of points that should be checked while handling x-axis collisions.
  # The first list contains the points on the left of the Tetrimino, while the
  # second contains the points on the right of the Tetrimino.
  def x_points
    points = [[], []]
    (0...height).each do |y|
      (0...width).each do |x|
        if (array[y][x]).nonzero? && (x - 1 < 0 || (array[y][x - 1]).zero?)
          points[0] << Point.new(x - 1, y) + @position
        end

        if (array[y][x]).nonzero? && (x + 1 >= length || (array[y][x + 1]).zero?)
          points[1] << Point.new(x + 1, y) + @position
        end
      end
    end

    points
  end

  # Returns a list of points that should be checked while handling y-axis collisions.
  # These positions are only the ones bellow the Tetrimino since the Tetrimino can only fall.
  def y_points
    points = []
    (0...width).each do |x|
      (0...height).reverse_each do |y|
        if (array[y][x]).nonzero? && (y + 1 >= height || (array[y + 1][x]).zero?)
          points << Point.new(x, y + 1) + @position
        end
      end
    end

    points
  end

  # Rotates the Tetrimino clockwise.
  def rotate_cw(board)
    rotate(board, -1)
  end

  # Rotates the Tetrimino counter clockwise.
  def rotate_ccw(board)
    rotate(board, 1)
  end

  # TODO: Most likely not thread-safe
  def rotate(board, val)
    @angles.rotate!(val)
    if (0...height).any? { |y| (0...width).any? { |x| pt = (Point.new(x, y) + @position); pt.x >= board.width || pt.y >= board.height || board[pt.y][pt.x].is_a?(Block) } }
      @angles.rotate!(val * -1)
    end
    self
  end

  # Converts the Tetrimino to a string.
  def to_s
    array.map { |x| x.map { |y| y.zero? ? ' ' : '█' }.join }.join("\n")
  end

  def block_points
    points = []
    (0...height).each { |y| (0...width).each { |x| points << Point.new(x, y) + @position if (array[y][x]).nonzero? } }
    points
  end

  def to_blocks(board)
    (0...height).each { |y| (0...width).each { |x| board.add_block((@position + x).x, (@position + y).y, @color) if (array[y][x]).nonzero? } }
    @position = Point.new
    self
  end
end
