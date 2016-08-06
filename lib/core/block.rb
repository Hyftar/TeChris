class Block
  def initialize(color, position)
    @color = color
    @position = position
  end

  def position
    @position
  end

  def color
    @color
  end

  def color=(val)
    @color = val
  end
end
