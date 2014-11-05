from kivy.graphics.vertex cimport VertexFormat, vertex_attr_t
from kivy.graphics.instructions cimport VertexInstruction
from kivy.graphics.c_opengl cimport *


cdef class OrphaningVBO:
    '''
    .. versionchanged:: 1.6.0
        VBO now no longer has a fixed vertex format. If no VertexFormat is given
        at initialization, the default vertex format is used.
    '''
    cdef object __weakref__
    cdef int _data_size
    cdef void* _data_pointer
    cdef int _size_last_frame
    cdef GLuint id
    cdef int usage
    cdef int target
    cdef vertex_attr_t *format
    cdef long format_count
    cdef long format_size
    cdef short flags
    cdef VertexFormat vertex_format
    cdef int have_id(self)
    cdef void update_buffer(self)
    cdef void set_data(self, int data_size, void* data_ptr)
    cdef void clear_data(self)
    cdef void bind(self)
    cdef void unbind(self)
    cdef void reload(self)

cdef class OrphaningVertexBatch:
    cdef object __weakref__
    cdef int _data_size
    cdef unsigned short* _data_pointer
    cdef int _size_last_frame
    cdef OrphaningVBO vbo
    cdef GLuint mode
    cdef str mode_str
    cdef GLuint id
    cdef int usage
    cdef short flags
    cdef int have_id(self)
    cdef void reload(self)
    cdef void clear_data(self)
    cdef void set_data(self, void *vertices, int vertices_count,
        unsigned short *indices, int indices_count)
    cdef void draw(self)
    cdef void set_mode(self, str mode)
    cdef str get_mode(self)

cdef class CMesh(VertexInstruction):
    cdef void* _vertices
    cdef void* _indices
    cdef VertexFormat vertex_format
    cdef long vcount
    cdef long icount
    cdef OrphaningVertexBatch _obatch