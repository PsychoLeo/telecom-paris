from exemple import u, b, c, f

class Graph():
    def __init__(self, u, b, c):
        """
        Initialisation with : 
        u : edge capacities, given as a dictionnary E -> RR
        b : vertices supply/demand, given as a dictionnary V -> RR
        c : edge costs, given as a dictionnary E -> RR
        """
        assert(u.keys() == c.keys())
        self.n = len(b)
        self.V = list(b.keys())
        self.E = list(u.keys())
        self.succ = {v : [] for v in self.V}
        self.pred = {v : [] for v in self.V}
        for (v,w) in self.E:
            self.succ[v].append(w)
            self.pred[w].append(v)
        self.u = u
        self.b = b
        self.c = c
    
    def is_flow(self):
        """Checks that f is a b-flow indeed."""
        assert(0 <= self.f[e] for e in self.E)
        assert(self.f[e] <= self.u[e] for e in self.E)
        assert(sum(self.f[e] for e in self.E if 
                   e[0]==v or e[1]==v) == 
               self.b[v] for v in self.V)
    
    def set_flow(self, f):
        self.f = f

    def get_flow_cost(self):
        """Returns the cost of the current flow f."""
        return sum(self.f[e]*self.c[e] for e in self.E)

    def get_value(self, p):
        """
        Returns the value gamma of an f-augmenting path p
        i.e. the flow f can be increased/decreased by gamma along the path p. 
        """
        n = len(p)
        gamma = int(1e9)
        for i in range (n-1) :
            e = (p[i], p[i+1])
            if e in u :
                gamma = min(gamma, u[e]-f[e])
            else :
                e = (e[1], e[0])
                gamma = min(gamma, f[e])
        assert gamma > 0, "error in get_value : path should be augmenting"
        return gamma
            


    def augment(self, p, gamma):
        assert self.get_value(p) == gamma, "Augmenting value does not correspond in augment function"
        n = len(p)
        for i in range (n-1) :
            e = (p[i], p[i+1])
            if e in u :
                f[e] += gamma
            else :
                e = (e[1], e[0])
                f[e] -= gamma
        


    def shortest_paths_to_dest(self):
        self.d = [[0]*self.n for _ in range (self.n+1)]
        self.p = [[None]*self.n for _ in range (self.n+1)]
        for k in range (1, self.n+1) :
            for (u, v) in self.E :
                if self.d[k-1][u] + self.c[(u, v)] < self.d[k][v] :
                    self.d[k][v] = self.d[k-1][u] + self.c[(u, v)]
                    self.p[k][v] = u
    
    def min_cost_flowGT(self):
        pass

    def min_meancost_circuit(self) :
        self.shortest_paths_to_dest()

    def shortest_paths_from_src(self, s):
        pass
    
    def min_cost_flowBG(self):
        pass

    def find_circuit(self, p):
        vis = dict()
        for i in range (len(p)) :
            if p[i] in vis :
                cycle = []
                j = vis[p[i]]
                for k in range (j, i) :
                    cycle.append(p[k]) 
                return cycle + [p[i]]
            else :
                vis[p[i]] = i
        return None # there is no cycle



G = Graph(u, b, c)
print(G.find_circuit([1, 2, 4, 5, 6, 3]))