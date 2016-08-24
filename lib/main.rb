(Dir['./core/*.rb', './utility/*.rb', './menu/*.rb']).each {|file| require file }

require 'opengl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

# Placeholder for the window object
window = nil

def init_gl_window(width = 640, height = 480)
  # Background color to black
  glClearColor(0.0, 0.0, 0.0, 0)
  # Enables clearing of depth buffer
  glClearDepth(1.0)
  # Set type of depth test
  glDepthFunc(GL_LEQUAL)
  # Enable depth testing
  glEnable(GL_DEPTH_TEST)
  # Enable smooth color shading
  glShadeModel(GL_SMOOTH)

  reshape(width, height)

  glMatrixMode(GL_MODELVIEW)

  draw_gl_scene
end

def reshape(width, height)
  height = 1 if height.zero?
  glViewport(0, 0, width, height)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity
  gluPerspective(45.0, width / height, 0.1, 100.0)
end

def draw_gl_scene
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity

  glTranslatef(0.0, 0.0, -15.0)

  # Draw a rectangle
  glBegin GL_QUADS do
    glVertex3f(-1.0,  1.0, 0.0)
    glVertex3f(1.0,  1.0, 0.0)
    glVertex3f(1.0, -1.0, 0.0)
    glVertex3f(-1.0, -1.0, 0.0)
  end

  # Swap buffers for display
  glutSwapBuffers
end

# The idle function to handle
def idle
  #glutPostRedisplay
end

# Keyboard handler
def keyboard_handler(key, x, y)
  case key
  when ?\e
    glutDestroyWindow(window)
    exit(0)
  else
    puts "Unhandled input: #{key}, #{x}, #{y}"
  end
  glutPostRedisplay
end

# Mouse handler
def mouse_handler(key, state, x, y)
  puts "Mouse button pressed: #{key}, #{state}, #{x}, #{y}"
end
# Initliaze our GLUT code
glutInit
# Setup a double buffer, RGBA color, alpha components and depth buffer
glutInitDisplayMode GLUT_RGB | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH
glutInitWindowSize 640, 480
glutInitWindowPosition 0, 0
window = glutCreateWindow "TeChris"
glutIdleFunc :idle
glutDisplayFunc :draw_gl_scene
glutReshapeFunc :reshape
glutKeyboardFunc :keyboard_handler
glutMouseFunc :mouse_handler
init_gl_window 640, 480
glutMainLoop

####
# Main entry point of the application.
#g = Game.new(0)
#pl = Player.new(g)
#b = pl.board
#b.current_tetrimino = b.get_next_piece
#i = 0
#logger = Logger.instance
#loop {
#  i += 1
#  b.check_collisions
#  puts b
#  b.current_tetrimino.rotate_ccw(b)
#  sleep(1)
#  logger.log('---')
#  logger.log("Iteration ##{i}")
#  logger.log('Board:')
#  logger.log("\n" + b.to_s)
#  logger.log('Tetrimino:')
#  logger.log("pos: #{b.current_tetrimino.position}")
#  logger.log("X-Collision points: #{b.current_tetrimino.x_points}")
#  logger.log("Y-Collision points: #{b.current_tetrimino.y_points}")
#  b.current_tetrimino.array.each { |y| logger.log(y) }
#  system('cls')
#}
