# Represents a Point object, a 2D x-y coordinate.
class Point
  attr_accessor :x, :y

  # Constructor of a Point.
  # Params:
  # x: The coordinate on the X-axis.
  # y: The coordinate on the Y-axis.
  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def +(other)
    temp = Point.new(@x, @y)
    if other.is_a? Point
      temp.x += other.x
      temp.y += other.y
    else
      temp.x += other
      temp.y += other
    end
    return temp
  end

  def -(other)
    temp = Point.new(@x, @y)
    if other.is_a? Point
      temp.x -= other.x
      temp.y -= other.y
    else
      temp.x -= other
      temp.y -= other
    end
    return temp
  end

  def *(other)
    temp = Point.new(@x, @y)
    temp.x *= other
    temp.y *= other
    return temp
  end

  def /(other)
    temp = Point.new(@x, @y)
    temp.x /= other
    temp.y /= other
    return temp
  end

  def %(other)
    temp = Point.new(@x, @y)
    temp.x %= other
    temp.y %= other
    return temp
  end

  def to_s
    "[#{@x}, #{@y}]"
  end
end
