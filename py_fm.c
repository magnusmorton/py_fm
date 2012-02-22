#include <Python.h>
#include <fm/vector.h>

static PyMethodDef vector_methods[] = {
    {NULL}  /* Sentinel */
};

PyMODINIT_FUNC initvector(void)
{
    (void) Py_InitModule("py_fm.vector", vector_methods);
}