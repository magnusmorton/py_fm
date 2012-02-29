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
                
    def __dealloc__(self):
        fm.fm_system_free(self._system)
                
    
    cpdef dump(self):
        print("System:")
        if fm.fm_system_print(libc.stdio.stdout, self._system):
            raise IOError()
           
    cpdef Solution solve(self):
        """WARNING: calling this on an insoluble system will cause a crash"""
        cdef fm.s_fm_solution_t *solution
        solution = fm.fm_solver(self._system, fm.FM_SOLVER_VERBOSE | fm.FM_SOLVER_FAST)
        wrapped_solution = Solution()
        wrapped_solution.add_solution(solution)
        return wrapped_solution
            
    
                
cdef class Solution:
    cdef fm.s_fm_solution_t *_solution
    
    def __cinit__(self):
        pass
    
    def __dealloc__(self):
        if self._solution is not NULL:
            fm.fm_solution_free(self._solution)
        
    cdef void add_solution(self, fm.s_fm_solution_t *solution):
        self._solution = solution
        
    cpdef dump(self):
        print("Solution:")
        fm.fm_solution_print(libc.stdio.stdout, self._solution)