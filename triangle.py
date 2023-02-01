import array

from magnum import *
from magnum import gl, shaders
from magnum.platform.egl import WindowlessApplication

class TriangleExample(Application):
    def __init__(self):
        configuration = self.Configuration()
        configuration.title = "Magnum Python Triangle Example"
        Application.__init__(self, configuration)

        buffer = gl.Buffer()
        buffer.set_data(array.array('f', [
            -0.5, -0.5, 1.0, 0.0, 0.0,
             0.5, -0.5, 0.0, 1.0, 0.0,
             0.0,  0.5, 0.0, 0.0, 1.0
        ]))

        self._mesh = gl.Mesh()
        self._mesh.count = 3
        self._mesh.add_vertex_buffer(buffer, 0, 5*4,
            shaders.VertexColorGL2D.POSITION)
        self._mesh.add_vertex_buffer(buffer, 2*4, 5*4,
            shaders.VertexColorGL2D.COLOR3)

        self._shader = shaders.VertexColorGL2D()

    def draw_event(self):
        gl.default_framebuffer.clear(gl.FramebufferClear.COLOR)

        self._shader.draw(self._mesh)
        self.swap_buffers()

exit(TriangleExample().exec())
