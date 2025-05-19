print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP6 : BASES DE GROEBNER ET SYSTEMES POLYNOMIAUX MULTIVARIES                 #
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
#  FONCTIONS DE SAGEMATH
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

MPol.<x,y,z> = PolynomialRing(QQ,3, order='lex')
f = 2*x^2*y+7*z^3

# Code pour l'EXERCICE

print(x<y^2)
print(f.lt())
print(f.lc())
print(f.lm())

reponse  = """
f.lt() renvoie le terme dominant (leading term)
f.lc() renvoie le coefficient du terme dominant (leading coefficient)
f.lm() renvoie le monome dominant (leading monomial)

On a donc lt = lc * lm

Les autres ordres monomiaux implémentés dans SageMath sont :
- lexicographique (lex)
- degré lexicographique (deglex) -> degrés décroissants puis ordre lexicographique si égalité
- degrevlex
- invlex
"""

# # Affichage des resultats

print("\n$1/ ", reponse)


print("""\
# ****************************************************************************
# DIVISION MULTIVARIEE
# ****************************************************************************
""")




# Donnees de l'enonce de l'exercice

MPol.<x,y> = PolynomialRing(QQ,2, order='lex')
f  = -x^7 + x^6*y + 2*x^5 - 2*x^4*y - 5*x^2 + 3*x*y^3 + 5*x*y + 11*y^3 + 10 
f1 = x*y^2+2*y^2
f2 = x^5+5

# Code pour l'EXERCICE

