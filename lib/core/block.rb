class Block
  def initialize(color, position, effect = nil)
    @color = color
    @position = position
    @effect = effect
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
