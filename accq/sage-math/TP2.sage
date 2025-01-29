print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP2 : ALGEBRE LINEAIRE SUR UN ANNEAU PRINCIPAL                              #
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
# MISE SOUS FORME NORMALE D'HERMITE
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

A = matrix(ZZ,[
        [-2,  3,  3,  1],
        [ 2, -1,  1, -3],
        [-4,  0, -1, -4]])

A1 = random_matrix(ZZ, 7, 8, algorithm='echelonizable', rank=3)

U = identity_matrix(4)

# Code pour l'EXERCICE

def cherche_pivot_non_nul(M, i,j):
    """
    Renvoie la première colonne avec un coef non nul (et d'indice <j), -1 s'il n'y en a pas
    """
    for j0 in range (0, j) :
        if M[i, j0] != 0 :
            return j0
    return -1    

# print(xgcd(12, 5))

def normalise_pivot(M, U, i,j):
    """
    Multiplie la colonne j si besoin pour que A[i,j] soit positif.
    """
    if M[i, j] < 0 :
        for i0 in range (M.nrows()) :
            M[i0, j] *= -1
        for i0 in range(U.nrows()) :
            U[i0, j] *= -1


def annule_a_gauche(M, U, i,k):
    """
    Annule les coefficients à gauche de A[i,j]
    """
    for j in range (k) :
        if M[i, j] != 0 :
            a, b = M[i, k], M[i, j]
            d, u, v = xgcd(a, b)
            s = - M[i, j]//d 
            t = M[i, k]//d
            # on a a*u + b*v = d
            for ni in range (M.nrows()) :
                x1 = s*M[ni, k] + t*M[ni, j]
                x2 = u * M[ni, k] + v * M[ni, j]
                M[ni, j], M[ni, k] = x1, x2
            for ni in range(U.nrows()) :
                y1 = s*U[ni, k] + t*U[ni, j]
                y2 = u * U[ni, k] + v * U[ni, j]
                U[ni, j], U[ni, k] = y1, y2

# annule_a_gauche(A, U, 2, 3)
print(A)

def transposition(M, U, j1, j2) :
    """
    Echange les colonnes j1 et j2
    """
    for i in range (M.nrows()) :
        M[i, j1], M[i, j2] = M[i, j2], M[i, j1]
    for i in range (U.nrows()) :
        U[i, j1], U[i, j2] = U[i, j2], U[i, j1]

def transvection(M, U, i, j1, j2) :
    """
    Effectue une transvection : Xj1 <- Xj1 - (xij1/xij2) * Xj2
    """
    r = M[i, j1]//M[i, j2]
    for ni in range (M.nrows()) :
        M[ni, j1] -= r * M[ni, j2]
    for ni in range (U.nrows()) :
        U[ni, j1] -= r * U[ni, j2]

def MyHNF(A):
    """
    Forme normale d'Hermite selon votre code
    """
    m = A.nrows()
    n = A.ncols()
    H = copy(A)
    U = identity_matrix(n)
    i = m-1
    k = n-1
    l = max(0, m-n)
    while i >= l :
        if cherche_pivot_non_nul(H, i, k+1) >= 0 : # si vaut -1 ce n'est pas le cas
            while cherche_pivot_non_nul(H, i, k) >= 0 :
                j0 = cherche_pivot_non_nul(H, i, k)
                transposition(H, U, j0, k)
                normalise_pivot(H, U, i, k)
                annule_a_gauche(H, U, i, k)
            for j in range (k+1, n) :
                transvection(H, U, i, j, k)
            i -= 1
            k -= 1
        else: 
            i -= 1
    assert(H-A*U==0)
    return H,U

def SageHNF(A):
    """
    Forme normale d'Hermite de SAGE avec la convention francaise :
    Les vecteurs sont ecrits en colonne.
    """
    m = A.nrows()
    n = A.ncols()
    Mm = identity_matrix(ZZ,m)[::-1,:]
    Mn = identity_matrix(ZZ,n)[::-1,:]
    AA = (Mm*A).transpose()
    HH, UU = AA.hermite_form(transformation=True)
    H = (HH*Mm).transpose()*Mn
    U = UU.transpose()*Mn
    assert(H-A*U==0)
    return H,U

