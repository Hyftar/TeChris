class MenuElement
    attr_reader :width, :height, :link_to, :action

    def initialize(text, width, height action, linkTo)
      @text = text
      @width = width
      @height = height
      @action = method(action)
      @link_to = linkTo
    end

    def draw
      glTranslatef(0.0, 0.5, 0.0)
      glBegin GL_QUADS do
        glVertex3f( @width / 2,  @height / 2, 0)
        glVertex3f( @width / 2, -@height / 2, 0)
        glVertex3f(-@width / 2, -@height / 2, 0)
        glVertex3f( @width / 2, -@height / 2, 0)
      end
    end
end
