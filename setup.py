from distutils.core import setup, Extension

module1 = Extension('py_fm',
                    sources = ['vector.c'])

setup (name = 'PythonFourierMotzkin',
       version = '0.1',
       description = 'FM elimination wrapper',
       ext_modules = [module1])