# cython: language_level=3
cimport fm

cdef class System:
    cdef fm.s_fm_system_t *_system
    def __cinit__(self, intlist):
        cdef int cols, rows, i, j
        cols = len(intlist[0])
        rows = len(intlist)
        print(cols)
        print(rows)
        _system = fm.fm_system_alloc(rows, cols)
        for i in range(1,rows):
            print(i)
            for j in range(1,cols):
                print(j)
                fm.fm_vector_assign_int_idx(_system.lines[i], intlist[i][j], j)
                
