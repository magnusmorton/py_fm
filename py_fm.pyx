# cython: language_level=3
cimport fm

cdef class System:
    cdef fm.s_fm_system_t *_system
    def __cinit__(self, int numrows, int numcols):
        _system = fm.fm_system_alloc(numrows, numcols)
          
cpdef System create_system(intlist):
    cdef int cols, rows, i
    cdef System system
    cols = len(intlist[1])
    rows = len(intlist)
    system = System(rows, cols)
    
    
    return system