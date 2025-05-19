print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP9 : FACTORISATION DES ENTIERS                                             #
# *************************************************************************** #
# *************************************************************************** #
""")

from sage.matrix.constructor import Matrix

# CONSIGNES
#
# Les seules lignes a modifier sont annoncee par "Code pour l'exercice"
# indique en commmentaire et son signalees
# Ne changez pas le nom des variables
#
# CONSEILS
#
# Ce modele vous sert a restituer votre travail. Il est deconseille d'ecrire
# une longue suite d'instruction et de debugger ensuite. Il vaut mieux tester
# le code que vous produisez ligne apres ligne, afficher les resultats et
# controler que les objets que vous definissez sont bien ceux que vous attendez.
#
# Vous devez verifier votre code en le testant, y compris par des exemples que
# vous aurez fabrique vous-meme.
#



print("""\
# ****************************************************************************
# DIVISEURS SUCCESSIFS
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=2*3*3*5*5*5*7*11*11

# Code pour l'EXERCICE

def div_successives(n):
    ans = []
    d = 2
    while d*d <=n :
        while n % d == 0 :
            n //= d 
            if ans == [] or ans[-1] != d : 
                ans.append(d)
        d += 1
    if n > 1 :
        ans.append(n)
    return ans

# # Affichage des resultats

print("Q1 :", div_successives(n))
for n in range(2,100):
    # print(ZZ(n).prime_divisors())
    assert(div_successives(ZZ(n))==ZZ(n).prime_divisors())

print()
print("Q2 : La ligne d <- d+1 donne un algorithme de complexité O(sqrt n) car on va itérer à travers tous les d <= sqrt(n), donc son efficacité pourrait être améliorée.")
print()
print("Q3 : Il faut trouver le nombre de nombres premiers avec p1...pk et inférieurs à sqrt(n). On peut dire que cela est environ égal à sqrt(n)/p1...pk * PHI(p1...pk) où PHI est la fonction indicatrice d'euler. En effet, on prend le nombre de nombres premiers avec p1...pk inférieurs à p1...pk avec PHI(p1...pk) puis on le multiplie par le rapport sqrt(n)/p1...pk pour 'approximer' le résultat et compter tous ceux plus petits que sqrt(n). Par recherche sur internet, on trouve que PHI(n)/n <= 6/pi^2 donc l'algorithme s'execute en moins de 0.6 * sqrt(n) itérations.")
print()

def div_successives_opt(n) :
    ans = []
    p = [2, 3]
    if n % 2 == 0 :
        ans.append(2)
        while n % 2 == 0 :
            n //= 2
    if n % 3 == 0 :
        ans.append(3)
        while n % 3 == 0 :
            n //= 3
    d = 5 # on va désormais seulement prendre les nombre congrus à 1 ou 5 mod 6 ie ceux premiers avec 2 et 3 et inférieurs à sqrt(n)
    while d*d <= n :
        while n % d == 0 :
            n //= d 
            if ans == [] or ans[-1] != d : 
                ans.append(d)
        if d % 6 == 5 :
            d += 2
        else :
            d += 4
    if n > 1 :
        ans.append(n)
    return ans

n=2*3*3*5*5*5*7*11*11
print("Q4 :", div_successives_opt(n))
for n in range(2,100):
    # print(ZZ(n).prime_divisors())
    assert(div_successives_opt(ZZ(n))==ZZ(n).prime_divisors())
print()


print("""\
# ****************************************************************************
# FACTORISATION D'UN NOMBRE B-FRIABLE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=2*3*3*5*5*5*7*11*11
P=[p for p in primes(12)]

# Code pour l'EXERCICE

def div_successives_friable(n, P):
    ans = []
    for pi in P :
        if n % pi == 0 :
            ans.append(pi)
        while n % pi == 0 :
            n //= pi
    return ans

# # Affichage des resultats

print(div_successives_friable(n,P))
for n in range(2,10):
    assert(div_successives_friable(ZZ(n),P)==ZZ(n).prime_divisors())
print()


print("""\
# ****************************************************************************
# RHO DE POLLARD
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=222763

# Code pour l'EXERCICE

def myPollardrho(n):
    x=Integers(n).random_element()
    y = x 
    f = lambda x: (x^2+1)%n 
    g = 1
    while g == 1 :
        x = f(x)
        y = f(f(y))
        g = gcd(x-y, n)
    if g == n :
        return 1
    return g

# # Affichage des resultats

print(myPollardrho(n))

for _ in range(5):
    n=ZZ.random_element(3,100)
    print(n, 
      "| Resultat rho de Pollard : ", 
      myPollardrho(n), 
      " | n est-il composé ?",not n.is_prime())

print()


print("""\
# ****************************************************************************
# P-1 DE POLLARD
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=1323269
# print(ZZ(n).prime_divisors())

# Code pour l'EXERCICE

def myPollardpm1(n,B, nb_test=100):
    for _ in range (nb_test) :
        a = randint(2,n-2)
        g = gcd(n,a)
        if g > 1 : 
            return g
        for p in primes(B) :
            e = int(log(B)/log(p))
            a = power_mod(a, p**e, n)
        g = gcd(a-1,n)
        if 1 < g < n :
            return g
    return 1


# # Affichage des resultats

print(myPollardpm1(n, 1000))

for _ in range(5):
    n=ZZ.random_element(3,100)
    print(n, 
      "| Resultat p-1 de Pollard : ", 
      myPollardpm1(n, 100), 
      " | n est-il composé ?",not n.is_prime())
print()



print("""\
# ****************************************************************************
# CRIBLE QUADRATIQUE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=2886

# Code pour l'EXERCICE

def L(n) :
    return exp(sqrt(ln(n) * ln(ln(n))))

def B_friable(n, B) :
    pr = prime_divisors(n)
    return pr[-1] <= B

def cribleQuadratique (n):
    B = ceil(sqrt(L(n)))
    pr = list(primes(B))
    m = len(pr)
    x = ceil(sqrt(n))
    S = []
    while len(S) < m+1 :
        a = (x*x) % n 
        if B_friable(a, B) :
            S.append((x, a))
        x += 1
    F2 = GF(2)
    M = Matrix(F2, m, m+1)
    for i in range (m+1) :  
        x, a = S[i]
        for j in range (m) :
            while a % pr[j] == 0 :
                a /= pr[j]
                M[j, i] += 1
    v = M.right_kernel().basis()[0]
    K = v.support()
    # print(K)
    z = 1
    for i in K :
        x, a = S[i]
        z = (z * x) % n 
    y = 1
    for i in range (m) :
        s = Integer(0)
        for j in K :
            s += Integer(M[i, j])
        s //= 2
        y = (y * (pr[i]^s)) % n 
    d = gcd(z-y, n)
    return d

# # Affichage des resultats
print("Un diviseur de", n, "trouvé avec le crible quadratique est :")
print(cribleQuadratique(n))
print()
