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
import unittest
import tests
from py_fm import *

class TestSystem(unittest.TestCase):
    """this is not a true unit test set, more a driver to check that it works"""
    BOOK_EXAMPLE = [[1,   -2,   11,    3],
                    [1,    3,   -2,   -5],
                    [1, -1/1,   -3,  8/2],
                    [1,    2,    0,   -3]]
    BANERJEE2   =    [[1,  -2,   11,   3],
                    [1,    3,   -2, -5],
                    [1,   -1,   -3,    4],
                    [1,    4,    0,   -6]]
    
    def setUp(self):
        self.system = System(TestSystem.BOOK_EXAMPLE)
    
    def test_can_create(self):
        assert self.system != None
        
    def test_solve(self):
        self.system.dump()
        sol = self.system.solve()
        sol.dump()
        sol.as_system()
        
    def test_to_list_book(self):
        assert self.system.to_list() == TestSystem.BOOK_EXAMPLE, "array not recovered"
      
    def test_to_list_banerjee2(self):
        system2 = System(TestSystem.BANERJEE2)
        assert system2.to_list() == TestSystem.BANERJEE2, "array not recovered correctly"
        
    
        
    