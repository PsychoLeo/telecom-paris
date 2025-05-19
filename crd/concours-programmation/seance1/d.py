ans = 0

while True :
    try :
        add = float(input())
        ans += round(100*add)
    except :
        break

print(f"{ans//100}.{ans%100:02d}")