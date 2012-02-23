from distutils.core import setup, Extension
from Cython.Distutils import build_ext


setup (name = 'PythonFourierMotzkin',
       version = '0.1',
       description = 'FM elimination wrapper',
       cmdclass = {'build_ext':build_ext},
       ext_modules = [Extension("py_fm", ["py_fm.pyx"],
                        libraries=["fm"])]
       )