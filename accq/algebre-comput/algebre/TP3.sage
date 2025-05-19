print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP3 : RESEAUX EUCLIDIENS                                                    #
# *************************************************************************** #
# *************************************************************************** #
""")

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


reset()
print("""\
# ****************************************************************************
# BASE D'UN RESEAU
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

A = matrix(ZZ,[
        [ 2, -3,  4],
        [ 4,  4, 53]])

# Par calculs à la main, on trouve des vecteurs solutions particulières de l'équation :
v1 = vector([19, 18, 4])
v2 = vector([-8, -4, 1])

p1 = A*v1
assert (p1[0] == 0 and p1[1] % 5 == 0)

p2 = A*v2
assert (p2[0] == 0 and p2[1] % 5 == 0)

# Code pour l'EXERCICE

L=[v1, v2]

# # Affichage des resultats

print("$ Le réseau a pour base")
print(L)
print("Raisonnement : On sait que si l'on enlève la condition de congruence, on a une hyperlan de Z^3 qui est de dimension 2, or l'ensemble avec la condition de congruence est inclus dans l'ensemble sans, il a donc une dimension plus petite. Donc la dimension de notre réseau est <= 2. Or on a exhibé une famille libre à 2 éléments, c'est donc une base et notre réseau est de dimension 2.")
print()


