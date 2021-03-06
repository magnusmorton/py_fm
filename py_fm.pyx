# cython: language_level=3
'''
(c) Copyright 2012 Magnus Morton.
This file is part of py_fm.

py_fm is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

py_fm is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with py_fm.  If not, see <http://www.gnu.org/licenses/>.

'''
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
        
    def to_list(self):
        return system_to_list(self._system)
        

cdef system_to_list(fm.s_fm_system_t *system):
    cdef int i
    output_list = []
    for i in range(system.nb_lines):
        output_list.append(vector_to_list(system.lines[i], system.nb_cols))
    return output_list

cdef vector_to_list(fm.s_fm_vector_t *vector, int size):
    output_vector = []
    for j in range(size):
        output_vector.append(vector.vector[j].num)
    return output_vector
    
                
cdef class Solution:
    """Wrapper on s_fm_solution struct"""
    cdef fm.s_fm_solution_t *_solution
    
    def __cinit__(self):
        pass
    
    def __dealloc__(self):
        if self._solution is not NULL:
            fm.fm_solution_free(self._solution)
        
    cdef void add_solution(self, fm.s_fm_solution_t *solution):
        self._solution = solution
        
    cpdef as_system(self):
        cdef fm.s_fm_system_t *system
        system = fm.fm_solution_to_system(self._solution)
        print("Solution as System:")
        if fm.fm_system_print(libc.stdio.stdout, system):
            raise IOError()
        
    def to_list(self):
        cdef fm.s_fm_system_t *system
        cdef int i
        system = fm.fm_solution_to_system(self._solution)
        return system_to_list(system)
        
    cpdef dump(self):
        print("Solution:")
        fm.fm_solution_print(libc.stdio.stdout, self._solution)