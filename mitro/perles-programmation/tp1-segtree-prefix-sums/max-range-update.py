def minPow2(x) :
    p = 1
    while p < x :
        p = p*2
    return p

INF = 1000*1000*1000

class maxRange:

    def __init__(self, T):
        self.n = len(T)
        self.p = minPow2(n)
        self.tree = [-INF]*(2*self.p)
        for i in range (len(T)) :
            self.tree[i+self.p] = T[i]
        for i in range (self.p-1, 0, -1) :
            self.tree[i] = max(self.tree[2*i], self.tree[2*i+1])
        # print(self.tree)
        self.marked = [False]*(2*self.p)

    def requete(self, i, j) :
        return self.aux(1, i, j, 0, self.p)

    def aux(self, pos, i,j, l, r):
        if i == j :
            return 0
        if j <= l or i >= r :
            return -INF
        elif i <= l and r <= j :
            return self.tree[pos]
        else :
            mid = (l + r) // 2
            return max(self.aux(2*pos, i, j, l, mid),
                       self.aux(2*pos+1, i, j, mid, r))
        
    def aux_maj(self, i, v):
        pass
        
    def miseajour(self, i, v) :
        j = i+self.p
        self.tree[j] = v
        j //= 2
        while j > 0 :
            self.tree[j] = max(self.tree[2*j], self.tree[2*j+1])
            j //=2
        
        


n = int(input())
T = list(map(int,input().split()))
algo = maxRange(T)
r = int(input())
for _ in range(r):
    c,i,j = input().split()
    i,j = int(i),int(j)
    if c =='Q':
        print(algo.requete(i,j))
    else:
        algo.miseajour(i,j)