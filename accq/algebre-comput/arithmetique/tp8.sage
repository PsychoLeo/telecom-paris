print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP8 : PRIMALITE DES ENTIERS                                                 #
# *************************************************************************** #
# *************************************************************************** #
""")

import random
from sympy.ntheory import jacobi_symbol

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
# TEST DE RABIN-MILLER 
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n = 561

# Code pour l'EXERCICE

def val_padique(p, x) :
    """
    Renvoie un tuple v, m tels que x = p^v * m 
    """
    v, m = 0, x
    while m % p == 0 :
        v += 1 
        m //= p
    return v, m


def testRM(n) :
    '''
    Renvoie true si le nombre est probablement premier, false sinon
    '''
    a = random.randint(2, n-1)
    v, m = val_padique(2, n-1)
    if gcd(a, n) > 1 :
        return false 
    b = power_mod(a, m, n)
    if b == 1 :
        return true 
    for i in range(1, v+1) :
        if (b*b) % n == 1 :
            g = gcd(b+1, n)
            if g == 1 or g == n :
                return true 
            else :
                return false 
        b = (b * b) % n
    return false

def testRM_temoin(a, n) :
    '''
    Renvoie true si le nombre est probablement premier, false sinon
    '''
    v, m = val_padique(2, n-1)
    if gcd(a, n) > 1 :
        return false 
    b = power_mod(a, m, n)
    if b == 1 :
        return true 
    for i in range(1, v+1) :
        if (b*b) % n == 1 :
            g = gcd(b+1, n)
            if g == 1 or g == n :
                return true 
            else :
                return false 
        b = (b * b) % n
    return false

# # Affichage des resultats

print("Test de la primalite de n=",n,"avec implementation de Rabin-Miller")
print(testRM(n))
print("En testant plusieurs fois, on trouve que 4, 215, 316, 325, 415 sont des témoins de Miller Rabin. Il suffit pour trouver cela d'ajouter une ligne print juste avant le return false à la toute fin, car alors on aura épuisé tous les cas.")
print()


print("""\
# ****************************************************************************
#  PERFORMANCES DE RABIN-MILLER
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

nmin=10
nmax=500
nbtests = 100

# Code pour l'EXERCICE

rep2 = "Les nombres le plus souvent déclarés premiers alors qu'ils sont composés sont les nombres produits de 2 nombres premiers distincts. Ce sont par exemple des nombres comme 14, 26, 34, 38, 58"
rep3 = "D'après le corollaire 317, la probabilité d'erreur est donc  (1-3/4*phi(n)/n)^nb_tests. On a (par recherche personnelle) une minoration de phi(n)/n >= 1/log log n. Puisque log log n croit très lentement, on peut supposer qu'il est constant et qu'il vaut environ 1. Donc P(erreur) ~= (1/4)^nb_tests et il faut prendre nb_tests >= 25 pour avoir une probabilité d'erreur <= 2^(-50)"

# # Affichage des resultats

l = [sum([testRM(n) for i in range(nbtests)])/nbtests for n in range(nmin,nmax)]

'''
for n in range (nmin, nmax) :
    if l[n-nmin] > 0.5 :
        print(n) 
'''

bars = bar_chart(l)
show(bars)
# bars.save("rabin_miller_test_effic.png")
print(rep2)
print()
print(rep3)
list_plot( [timeit( 'testRM(n)', number=20, repeat=3, seconds=true) for n in range(1001,1001+100000,100) ])
print() 

print("""\
# ****************************************************************************
# TEST DE SOLOVAY-STRASSEN 
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n = 561

# Code pour l'EXERCICE

def testSS(n):
    if n % 2 == 0 :
        return false
    a = random.randint(2, n-1)
    if gcd(a, n) != 1 :
        return false 
    v = (jacobi_symbol(a, n) + n) % n 
    if power_mod(a, (n-1)//2, n) == v :
        return true 
    return false

def testSS_temoin(a, n) :
    if n % 2 == 0 :
        return false
    if gcd(a, n) != 1 :
        return false 
    v = (jacobi_symbol(a, n) + n) % n 
    if power_mod(a, (n-1)//2, n) == v :
        return true 
    return false

rep3 = "On a par exemple les nombres 27 = 3^3, 45 = 5*9, 85 = 5*17, 91 = 7*13, 121 = 11*11, 133 = 7*19, 217 = 7*31. Ces nombres ont tous au plus 2 facteurs premiers distincts."
rep4 = "Par la même analyse que précédemment en remplaçant 3/4 * phi(n) par phi(n)/2, on a que la probabilité d'échec à un test est 1/2, donc sur nb_test elle est de 2^(-nb_tests), donc il suffit de prendre nb_tests = 50"

# # Affichage des resultats

print("Test de la primalite de n=",n,"avec implementation de Solovay-Strassen")
print(testSS(n))
print(rep3)
print(rep4)
print()

l = [sum([testSS(n) for i in range(nbtests)])/nbtests for n in range(nmin,nmax)]

bars = bar_chart(l)
show(bars)
print()
# bars.save("solovay_strassen_test_effic.png")

'''
for n in range (nmin, nmax) :
    if 0.9 > l[n-nmin] and l[n-nmin] > 0.2 :
        print(n) 
'''



print("""\
# ****************************************************************************
# COMPARAISON ENTRE LES TESTS DE R-M ET S-S 
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

nmax=150

# Code pour l'EXERCICE

Temoins = []

for n in range (2, nmax+1) :
    for a in range (2, n) :
        if testRM_temoin(a, n) == False and testSS_temoin(a, n) :
            Temoins.append((a, n))

# # Affichage des resultats

print("Liste d'entiers composés et de temoins exclusifs de Rabin-Miller")
print(Temoins)
print()



print("""\
# ****************************************************************************
# TEST DE LUCAS
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


# Code pour l'EXERCICE

def testL(n, p, q):
    D = p*p-4*q 
    g = gcd(n, 2*q*D)
    if 1<g<n :
        return false 
    if g == n :
        print("Mauvais choix de (p, q)")
        return None 
    x = n-jacobi_symbol(D,n)
    m = x
    t = 0
    while m>0 and m % 2 == 0 :
        m //= 2
        t += 1
    u, v = [0, 1], [2, p]
    for i in range (2, x+1) :
        u.append(p*u[-1]-q*u[-2])
        v.append(p*v[-1]-q*v[-2])
    g = gcd(n, u[m])
    if 1<g<n :
        return false 
    if g == n :
        return true 
    for s in range (t) :
        g = gcd(n, v[2^s * m])
        if 1<g<n :  
            return false 
        if g == n :
            return true 
    return false 

# # Affichage des resultats

print("Comparaison des résultats du test de Lucas avec la fonction is_prime() de Sage Math :")
for _ in range(10):
    n = ZZ.random_element(2,10000)
    print(n.is_prime()==testL(n, 4, 9))
print()



print("""\
# ****************************************************************************
# TEST DE BAILLIE, POMERANCE, SELFRIDGE ET WAGSTAFF
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

nmax=1000

# Code pour l'EXERCICE

def testBPSW(n):
    if n == 2 :
        return true
    if testRM_temoin(2, n) == false :
        return false 
    k, D = 0, 5
    while jacobi_symbol(D, n) != -1 :
        k += 1
        D = (-1)^k * (2*k+5)
    p, q = 1, (1-D)/4
    if testL(n, p, q) == false :
        return false 
    return true

# # Affichage des resultats
print("Résultats du test BPSW :")
print(all([ZZ(n).is_prime()==testBPSW(n) for n in range(2,nmax+1)]))
print()