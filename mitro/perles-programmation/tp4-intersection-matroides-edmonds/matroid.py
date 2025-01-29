import unionfind as uf

class Matroid():
    def __init__(self, E={}):
        self.E = {e for e in E}
    
    def is_independent(self, X):
        raise NotImplementedError("Should be implemented by the subclass")

# Question 4.2 
class PartitionMatroid(Matroid):
    def __init__(self, color_map, color_max):
        super().__init__(color_map.keys())
        self.color_map = color_map
        self.color_max = color_max
    
    def is_independent(self, X):
        raise NotImplementedError("Should be implemented by the student")

# Question 4.4
class GraphicMatroid(Matroid):
    def __init__(self, edges):
        super().__init__(edges)
        self.edges = edges
    
    def is_independent(self, X):
        raise NotImplementedError("Should be implemented by the student")

class ExchangeGraph():
    # Question 4.5
    def __init__(self, S, M1 : Matroid, M2 : Matroid):
        assert Matroid.is_independent(M1, S) and Matroid.is_independent(M2, S)
        raise NotImplementedError("Should be implemented by the student")
    # Question 4.6
    def _shortest_path(self):
        raise NotImplementedError("Should be implemented by the student")

# Question 4.7
def intersection(m1 : Matroid, m2 : Matroid):
    raise NotImplementedError("Should be implemented by the student")