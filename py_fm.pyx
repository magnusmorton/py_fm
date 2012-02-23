# cython: language_level=3

cimport libc
cimport stdio
cimport fm

cdef class System:
    cdef fm.s_fm_system_t *_system
    def __cinit__(self, int numrows, int numcols):
        _system = fm.fm_system_alloc(numrows, numcols)
          
cpdef System create_system(intlist):
    cdef int cols, rows
    cols = len(intlist[1])
    rows = len(intlist)
    return System(rows, cols)