H, U = MyHNF(A)
HH, UU = SageHNF(A)

print("\n$ Question 4")
print("La matrice A = ")
print(A)
print("a pour forme normale d'Hermite H=")
print(H)
print("et matrice de transformation U=")
print(U)
print("On a H-A*U =")
print(H-A*U)
print("\n$ Question 5")
print("D'apres SageMath, la matrice A a pour forme normale d'Hermite H=")
print(HH)
print("et matrice de transformation U=")
print(UU)
print("\n$ Question 6")
print("Les deux fonctions coincident-elles sur une centaine d'exemples ?")
test = True
for _ in range (100) :
    A1 = random_matrix(ZZ, 7, 8, algorithm='echelonizable', rank=3)
    H, U = MyHNF(A1)
    if (H-A1*U != 0) : 
        test = False
print(test)

print()


print()
print("""\
# ****************************************************************************
# MISE SOUS FORME NORMALE DE SMITH
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

X1 = matrix(ZZ,2,3,[
        [4, 7, 2],
        [2, 4, 6]])

X2 = matrix(ZZ,3,3,[
        [-397, 423, 352],
        [   2,  -3,   1],
        [-146, 156, 128],
])

PolQ.<xQ> = PolynomialRing(QQ)
AQ = matrix(PolQ,3,[
            [xQ + 1,  2,     -6],
            [     1, xQ,     -3],
            [     1,  1, xQ - 4]])
Pol2.<x2> = PolynomialRing(FiniteField(2))
AF2 = matrix(Pol2,3,[
            [x2 + 1,  2,     -6],
            [     1, x2,     -3],
            [     1,  1, x2 - 4]])
Pol3.<x3> = PolynomialRing(FiniteField(3))
AF3 = matrix(Pol3,3,[
            [x3 + 1,  2,     -6],
            [     1, x3,     -3],
            [     1,  1, x3 - 4]])
Pol5.<x5> = PolynomialRing(FiniteField(5))
AF5 = matrix(Pol5,3,[
            [x5 + 1,  2,     -6],
            [     1, x5,     -3],
            [     1,  1, x5 - 4]])

# Code pour l'EXERCICE

def exists_non_null(X, k) :
    # O(min(n, m)) complexity
    m = X.nrows()
    n = X.ncols()
    for i in range (k+1, m) :
        if X[i, k] != 0 :
            return True
    for j in range (k+1, n) :
        if X[k, j] != 0 :
            return True
    return False

def normalise_pivot(M, U, i,j):
    """
    Multiplie la colonne j si besoin pour que A[i,j] soit positif.
    """
    if M[i, j] < 0 :
        for i0 in range (M.nrows()) :
            M[i0, j] *= -1
        for i0 in range(U.nrows()) :
            U[i0, j] *= -1


def MySNF(X):
    """
    Forme normale de Smith selon votre code
    """
    m = X.nrows()
    n = X.ncols()
    H = copy(X)
    L = identity_matrix(H.base_ring(), m)
    C = identity_matrix(H.base_ring(), n)
    for k in range (min(n, m)) :
        if H[k, k] == 0 :
            exists = False
            for i0 in range (k, m) :
                for j0 in range (k, n) :
                    if not exists and H[i0, j0] != 0 :
                        H.swap_rows(k, i0)
                        L.swap_rows(k, i0)
                        H.swap_columns(k, j0)
                        C.swap_columns(k, j0)
                        exists = True
            if not exists :
                assert (H-L*X*C==0)
                return H, L, C
        while exists_non_null(H, k) :
            for i in range (k+1, m) :
                d, s, t = xgcd(H[k, k], H[i, k])
                if (H[i, k] % H[k, k] == 0) :
                    d = H[k, k]
                    s, t = 1, 0
                u = -H[i, k]//d 
                v = H[k, k]//d 
                # Modifications pour H
                LH1 = s * H[k,:] + t * H[i,:]
                LH2 = u * H[k,:] + v * H[i,:]
                H[k,:] = LH1
                H[i,:] = LH2 
                # Modifications pour L
                LL1 = s * L[k,:] + t * L[i,:]
                LL2 = u * L[k,:] + v * L[i,:]
                L[k,:] = LL1
                L[i,:] = LL2
            for j in range (k+1, n) :
                d, s, t = xgcd(H[k, k], H[k, j])
                if (H[k, j] % H[k, k] == 0) :
                    d = H[k, k]
                    s, t = 1, 0
                u = -H[k, j]//d 
                v = H[k, k]//d 
                # Modifications pour H
                CH1 = s * H[:,k] + t * H[:,j]
                CH2 = u * H[:,k] + v * H[:,j]
                H[:,k] = CH1
                H[:,j] = CH2 
                # Modifications pour C
                CC1 = s * C[:,k] + t * C[:,j]
                CC2 = u * C[:,k] + v * C[:,j]
                C[:,k] = CC1
                C[:,j] = CC2 
            found = False
            for i0 in range (k+1, m) :
                for j0 in range (k+1, n) :
                    if not found and H[i0, j0] % H[k, k] != 0 :
                        H[:,k] = H[:,k] + H[:,j0]
                        C[:,k] = C[:,k] + C[:,j0]
                        found = True
        normalise_pivot(H, C, k, k)
    assert(H-L*X*C==0)
    return H,L,C

H1, L1, U1 = MySNF(X1)
H2, L2, U2 = MySNF(X2)

HQ, _, _ = MySNF(AQ)
HF2, _, _ = MySNF(AF2)
HF3, _, _ = MySNF(AF3)
HF5, _, _ = MySNF(AF5)

test = True # Test a ecrire
for _ in range (10) :
    A = random_matrix(ZZ, 7, 8)
    myH, _, _ = MySNF(A)
    H, _, _ = A.smith_form()
    if myH != H :
        print(myH)
        print(H)
        test = False
# # Affichage des resultats

print("\n$ Question 4")
print("La matrice X1 = ")
print(X1)
print("a pour forme normale de Smith H1=")
print(H1)
print("et matrice de transformation L1=")
print(L1)
print("et matrice de transformation U1=")
print(U1)
print("La matrice X2 = ")
print(X2)
print("a pour forme normale de Smith H2=")
print(H2)
print("et matrice de transformation L2=")
print(L2)
print("et matrice de transformation U2=")
print(U2)

print("\n$ Question 5")
print("La forme normale de Smith sur Q est ")
print(HQ)
print("La forme normale de Smith sur F2 est ")
print(HF2)
print("La forme normale de Smith sur F3 est ")
print(HF3)
print("La forme normale de Smith sur F5 est ")
print(HF5)

print("\n$ Question 6")
print("Votre fonction coincide avec celle de Sage ?")
print(test)


print()

print("""\
# ****************************************************************************
# RESOLUTION DE SYSTEME LINEAIRE HOMOGENE
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

X = matrix(ZZ,[
      [ -2,  3,  3,  1],
      [  2, -1,  1, -3],
      [ -4,  0, -1, -4]])

print("Exercice 59")
print("La matrice correspond à celle de l'énoncé, il nous suffit donc de trouver d'après la proposition 57 les r premières colonnes de U, qui forment une base du noyau de A. Il y a seulement la première colonne de H qui est nulle, donc r=1 et on prend la première colonne de U : (8, 19, -12, -5) qui est donc une base de Ker A, et nous donne une solution du système.")
print()

print("""\
# ****************************************************************************
# IMAGE D'UNE MATRICE
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

A  = matrix(ZZ, [
           [ 15,  8, -9, 23,  -9],
           [ 22, 22,  7, -8,  20],
           [ 21, 18, -1, -7,  -3],
           [  3, -1,  0, 12, -16]])


# Code pour l'EXERCICE
print("Exercice 60")
H, U = MyHNF(A)
print("$ Question 1")
print(H)
print(U)
print("Non, on a pas cela car il y a une colonne nulle dans la matrice H et la première colonne de U n'est pas nulle")

print("$ Question 2")
Z4 = ZZ^4 
M = Z4.submodule(A.transpose())
print("L'image de")
print(A)
print("est-elle egale a ZZ^4 ?")
print(M == Z4)


print()
print("""\
# ****************************************************************************
# RESOLUTION DE SYSTEME LINEAIRE NON-HOMOGENE
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

def solution_particuliere(X, b, z) :
    H, L, C = X.smith_form()
    b_prime = L*b
    m = len(b_prime)
    #print("b_prime =")
    #print(b_prime)
    #print("H = ")
    #print(H)
    #print(C)
    sol = []
    for i in range (m) :
        ai = H[i, i]
        if ai != 0 and b_prime[i] % ai != 0 :   
            return "No solution", []
        elif ai == 0 and b_prime[i] != 0 :
            return "No solution", []
        elif ai != 0 :
            for j in range (C.nrows()) :
                z[j] += (b_prime[i]//ai) * C[j,i]
        else : # ie ai == 0 and b_prime[i] == 0
            sol.append(vector(C[:,i]))
    return z, sol

X1 = matrix(ZZ,[
           [ -6,  12,  6],
           [ 12, -16, -2],
           [ 12, -16, -2]])

b1 = vector(ZZ,[ -6, 4, 4])

PolF5.<x> = PolynomialRing(GF(5))

X2 = matrix(PolF5,[
           [ x + 1, 2,     4],
           [     1, x,     2],
           [     1, 1, x + 1]])

b2 = vector(PolF5,[ 3*x+2, 0, -1])

X3 = matrix(ZZ,[
    [ 2, -3, 4, 0],
    [ 4, 4, 53, 5]])

b3 = vector(ZZ, [-4, 2])

# Code pour l'EXERCICE

z1 = vector(ZZ,3)
v1, H1 = solution_particuliere(X1, b1, z1)

z2 = vector(PolF5,3)
v2, H2 = solution_particuliere(X2, b2, z2)

z3 = vector(ZZ,4)
v3, H3 = solution_particuliere(X3, b3, z3)

# # Affichage des resultats

print("Une solution particuliere de X1*z1 = b1 est")
print(v1)
print("les solutions du systeme homogene sont engendres par")
print(H1)
print("Une solution particuliere de X2*z2 = b2 est")
print(v2)
print("les solutions du systeme homogene sont engendrees par")
print(H2)
print("Une solution particuliere du systeme 3 est")
print(v3)
print("les solutions du systeme homogene sont engendres par")
print(H3)

print()
print("""\
# ****************************************************************************
# STRUCTURE DU QUOTIENT
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

A = matrix(ZZ,[
              [ -630,   735,   0,   735, -630],
              [ 1275, -1485, -15, -1470, 1275],
              [  630,  -630,   0,  -630,  630]])

# Code pour l'EXERCICE

print("""Exercice 80 : 

En utilisant l'application 77 et l'exemple 78, on peut en déduire qu'il suffit de réduire la matrice sous forme de Smith et d'exhiber les coefficients sur la diagonale pour déduire la structure de Z^3/N.
""")

# # Affichage des resultats
H, L, C = MySNF(A)
print(H)

reponse = "Z/15Z + Z/105Z + Z/630Z"

print("La structure de Z^3/N est")
print(reponse)


print()
print("""\
# ****************************************************************************
# FACTEURS INVARIANTS
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

A = matrix(ZZ,[
              [ -630,   735,   0,   735, -630],
              [ 1275, -1485, -15, -1470, 1275],
              [  630,  -630,   0,  -630,  630]])


# Code pour l'EXERCICE

S, L, C = A.smith_form()
rang = min(A.nrows(),A.ncols()) - A.rank()
fact_inv = [S[i,i] for i in range(min(S.nrows(),S.ncols())) if S[i,i] !=0]
reponse = f"L'ensemble des exposants est {lcm(fact_inv)}Z" if rang == 0 else f"Il n'y a pas d'exposants"

# # Affichage des resultats

print("Le rang de Z^3 / N est")
print(rang)
print("Les facteurs invariants sont")
print(fact_inv)
print("Exposants ?")
print(reponse)