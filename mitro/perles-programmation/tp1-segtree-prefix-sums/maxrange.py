def minPow2(x) :
    p = 1
    while p < x :
        p = p*2
    return p

INF = 1000*1000*1000

class minRange:

    def __init__(self, T):
        self.n = len(T)
        self.p = minPow2(n)
        self.tree = [-INF]*(2*self.p)
        for i in range (len(T)) :
            self.tree[i+self.p] = T[i]
        for i in range (self.p-1, 0, -1) :
            self.tree[i] = max(self.tree[2*i], self.tree[2*i+1])
        # print(self.tree)

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
        
        


n = int(input())
T = list(map(int,input().split()))
algo = minRange(T)
r = int(input())
for _ in range(r):
    i,j = map(int,input().split())
    print(algo.requete(i,j))