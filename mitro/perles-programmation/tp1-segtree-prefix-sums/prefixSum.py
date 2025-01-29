class prefixSum:
    def __init__(self, T):
        self.px = [0]
        for i in range (len(T)) :
            self.px.append(self.px[-1]+T[i])


    def requete(self, i,j):
        return self.px[j]-self.px[i]


n = int(input())
T = list(map(int,input().split()))
algo = prefixSum(T)
r = int(input())
for _ in range(r):
    i,j = map(int,input().split())
    print(algo.requete(i,j))