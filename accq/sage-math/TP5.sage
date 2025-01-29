print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP5 : FACTORISATION COMPLETE DE POLYNOMES UNIVARIEES                        #
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



print("""\
# ****************************************************************************
# BERLEKAMP
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

F3 = FiniteField(3)
Pol3.<x> = PolynomialRing(F3)
f = x^3 - x^2 - 1

# Code pour l'EXERCICE

x3 = x^3 % f
x6 = x^6 % f
Q = matrix(F3,[[1, 1, 2], [0, 0, 1], [0, 1, 0]]) # on trouve cela par application directe de l'écriture de Q donnée dans l'algorithme 12

b1 = vector(F3,[1,0,0])
b2 = vector(F3,[0,1,1])
# c'est une base car le rang de la matrice Q-I est 1


print("\n$1a/ x^3 vaut",x3," et x^6 vaut",x6)
print("La matrice de Petr Berlekamp est")
print(Q)

print("\n$1b/ On a Q * b1 - b1 = ")
print(Q*b1-b1)
print("et Q * b2 - b2 = ")
print(Q*b2-b2)

print()
print("(b1, b2) est une base car le rang de Q-I est 1 : la première colonne est nulle et pour les 2 autres, on a 2*C2 = C3. Donc la dimension de Ker(Q-I) est 2 et la famille (b1, b2) est libre, c'est donc une base du noyau")
print()

print("Pour déterminer la factorisation de f, on va utiliser b2 (car b1 est constant) auquel on va ajouter alpha dans F3 puis on va calculer le pgcd avec f")

facto = []
for alpha in [0, 1, 2] :
    g = gcd(f, x+x^2+alpha)
    if g not in facto and g != 1:
        facto.append(g)
print("Factorisation de f :")
print(facto)
print()

def myB(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    n = f.degree()
    Fq = FiniteField(q)
    Q = matrix(Fq, n, n)
    for j in range (n) :
        modf = (x^(j*q) % f)
        for i in range (n) :
            Q[i, j] = modf[i]
    # print(Q)
    M = Q-identity_matrix(n)
    kerM = M.right_kernel()
    b = kerM.basis()
    # print(b)
    F = [f]
    j = 0
    while len(F) < len(b) :
        j += 1
        C = [fi for fi in F if fi.degree() > 1]
        for fi in C :
            B = []
            for alpha in range(q) :
                # print(b[j])
                pol_bj = sum(b[j][l]*(x^l) for l in range (q))
                a = gcd(fi, pol_bj-alpha)
                if a.degree() > 0 :
                    B.append(a)
            F.remove(fi)
            F += B
    # print(Set(F))
    assert(Set(F) == Set(g for g,_ in list(f.factor())))
    return F

Pol.<z> = PolynomialRing(FiniteField(7))
test = true
for _ in range (100) :
    f = Pol.random_element(1, 10)
    f = z^(f.degree()) + sum(f[i]*z^i for i in range (f.degree()))
    try : 
        myB(f)
    except : # si un des assert est faux
        test = false 
        break 

print("Résultats de 100 tests aléatoires de l'algorithme de Berlekamp : ") 
print(test)
print()

def myFsFC(f):
    # fonction de factorisation sans facteurs carrés du TP4
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    fp = f.derivative()
    if f == 0 :
        return []
    elif fp != 0 :
        i = 1
        L = []
        t = gcd(f, fp)
        u = f//t
        while u != 1 :
            y = gcd(t, u)
            if i % p != 0 and u//y != 1 :
                L += [(u//y, i)]
            i += 1
            u = y
            t = t//y
        if t != 1 :
            for (s, i) in myFsFC(racine_p_polynome(t)) :
                L += [(s, p*i)]
    else :
        for (s, i) in myFsFC(racine_p_polynome(f)) :
            L += [(s, p*i)]
    assert(prod([f^e for (f,e) in L]) == f)
    return L

def myFactor(f):
    Pol=f.parent()
    x=Pol.gen()
    p=Pol.base_ring().characteristic()
    q=Pol.base_ring().cardinality()
    L = myFsFC(f) # list des (gi, i)
    retour = []
    for (gi, i) in L :
        for p in myB(gi) :
            retour.append((p, i))
    assert(Set(retour) == Set(list(f.factor())))
    return retour


# # Affichage des resultats

Pol.<z> = PolynomialRing(FiniteField(7))
test = true
for _ in range (100) :
    f = Pol.random_element(1, 10)
    f = z^(f.degree()) + sum(f[i]*z^i for i in range (f.degree()))
    try : 
        myFactor(f)
    except : # si un des assert est faux
        test = false 
        break 

print("Résultats de 100 tests aléatoires de l'algorithme de factorisation complet : ") 
print(test)
print()


print("""\
# ****************************************************************************
# RELEVEMENT DE HENSEL
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

PolZZ.<x> = PolynomialRing(ZZ)
m = 5
f = x^4-1
g = x^3+2*x^2-x-2
h = x-2
d,ss,tt = xgcd(g,h)
s=PolZZ(ss/mod(d,m)); t=PolZZ(tt/mod(d,m))

# Code pour l'EXERCICE

def polynomeCentre(f,m):
    Pol=f.parent()
    x=Pol.gen()
    retour = Pol([mod(coeff,m).lift_centered() for coeff in list(f)])
    return retour

def modPol(p, m) :
    Pol=f.parent()
    x=Pol.gen()
    retour = Pol([mod(coeff,m) for coeff in list(p)])
    return retour

def myHensel(f,g,h,s,t,m):
    Pol=f.parent()
    x=Pol.gen()
    e = modPol(f - g*h, m*m)
    q = modPol((s*e) // h, m*m)
    r = modPol((s*e) % h, m*m)
    g_ = modPol(g+t*e+q*g, m*m)
    h_ = modPol(h+r, m*m)
    b = modPol(s*g_ + t*h_ - 1, m*m)
    c = modPol((s*b) // h_, m*m)
    d = modPol((s*b) % h_, m*m)
    s_ = modPol(s-d, m*m)
    t_ = t - t*b - c*g_ 
    g_ = polynomeCentre(g_, m*m)
    h_ = polynomeCentre(h_, m*m)
    s_ = polynomeCentre(s_, m*m)
    t_ = polynomeCentre(t_, m*m)
    return g_, h_, s_, t_

def myHenselItere(f,g,h,s,t,m,l):
    Pol=f.parent()
    x=Pol.gen()
    pow2t = 1
    while pow2t < l :
        m = (m*m)
        pow2t *= 2
        g, h, s, t = myHensel(f, g, h, s, t, m)
    return g, h, m, pow2t

reponseQ5="Si f se factorise en produit de plus de 2 facteurs, on peut appliquer n itérations ou n est le nombre de facteurs dans la décomposition. Soit gi un facteur premier avec les autres dans la décomposition de f, alors on écrit f = gi*h avec h produit d'autres facteurs, on applique Hensel et on a f = (gi)^ * h^ (mod p^l) puis on applique à h récursivement"

# # Affichage des resultats

print("\n$1b/ Relèvement de ",f,"= (",g,")*(",h,")")
print(myHensel(f,g,h,s,t,m))
print("\n Relèvement modulo 25 de ",f,"= (",g,")*(",h,")")
print(myHensel(f,g,h,s,t,m))
print("\n Relèvement modulo 625 de ",f,"= (",g,")*(",h,")")
print(myHenselItere(f,g,h,s,t,5,4))
print()
print(reponseQ5)
print()


print("""\
# ****************************************************************************
# FACTORISATION AVEC LLL
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

p=13
k=4
m=p^k

PolZZ.<x> = PolynomialRing(ZZ)
f = x^4-x^3-5*x^2+12*x-6

alpha=3
beta=5
gamma=8
delta=11

u = x+7626

# Code pour l'EXERCICE


Pol13pow4.<x> = PolynomialRing(Integers(m))
f_ = Pol13pow4(f)
rac_Z13pow4 = f_.roots(multiplicities=false)
rac_Z13pow4 = [r.lift_centered() for r in rac_Z13pow4]

alphahat = [z for z in rac_Z13pow4 if z%13 == alpha][0]
betahat = [z for z in rac_Z13pow4 if z%13 == beta][0]
gammahat = [z for z in rac_Z13pow4 if z%13 == gamma][0]
deltahat = [z for z in rac_Z13pow4 if z%13 == delta][0]

# # Affichage des resultats

print("$1a/ Les racines sont", alpha, beta, gamma, delta,"modulo",p)
F13 = FiniteField(13)
Pol13.<z> = PolynomialRing(F13)
f = z^4-z^3-5*z^2+12*z-6
print(f.roots())

print("\n$1b/ Les racines sont", alphahat, betahat, gammahat, deltahat,"modulo",m)
print()

PolZZ.<x> = PolynomialRing(ZZ)
f = x^4-x^3-5*x^2+12*x-6


print("$1c) f mod x-alphahat : ", (f % (x-alphahat)))
print("f mod x-betahat : ", (f % (x-betahat)))
print("f mod x-gammahat : ", (f % (x-gammahat)))
print("f mod x-deltahat : ", (f % (x-deltahat)))
print()

uu = Pol13pow4(u)
test = (f_ % uu == 0)

d = u.degree()
j=3

x = PolZZ.gen()
L = [u*PolZZ(x^i) for i in range(j-d)] + [m*PolZZ(x^i) for i in range(j)]
M = Matrix(ZZ, len(L), j, [[L[h][i] for i in range(j)] for h in range(len(L))])
LLL_basis = M.LLL()
i=0
while not(any(LLL_basis[i,:])):
    i+=1
vecteur_court = list(LLL_basis.row(i))
g = PolZZ(vecteur_court)
fact1 = gcd(g,f)
fact2 = f/fact1

print("$2a/ Si u divise f modulo 13^4 :", test)
print() 
print("$2b/ Facteur de f :", fact1)
print()
print("$2c/ Factorisation de f : f=(",fact1,")*(",fact2,")")