w, h = list(map(int, input().split()))
m = [[0]*w for _ in range(h)]
for i in range(h) :
    lig = input()
    for j in range(w) :
        if lig[j] == '*' :
            m[i][j] = 1

visited = [[False]*w for _ in range(h)]

def nextMove(i, j) :
    l = []
    for ni, nj in [(i+1, j), (i-1, j), (i, j+1), (i, j-1)] :
        if 0 <= ni < h and 0 <= nj < w :
            if not visited[ni][nj] and m[ni][nj] == 1 :
                l.append((ni, nj))
    return l

def dfs(depi, depj) :
    toVisit = [(depi, depj)]
    sz = 0
    while toVisit :
        i, j = toVisit.pop()
        if not visited[i][j] :
            sz += 1
            visited[i][j] = True
            for ni, nj in nextMove(i, j) :
                toVisit.append((ni, nj))
    return sz

v = 0
for i in range (h) :
    for j in range(w) :
        if m[i][j] == 1 and not visited[i][j] :
            v = max(v, dfs(i, j))
print(v)
