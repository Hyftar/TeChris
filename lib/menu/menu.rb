class Menu
  attr_accessor :elements

  def initialize(elements)
    @elements = elements
  end

  def click(x, y)

  end

  def draw
    @elements.each { |e| e.draw }
  end
end
