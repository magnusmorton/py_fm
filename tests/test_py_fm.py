import unittest
import tests
from py_fm import *

class TestSystem(unittest.TestCase):
    def setUp(self):
        self.system = System([[11,   -2,   11,    3],
                        [1,    3,   -2,   -5],
                        [1, -1/1,   -3,  8/2],
                        [1,    2,    0,   -3]])
    
    def test_can_create(self):
        assert self.system != None
        
    def test_solve(self):
        self.system.solve()