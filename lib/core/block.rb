class Block

  attr_reader :position

  attr_accessor :color

  def initialize(color, position)
    @color = color
    @position = position
  end

  def to_s
    @color
  end
end
