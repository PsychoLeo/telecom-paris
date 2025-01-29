class Graph():
    
    def __init__(self, vertices = [], edges = []) -> None:
        """Creates an undirected graph.
        
        Vertices are stored as a list self.V without duplicates.
        Edges are stored in a dictionnary self.E mapping a vertex to a list
        of neighbours.

        Input parameters:
          vertices -- a list of distinct vertices (default : empty)
          edges -- a list of pairs of vertices (default : empty)
        """
        self.V = []
        self.E = {}
        self.mu = {}
        self.scan = dict()
        self.rho = dict()
        self.phi = dict()
        for v in vertices :
            self.add_vertex(v)
        for (u,v) in edges:
            self.add_edge(u,v)
        for v in vertices :
            self.rho[v] = v
            self.phi[v] = v
            self.scan = False
        

    def __str__(self) -> str:
        s = "Graph with vertices: {ver}\n\n".format(ver = str(self.V))
        s+= "Edges: {edg}\n\n".format(edg=str(self.E))
        s+= "Matching: {m}\n".format(m=str(self.matching()))
        return s
    
    def add_vertex(self, v):
        """Adds a vertex to the grap."""
        assert(v not in self.V)
        self.V.append(v)
        self.E[v] = []
        self.mu[v] = v
    
    def add_edge(self, u, v):
        """Adds an edge to the grap
        
        Input parameters :
          u, v -- end nodes of the added edge.
        """
        assert(u in self.V)
        assert(v in self.V)
        self.E[u].append(v)
        self.E[v].append(u)    

    def matching(self):
        """
        Returns the current matching indicated by self.mu as a list of edges.
        """
        m = []
        for v in self.E:
            if self.mu[v] > v:
                m.append((v,self.mu[v]))
        return m
        
    def is_outer(self, v):
        """
        Returns True if the vertex v is an outer vertex in the current special
        blossom forest decomposition. 
        """
        return self.mu[v] == v or self.phi[self.mu[v]] != self.mu[v]
    
    def is_inner(self, v):
        """
        Returns True if the vertex v is an inner vertex in the current special
        blossom forest decomposition. 
        """
        return self.phi[self.mu[v]] == self.mu[v] and self.phi[v] != v
    
    def is_outside(self, v):
        """
        Returns True if the vertex v is outside the current special blossom forest. 
        """
        return self.mu[v] != v and self.phi[v] == v and self.phi[self.mu[v]] == self.mu[v]

    def path(self, v):
        """
        Returns the path from v to its root in the current special blossom forest
        decomposition as a list of vertices.

        Pre-condition : v should be an outer node

        Post-condition : the list should represent a path of even length, with
        edges alternating between edges from the matching (at odd distance from v) 
        and edges outside the matching (at even distance from v)
        """
        assert self.is_outer(v), "The node v should be an outer node in path(v)"
        ans = [v]
        n = 0
        next = self.mu[v]
        while next != ans[-1] :
            ans.append(next)
            n += 1
            next = self.mu[next] if (n % 2 == 0) else self.phi[next]
        assert len(ans) % 2 == 1, "The path should be of even length (function path(v))"
        # print(ans)
        for i in range (len(ans)-1) :
            a, b = ans[i], ans[i+1]
            if i % 2 == 0 : # distance paire
                assert self.mu[a] == b, f"Node {ans[i]} is not outer"
            else :
                assert self.mu[a] != a and self.mu[a] != b, f"Node {ans[i]} is not inner"
        return ans
    
    def _are_disjoint(self, u, v):
        assert self.is_outer(u) and self.is_outer(v)
        fatherU, fatherV = self.path(u)[-1], self.path(v)[-1]
        return fatherU != fatherV
    
    def _next_unscanned(self):
        for v in self.V :
            if not self.scan[v] :
                return v
        return False
    
    def _next_neighbour(self, x): 
        for y in self.E[x] :
            if self.is_outer(y) and self.rho[y] != self.rho[x] :
                return y
        return False
    
    def _grow(self, x, y):
        self.phi[y] = x

    def _augment(self, x, y):
        Px, Py = self.path(x), self.path(y)
        
        for i in range (1, len(Px), 2) :
            v = Px[i]
            self.mu[self.phi[v]] = v
            self.mu[v] = self.phi[v]

        for i in range (1, len(Py), 2) :
            v = Py[i]
            self.mu[self.phi[v]] = v
            self.mu[v] = self.phi[v]

        self.mu[x] = y
        self.mu[y] = x

        for v in self.V :
            self.phi[v] = v
            self.rho[v] = v
            self.scan[v] = False


    def _shrink(self, x, y):
        raise NotImplementedError("The student should implement this method.")
    
    def maximum_matching(self):
        """
        Computes a matching of maximum cardinality using Edmonds' algorithm
        """
        raise NotImplementedError("The student should implement this method.")


if __name__ == "__main__":
    # Gamma1 = Graph([1,2,3], [(1,2), (2,3), (3,1)])
    # Gamma1.add_vertex(4)
    # Gamma1.add_edge(1,4)
    # print(Gamma1)

    # Gamma1.add_vertex(5)
    # Gamma1.add_vertex(6)
    # Gamma1.add_edge(5,6)
    # Gamma1.mu[1] = 3
    # Gamma1.mu[3] = 1
    # Gamma1.mu[5] = 6
    # Gamma1.mu[6] = 5
    # print(Gamma1)

    from gamma2 import Gamma2, pathsGam2
    print(Gamma2._are_disjoint(10, 11))
    # print(Gamma2.path(45))
    # for x in pathsGam2 :
    #     assert (Gamma2.path(x) == pathsGam2[x])

    
#    Gamma1.maximum_matching()
