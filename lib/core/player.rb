require './core/tetrimino'

class Player
  attr_reader :score, :board, :combo, :lines_cleared

  def initialize(game)
    @score = 0
    @lines_cleared = 0
    @combo = 0
    @game = game

    # TODO: Move the tetriminos definitions from here.

    i = Tetrimino.new([[1, 1, 1, 1]], Color::CYAN)
    o = Tetrimino.new([[1, 1], [1, 1]], Color::YELLOW)
    t = Tetrimino.new([[0, 1, 0], [1, 1, 1]], Color::PURPLE)
    s = Tetrimino.new([[0, 1, 1], [1, 1, 0]], Color::LIME)
    z = Tetrimino.new([[1, 1, 0], [0, 1, 1]], Color::RED)
    j = Tetrimino.new([[1, 0, 0], [1, 1, 1]], Color::BLUE)
    l = Tetrimino.new([[0, 0, 1], [1, 1, 1]], Color::ORANGE)

    @board = Board.new(self, 10, 22, 5, i, o, t, s, z, j, l)
  end

  # Increments the score of the player relative to the number of lines he just cleared and his current combo
  def increment_score(lines)
    unless lines.zero?
      @combo += 1
      @lines_cleared += lines
      @score += 100 * 2**(lines - 1) * combo
    end
  end

  def reset_combo
    @combo = 0
  end
end
