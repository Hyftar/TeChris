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

  def to_s
      @color
  end
end