def myDivision(f,F):
    MPol = f.parent()
    n = MPol.ngens()
    s = len(F) 
    # F est la liste des fi
    Q = [MPol(0)]*s # liste des qi
    r = 0
    p = f
    while p != 0 :
        exists = false
        for i in range (s) :
            if p.lt() % F[i].lt() == 0 :
                exists = true 
                Q[i] += p.lt() // F[i].lt()
                p -= (p.lt() // F[i].lt()) * F[i]
                break
        if not exists :
            r += p.lt()
            p -= p.lt()
    assert(f==sum(q*g for q,g in zip(Q,F) )+r)
    return Q,r

# # Affichage des resultats

print("$ ",  myDivision(f,[f1,f2]))
print()


print("""\
# ****************************************************************************
# BASE DE GROEBNER
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

MPol.<x,y,z> = PolynomialRing(QQ,3, order='lex')
f1 = x^2-y
f2 = x*y-z
f3 = z^4+x*y

# Code pour l'EXERCICE

def syzyg(g, h) :
    tdg = g.lt()
    tdh = h.lt()
    p = lcm(tdg, tdh)
    return (p // tdg) * g - (p // tdh) * h

def myGroebner(F):
    G = F 
    while True :
        S = []
        for g in G :
            for h in G :
                # print(syzyg(g, h))
                Q, r = myDivision(syzyg(g, h), G)
                if r != 0 :
                    S.append(r)
        G += S
        if S == [] :
            break 
    return G
    
def myRedGroebner(F):
    G = myGroebner(F)
    while True :
        exists = False 
        for g in G :
            G_prive_g = [h for h in G if h != g] 
            Q, r = myDivision(g, G_prive_g)
            if r == 0 :
                G = G_prive_g
                exists = True 
                break
        if not exists :
            break 
    return G

# # Affichage des resultats

print("\n$1/ ",myGroebner([f1,f2,f3]))
print("\n$2/ ",myRedGroebner([f1,f2,f3]))
I = MPol.ideal([f1,f2,f3])
print("\nBase de Grobner donnée par Sage Math :\n",I.groebner_basis())




print()
print("""\
# ****************************************************************************
# APPARTENANCE A UN IDEAL
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

MPol.<x,y,z> = PolynomialRing(QQ,3, order='lex')
f1 = x*y-y^2
f2 = x^3-z^2
I = Ideal([f1,f2])
f = -4*x^2*y^2*z^2 + y^6 + 3*z^5

# Code pour l'EXERCICE

G = myGroebner([f1, f2])
Q, r = myDivision(f, G)

test1 = f in I
test2 = (r == 0)  # on vérifie que le reste vaut 0


# # Affichage des resultats

print("$ Test de Sage :",test1)
print("$ Test personnel :",test2)
print("On vérifie pour notre test personnel que le reste donné vaut bien 0, en utilisant la base fournie par notre implémentation de myGrobner")
print()


print("""\
# ****************************************************************************
# RESOLUTION D'UN SYSTEME
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


MPol.<x,y> = PolynomialRing(QQ,2) # QUEL ORDRE DEVEZ-VOUS CHOISIR ?
f = (y^2+6)*(x-1) - y*(x^2 + 1)
g = (x^2+6)*(y-1) - x*(y^2 + 1)
 

# Code pour l'EXERCICE
I = Ideal([f,g])
base = I.groebner_basis()

S = PolynomialRing(QQ, 'y')  # Anneau univarié en y
y_univar = S.gen()
f_univar = S(base[0])  # Conversion
racines_y = f_univar.roots() 
racines  = [(2, 2), (2, 3), (3, 3), (3, 2)]

Gf = implicit_plot(f,(x,0,6),(y,0,6),color='red') 
Gg = implicit_plot(g,(x,0,6),(y,0,6),color='blue')  
Gp = point2d(racines,color='green')
combined_plot = Gf + Gg + Gp

# # Affichage des resultats

print("\n$1/  Une base de Groebner de [f,g] est", base)
print("On remarque que l'un des polynômes est seulement une fonction de y")
print("\n$2/  Les valeurs de y sont", racines_y)
print("\n$4/  Les valeurs de (x,y) sont", racines)
print("\n$4/ Le graphique est stocké dans courbes_implicites.png")


combined_plot.show()
combined_plot.save("courbes_implicites.png")
print()


print("""\
# ****************************************************************************
# OPTIMISATION
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


MPol.<x,y,z> = PolynomialRing(QQ,3, order='invlex') # QUEL ORDRE DEVEZ-VOUS CHOISIR ?
f = x^2*y  - 2*x*y + y + 1
g = x^2 + y^2 - 1


# Code pour l'EXERCICE

syst = [g, x*y-y-x*z, x^2-2*x+1-2*y*z]
base = Ideal(syst).groebner_basis()
racines = [(1, 0), (-2/3, sqrt(5)/3), (-2/3, -sqrt(5)/3)]


# # Affichage des resultats

print("\n$1/  On doit resoudre le systeme", syst)
print("J'ai posé lambda = z pour pouvoir écrire les équations plus facilement")
print("\n$2/  dont une base de Groebner est", base)
print("En prenant l'ordre invlex (inverse lexicographique), on a un des polnyômes de la base que l'on écrit : x^3 - 4/3*x^2 - 1/3*x + 2/3 = 1/3*(x-1)^2(3x+2) donc x=1 ou x=-2/3")
print("Si x=1, on a y=0 et z=0, donc (x, y) = (1, 0)")
print("Si x=-2/3, on a y^2 = 5/9 et donc (x, y) = (-2/3, +-sqrt(5)/3) par analyse faite sur papier") 
print("\n$4/  Les valeurs de (x,y) sont", racines)
print()

print("""\
# ****************************************************************************
# MANIPULATIONS ALGEBRIQUES
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

# Code pour l'EXERCICE


MPol.<x,y,u,v> = PolynomialRing(QQ,4,order='lex')
f = x^2 + y^2 - 1
g = x + y - u
h = 2*x*y + 1 - 2*x^2 - v
I = Ideal(f, g, h)
base = I.reduce(y^6)
# # Affichage des resultats

print("$1/", base)
print()


print("""\
# ****************************************************************************
# OVALES DE DESCARTES
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


# Code pour l'EXERCICE

MPol.<x,y,w,z> = PolynomialRing(QQ,4,order='invlex')
f = w+2*z-3
g = w^2 - (x^2 + y^2)
h = z^2 - ((x-1)^2 + y^2)
I = Ideal(f,g,h)
base = I.groebner_basis()

equation = base[2]

# # Affichage des resultats

print("$ L'équation est ",base)


MPol2.<x,y> = PolynomialRing(QQ,2,order='lex')

print("\n$ L'équation est ",equation,"= 0")
p1 = implicit_plot(MPol2(equation),(x,-5,5),(y,-5,5))
p1.save("ovales-descartes.png")