n = int(input())
h = [int(input()) for _ in range(n)]
m = sum(h)//n
c = 0


for x in h :
    c += abs(x-m)
print(c//2)