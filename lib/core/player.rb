require './core/tetrimino'

class Player
  def initialize(game)
    @score = 0
    @linesCleared = 0
    @combo = 0
    @game = game
    @board = Board.new
  end

  # Increments the score of the player relative to the number of lines he just cleared and his current combo
  def increment_score(lines)
    unless lines == 0
      @combo += 1
      @linesCleared += lines
      @score += 100 * 2**(lines - 1) * combo
    end
  end

  def reset_combo
    @combo = 0
  end
end
