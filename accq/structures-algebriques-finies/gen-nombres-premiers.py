import random
from sympy.functions.combinatorial.numbers import jacobi_symbol
import sys
sys.setrecursionlimit(100_000_000)

minpow2 = 1000 # augmenter la taille des nombres premiers générés
t = 100 # augmenter la probabilité que le test fonctionne bien 


def gcd(a, b) :
    return a if b == 0 else gcd(b, a%b)


def binexp(a, n, mod) :
    r = 1
    while n :
        if n % 2 :
            r = (r * a) % mod
        a = (a * a) % mod
        n //= 2
    return r


def jacobi(a, n) :
    # print(a, n)
    if a == 1 or n == 1:
        return 1
    elif a % 2 == 0 :
        x = -1 if (n % 8 in [3, 5]) else 1 # equiv à n^2 - 1 = 8 mod 16
        return x * jacobi(a//2, n)
    else :
        # a, n impairs
        ma = (a-1) % 8
        mn = (n-1) % 8
        x = -1 if ((ma * mn) % 8 == 4) else 1
        return x * jacobi(n%a, a)

def genBigPrime() :

    r = random.randint(minpow2, 2*minpow2)
    found = False

    while not found :

        n = 0
        while n % 2 == 0 :
            n = random.randint(1<<r, 1<<(r+1))
        # print(n)
        found = True  # on a probablement trouvé un match (proba ~2^-t)

        for _ in range (t) :
            a = 0
            while gcd(a, n) > 1 :
                a = random.randint(2, n-1)

            if (jacobi(a, n) % n) != binexp(a, (n-1)//2, n) :
                # print(jacobi(a, n), binexp(a, (n-1)//2, n))
                found = False 
                break

    return n

if __name__ == "__main__" :
    p = genBigPrime()
    print(p)
    # print(jacobi(1001, 9907) == -1)
    # print(jacobi(123, 4567) == -1)
    # print(jacobi(75, 211) == -1)
    # print(jacobi(2401, 97) == 1)
    # print(jacobi(32, 97) == 1)
    # print(jacobi(45, 97) == -1)
