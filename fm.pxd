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
    
    
        
    