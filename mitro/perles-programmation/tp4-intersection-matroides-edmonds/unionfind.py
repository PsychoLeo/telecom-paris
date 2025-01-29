# Question 4.3 
class UnionFind():
    def __init__(self, V):
        """
        Initialises the union-find structure
        """
        self.V = V
        self.rank = {v:1 for v in self.V}

    def find(self, v):
        """
        Returns the tag of the element v
        """
        assert(v in self.V)
        if self.V[v] != v :
            self.V[v] = self.find(self.V[v])
            return self.V[v]
        else :
            return v

    def union(self, u, v):
        """
        Merges the components of the elements u and v
        Returns True if two components have been merged and False otherwise.
        """
        assert(u in self.V)
        assert(v in self.V)
        u, v = self.find(u), self.find(v)
        if v == u :
            return False 
        if self.rank[u] > self.rank[v] :
            return self.union(v, u)
        # self.rank[u] <= self.rank[v]
        self.V[u] = v
        self.rank[v] += self.rank[u]
        return True
