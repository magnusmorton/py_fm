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
from Cython.Distutils import build_ext
from setuptools import setup, Extension


setup (name = 'PythonFourierMotzkin',
       version = '0.1',
       description = 'FM elimination wrapper',
       cmdclass = {'build_ext':build_ext},
       ext_modules = [Extension("py_fm", ["py_fm.pyx", "fm.pxd"],
                        libraries=["fm"])],
       test_suite = "tests",
       install_requires = ['Cython>=0.15.1']
       )