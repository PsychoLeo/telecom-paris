mn = 1e9
mx = -1e9

while True :
    try:
        s = input().split()
        for i in range (1, len(s)) :
            mx = max(mx, int(s[i]))
            mn = min(mn, int(s[i]))
    except :
        break

print(mn, mx)