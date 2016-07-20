# Represents a Point object, a 2D x-y coordinate.
class Point
    # Constructor of a Point.
    # Params:
    # x: The coordinate on the X-axis.
    # y: The coordinate on the Y-axis.
    def initialize(x = 0, y = 0)
        @x = x
        @y = y
    end

    # Accessor of the X coordinate
    def x
        @x
    end

    # Accessor of the Y coordinate
    def y
        @y
    end

    def x=(val)
        @x = val
    end

    def y=(val)
        @y = val
    end

    def +(val)
        temp = Point.new(@x, @y)
        if val.is_a? Point
            temp.x += val.x
            temp.y += val.y
        else
            temp.x += val
            temp.y += val
        end
        return temp
    end

    def -(val)
        temp = Point.new(@x, @y)
        if val.is_a? Point
            temp.x -= val.x
            temp.y -= val.y
        else
            temp.x -= val
            temp.y -= val
        end
        return temp
    end

    def *(val)
        temp = Point.new(@x, @y)
        temp.x *= val
        temp.y *= val
        return temp
    end

    def /(val)
        temp = Point.new(@x, @y)
        temp.x /= val
        temp.y /= val
        return temp
    end

    def %(val)
        temp = Point.new(@x, @y)
        temp.x %= val
        temp.y %= val
        return temp
    end

    def to_s
        "[#{@x}, #{@y}]"
    end
end
