# cython: language_level=3
cimport fm
cimport libc.stdio
cdef class System:
    cdef fm.s_fm_system_t *_system
    def __cinit__(self, intlist):
        cdef int cols, rows, i, j
        cols = len(intlist[0])
        rows = len(intlist)
        self._system = fm.fm_system_alloc(rows, cols)
        for i in range(rows):
            for j in range(cols):
                # set vector element
                self._system.lines[i].vector[j].denum = 1
                self._system.lines[i].vector[j].num = intlist[i][j]
                fm.fm_vector_compute_key(&(self._system.lines[i].key), self._system.lines[i])
                
    
    cpdef dump(self):
        fm.fm_system_print(libc.stdio.stdout, self._system) 
                
