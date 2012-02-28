# cython: language_level=3

cimport libc.stdio
cdef extern from '<fm/common.h>':
    ctypedef long int z_type_t

cdef extern from '<fm/rational.h>':
    struct s_fm_rational:
        z_type_t	num
        z_type_t	denum

    ctypedef s_fm_rational s_fm_rational_t
    
cdef extern from '<fm/vector.h>':
    struct s_fm_vector:
        size_t size
        s_fm_rational_t* vector
        z_type_t key
    ctypedef s_fm_vector s_fm_vector_t
    
    extern inline int fm_vector_assign_int_idx(s_fm_vector_t* v, z_type_t i, unsigned idx)
    extern inline void fm_vector_print(libc.stdio.FILE* stream, s_fm_vector_t* v)
    extern void fm_vector_compute_key(z_type_t* key, s_fm_vector_t* v)
    
    
cdef extern from '<fm/system.h>':
    struct s_fm_system:
        s_fm_vector_t** lines
        unsigned nb_lines
        unsigned nb_cols
        unsigned allocated

    ctypedef s_fm_system s_fm_system_t
    extern int fm_system_print (libc.stdio.FILE* stream, s_fm_system_t* s)

    extern s_fm_system_t* fm_system_alloc (size_t nb_lines, size_t nb_cols)
    extern void fm_system_free (s_fm_system_t* s)
    
    
cdef extern from '<fm/list.h>':
    struct s_fm_list:
        void* data
        s_fm_list* next

    ctypedef s_fm_list s_fm_list_t
    ctypedef void (*free_fun_t) (void*)
    ctypedef int (*cmp_fun_t) (void*, void*)
    
cdef extern from '<fm/solution.h>':
    struct s_fm_ball:
        s_fm_list_t* positive
        s_fm_list_t* negative

    ctypedef s_fm_ball s_fm_ball_t

    struct s_fm_solution:
        s_fm_ball_t* solution
        unsigned size

    ctypedef s_fm_solution s_fm_solution_t

    ctypedef void (*point_fun_t)(s_fm_solution_t*, s_fm_vector_t*, int, void*)
    
    extern void fm_solution_print (libc.stdio.FILE* stream, s_fm_solution_t* s)
    
cdef extern from '<fm/solver.h>':
    extern s_fm_solution_t* fm_solver (s_fm_system_t* system, int solver_type)

    extern s_fm_solution_t* fm_solver_solution_at (s_fm_system_t* system, int solver_type, unsigned last)

    extern s_fm_solution_t* fm_solver_solution_to (s_fm_system_t* system, int solver_type, unsigned to)
    
cdef extern from '<fm/options.h>':
    cdef enum options:
        FM_SOLVER_DEFAULT = 0
        FM_SOLVER_FAST    = 1
        FM_SOLVER_MEMSIZE = 2
        FM_SOLVER_NORMALIZE_EQ = 4
        FM_SOLVER_DEBUG = 8
        FM_SOLVER_SIMPLIFY = 16
        FM_SOLVER_REDREC_DESCENDANT	= 32
        FM_SOLVER_REDREC_IRIGOIN	= 64
        FM_SOLVER_AUTO_SIMPLIFY	    = 128

        FM_SOLVER_VERBOSE		    =256

        FM_SOLVER_AUTOSIMP_THRESOLD	 = 2000
        FM_SOLVER_ERRPTR		= 0x1
    
    
        
    