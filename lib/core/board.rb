require './core/tetrimino'
require './core/block'
require './core/player'
require './utility/point'

class Board
  attr_reader :width, :height, :tetriminos, :array

  attr_accessor :current_tetrimino

  def initialize(player, width, height, nextpieces, *tetriminos)
    @player = player
    @width = width
    @height = height
    @nextPieces = Array.new(nextpieces) # nextpieces is an int (number of next pieces)
    @tetriminos = tetriminos
    @current_tetrimino = nil
    @reserve = nil
    @reserve_used = false
    @rng_bag = []
    @array = Array.new(height) { Array.new(width) }
  end

  def [](y)
    @array[y]
  end

  def get_next_piece
    @rng_bag = @tetriminos.sample(@tetriminos.size) if @rng_bag.empty?
    return @rng_bag.shift
  end

  def swap_piece
    unless @reserve_used
      @reserve_used = true
      @current_tetrimino.position = Point.new # TODO: Spawn Tetrimino in the middle of the playing area
      if @reserve
        @current_tetrimino, @reserve = @reserve, @current_tetrimino
      else
        @reserve = @current_tetrimino
        @current_tetrimino = get_next_piece
      end
    end
  end

  def check_collisions
    if @current_tetrimino.y_points.any? { |pt| pt.y >= @height || @array[pt.y][pt.x].is_a?(Block) }
      @current_tetrimino.to_blocks(self)
      @current_tetrimino = get_next_piece
    elsif @current_tetrimino
      @current_tetrimino.position.y += 1
    end
  end

  def check_lines
    total = 0
    (0...@height).each { |y| total += clear_line(y) ? 1 : 0 }
    @player.increment_score(total) unless total.zero?
  end

  def clear_line(y)
    if @array[y].all? { |x| x.is_a?(Block) }
      @array[0..y] = @array[0..y].rotate.drop(1).unshift(Array.new(@width))
      return true
    end

    return false
  end

  def reset_reserve
    @reserve_used = false
  end

  def add_block(x, y, color)
    @array[y][x] = Block.new(color, Point.new(x, y))
  end

  # TODO: Rewrite this method
  def to_s
    temp_array = array.map(&:clone) # This is not optimal, but this is one of the most simple aproach.
    @current_tetrimino.block_points.each { |pt| temp_array[pt.y][pt.x] = Block.new(@current_tetrimino.color, pt) }
    (('*' * (@width + 2)) + "\n") +
      temp_array.map { |y| '*' + y.map { |x| x.is_a?(Block) ? '█' : ' ' }.join + '*'}.join("\n") +
      ("\n" + ('*' * (@width + 2)))
  end
end
