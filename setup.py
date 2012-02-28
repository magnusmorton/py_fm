from Cython.Distutils import build_ext
from setuptools import setup, Extension


setup (name = 'PythonFourierMotzkin',
       version = '0.1',
       description = 'FM elimination wrapper',
       cmdclass = {'build_ext':build_ext},
       ext_modules = [Extension("py_fm", ["py_fm.pyx", "fm.pxd"],
                        libraries=["fm"])],
       test_suite = "py_fm.tests.test_all"
       )