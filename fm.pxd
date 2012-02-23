# cython: language_level=3

cimport libc
cimport stdio
cimport stdlib

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
        s_fm_rational_t vector
        z_type_t key
    ctypedef s_fm_vector s_fm_vector_t
    
    
cdef extern from '<fm/system.h>':
    struct s_fm_system:
        s_fm_vector_t** lines
        unsigned nb_lines
        unsigned nb_cols
        unsigned allocated

    ctypedef s_fm_system s_fm_system_t


    extern s_fm_system_t* fm_system_alloc (size_t nb_lines, size_t nb_cols)
    
    
        
    