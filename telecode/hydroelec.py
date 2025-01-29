def binexp(x, n, m) :
    ans = 1
    while n > 0 :
        if n % 2 :
            ans = (ans * x) % m
        x = (x*x) % m
        n //= 2
    return ans


def erath(n) :
    P = [True] * n 
    primes = []
    P[0] = P[1] = False
    for i in range (2, n) :
        if P[i] :
            primes.append(i)
            for j in range (i*i, n, i) :
                P[j] = False
    return P, primes

print(erath(100))