print("""\
# ****************************************************************************
# APPLICATIONS NUMERIQUES
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

n1 = round(arctan(1),50)
n2 = round(arctan(1/5),50)
n3 = round(arctan(1/239),50)

n_list = [n1, n2, n3]

M = 1e18

r = 3
B = zero_matrix(ZZ, r+1, r)
for i in range (r) :
    B[i, i] = 1
for j in range (r) :
    B[r, j] = round(M*n_list[j])
#print(B)
B = B.transpose()
B = B.LLL()
#print(B)

alpha=[B[0, i] for i in range (3)]

r=-2.5468182768840820791359975088097915
Pol.<x>=PolynomialRing(ZZ) 


M = 1e18
m = 4
B = zero_matrix(ZZ, m+1, m)
for i in range (m) :
    B[i, i] = 1
for j in range (m) :
    B[m, j] = round(M*(r**j))
#print(B)
B = B.transpose()
B = B.LLL()

# print(B)

beta = B[0]

p = Pol(0) 
for i in range (m) :
    p += Pol(beta[i] * x^i)


# # Affichage des resultats

print("\n$ La relation de Machin est alpha1*n1+alpha2*n2+alpha3*n3=0 avec")
for i in range(3):
   print("alpha",i+1,"=",alpha[i])

print("\n$ Un polynome minimal plausible est")
print(p)
print("dont les racines sont")
print(p.roots(ring=RR,multiplicities=false))
print() 


print("""\
# ****************************************************************************
# ALGORITHME LLL
# ****************************************************************************
""")

B = matrix(ZZ,[[  9, -25],
               [ -5,  14],
               [  4, -11]])

A = matrix(ZZ, [[47, 17], [32, 14]])

def lovasz_condition(b) :
    n = b.ncols()
    for i0 in range (n-1) :
        if (b[:,i0].norm())**2 > 2*(b[:,i0+1].norm())**2 :
            return i0
    return -1


def myLLL(M):
    B = copy(M)
    n = B.ncols()
    repeter = True
    while repeter : 
        Betoile, mu = B.transpose().gram_schmidt(orthonormal=false)
        Betoile = Betoile.transpose()
        mu = mu.transpose()
        # ECRIRE L'ETAPE DE REDUCTION
        assert(B==Betoile*mu)
        for i in range (1, n) :
            for j in range (i-1, -1, -1) :
                B[:,i] -= round(mu[j,i]) * B[:,j]
                mu[:,i] -= round(mu[j,i]) * mu[:,j]
        i0 = lovasz_condition(Betoile)
        if i0 >= 0 :
            B[:,i0], B[:,i0+1] = B[:,i0+1], B[:,i0]
        else :
            repeter = False
    assert(all(mu[i,j]<=1/2 for i in range(n) for j in range(i+1,n)))
    assert(all(mu[i,j]>=-1/2 for i in range(n) for j in range(i+1,n)))
    return B


# # Affichage des resultats

print("\n$ Une base LLL de B est")
print(myLLL(B))
print()


print("""\
# ****************************************************************************
# RESEAUX CLASSIQUE
# ****************************************************************************
""")

def Gram(A) :
    # Renvoie la matrice de Gram associée à A
    # ie G(i, j) = A[i] . A[j]
    m = A.nrows()
    G = matrix(A.base_ring(), m, m)
    for i in range (m) :
        ai = A.row(i)
        for j in range (m) :
            aj = A.row(j)
            G[i, j] = ai.dot_product(aj)
    return G, G.determinant()

n = 8
e = vector([1/2]*8)

An = zero_matrix(ZZ,n, n+1)
for i in range (n) :
    An[i, 0] = 1
    An[i, i+1] = -1
G_An, an = Gram(An)

Dn = zero_matrix(ZZ,n,n)
for i in range (n-1) :
    Dn[i, 0] = 1
    Dn[i, i+1] = 1
Dn[n-1, 0] = 2
G_Dn, dn = Gram(Dn)


E8 = matrix(QQ,n, n)
E8[0, 0] = 2
for i in range (1, n-1) :
    E8[i, 0] = 1
    E8[i, i+1] = 1
for j in range (n) :
    E8[n-1, j] = QQ(1/2)
G_E8, e8 = Gram(E8)

reponse5 = "On a <x|y> = SOMME(i, j) xi.yj.<bi|bj>. Si y = x, on a <x|x> = 2 * SOMME(i<=j) xi.xj.<bi|bj> par symétrie. Il suffit donc pour les 2 questions de montrer que la matrice de Gram associée est à coefficient entiers, car ses coefficients sont les <bi|bj>. On a bien cela si on affiche les matrices de Gram de An, Dn, E8. Par exemple, la matrice de Gram de E8 est :"
reponse6 = "D'après la base que nous avons déterminée, tous les vecteurs sont à coordonnées entières sauf e qui est à coordonnées uniquement demi-entières. Selon le nombre (pair ou impair) où e apparait dans la décomposition d'un vecteur de E_8, on a que les coordonées du vecteur sont soit toutes entières, soit toutes demi-entières."

reponse7_an = "Pour An, il faut que somme(xi^2) = 2 et somme(xi) = 0 donc il existe i tel que xi = 1 et j tel que xj = -1 et les autres coefficient valent 0. Il y en a donc (n+1)*n (nombre de choix pour le placement du 1 * nombre de choix pour le placement du 0"
reponse7_dn = "Pour Dn, c'est la même chose, sauf que l'on peut avoir le cas xi=1, xj=1. On a donc (n+1) * n + (2 parmi n+1) = (n+1)*n + (n+1)*n/2"
reponse7_e8 = "Pour E8, c'est la même chose que D8, sauf que l'on rajoute les vecteurs +e et -e, qui verifient <x|x> = 2, il y en a donc (n+1)*n + (n+1)*n/2 + 2"
reponse8 = "La longueur minimale de An, Dn et E8 est toujours sqrt(2) (si on prend la norme usuelle sur R^n). Donc la question précédente répond à cette question."

# # Affichage des resultats

print("$ Question 1+2+3")
print("Une base de An est")
print(An, "de déterminant",an)
print()

print("Une base de Dn est")
print(Dn, "de déterminant",dn)
print()

print("On montre par récurrence que le déterminant de An est n+1")
print("On montre que le déterminant de Dn est 4")
print()

print("$ Question  4+5")
print("Une base de E8 est")
print(E8, "de déterminant",e8)
print()

print(reponse5)
print(G_E8)
print()

print("$ Question 6")
print(reponse6)
print()

print("$ Question 7")
print(reponse7_an)
print(reponse7_dn)
print(reponse7_e8)
print()

print("$ Question 8")
print(reponse8)
print()


print("""\
# ****************************************************************************
# DENSITES OPTIMALES
# ****************************************************************************
""")

from sage.modules.free_module_integer import IntegerLattice

def gram_matrix(A):
    return matrix(ZZ,[[vector(A[:,i]).dot_product(vector(A[:,j])) for j in range(A.ncols())] for i in range(A.ncols())])

def min_det(A) :
    # renvoie un couple lambda1L, detL
    G = gram_matrix(A.transpose())
    #print(G)
    detL = G.det()
    A = A.LLL()
    #print(A)
    #A = Lattice(A)
    #shortest_vec = A.shortest_vector()
    #print(A)
    lambda1L = A[0].norm()
    return lambda1L, detL

def densite(A, n) :
    lambda1L, detL = min_det(A)
    # print(detL)
    ans = pi^(n/2)/(gamma((n/2)+1)*(2^n)) * ((lambda1L^n)/(detL.sqrt()))
    return ans.n()

A2_base = matrix(ZZ, [[1, -1, 0], [1, 0, -1]])
A3_base = matrix(ZZ, [[1, -1, 0, 0], [1, 0, -1, 0], [1, 0, 0, -1]])
D4_base = matrix(ZZ, [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 1, 1], [2, 0, 0, 0]])
D5_base = matrix(ZZ, [
    [1, 1, 0, 0, 0], 
    [0, 1, 1, 0, 0], 
    [0, 0, 1, 1, 0], 
    [0, 0, 0, 1, 1],
    [2, 0, 0, 0, 0]
])
n = 8
E8_base = matrix(QQ,n, n)
E8_base[0, 0] = 2
for i in range (1, n-1) :
    E8_base[i, 0] = 1
    E8_base[i, i+1] = 1
for j in range (n) :
    E8_base[n-1, j] = QQ(1/2)


a2 = densite(A2_base, 2)
a3 = densite(A3_base, 3)
d4 = densite(D4_base, 4)
d5 = densite(D5_base, 5)
e8 = densite(E8_base, 8)

# # Affichage des resultats

print("$ La densité de A2 est",a2)
print("\n$ La densité de A3 est",a3)
print("\n$ La densité de D4 est",d4)
print("\n$ La densité de D5 est",d5)
print("\n$ La densité de E8 est",e8)
print()