require './core/tetrimino'
require './core/block'
require './core/player'
require './utility/point'

class Board
  def initialize(player, width, height, nextpieces, *tetriminos)
    @player = player
    @width = width
    @height = height
    @nextPieces = Array.new(nextpieces) # nextpieces is an int (number of next pieces)
    @tetriminos = tetriminos
    @currentTetrimino = nil
    @reserve = nil
    @reserve_used = false
    @rng_bag = []
    @playArea = Array.new(height) { Array.new(width) }
  end

  def width
      @width
  end

  def height
      @height
  end

  def current_tetrimino
    @currentTetrimino
  end

  def current_tetrimino=(value)
    @currentTetrimino = value
  end

  def tetriminos
    @tetriminos
  end

  def play_area
    @playArea
  end

  def [](y)
    @playArea[y]
  end

  def get_next_piece
    @rng_bag = @tetriminos.sample(@tetriminos.size) if @rng_bad.empty?
    return @rng_bag.shift
  end

  def swap_piece
    if not @reserve_used
      @reserve_used = true
      @currentTetrimino.position = Point.new # TODO: Spawn Tetrimino in the middle of the playing area
      if @reserve
        @currentTetrimino, @reserve = @reserve, @currentTetrimino
      else
        @currentTetrimino, @reserve = get_next_piece(), @currentTetrimino
      end
    end
  end

  def check_collisions(tetrimino)
    if tetrimino.y_points.any? { |pt| @board[pt.y][pt.x] }
      tetrimino.to_blocks(self)
    end
  end

  def check_lines
    total = 0
    (0...@height).each { |y| total += clear_line(y) ? 1 : 0 }
    if total > 0
      @player.increment_score total
    end
  end

  def clear_line(y)
    if @playArea[y].all? { |x| x.is_a?(Block) }
      @playArea[0..y] = @playArea[0..y].rotate.drop(1).unshift(Array.new(@width))
      return true
    end

    return false
  end

  def reset_reserve
    @reserve_used = false
  end

  def add_block(x, y, color)
    @playArea[y][x] = Block.new(color, Point.new(x, y))
  end

  # TODO: Rewrite this method
  def to_s
    tempPA = play_area.map(&:clone) # This is not optimal, but this is one of the most simple aproach.
    @currentTetrimino.block_points.each { |pt| tempPA[pt.y][pt.x] = Block.new(@currentTetrimino.color, pt) }
    (('*' * (@width + 2)) + "\n") +
    tempPA.map{ |y| '*' + y.map { |x| x.is_a?(Block) ? '█' : ' ' }.join + '*'}.join("\n") +
    ("\n" + ('*' * (@width + 2)))
  end
end
