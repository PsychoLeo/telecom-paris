p = random_prime(10000)
q = random_prime(10000)
n = p*q
phi = (p-1)*(q-1)

e1 = ZZ.random_element(phi)
while (true):
    try:
        e2 = ZZ.random_element(phi)
        e2 = mod(e2,phi)
        d=1/e2
        break
    except ZeroDivisionError:
        pass

print("Type de e1 : ",type(e1))
print("Parent de e1 : ",parent(e1))
print("Inverse de e1 :",1/e1)
print("Type de e2 : ",type(e2))
print("Parent de e2 : ",parent(e2))
print("Inverse de e2 :",1/e2)

def Chiffrement(a):
    return mod(a,n)^e2

Dechiffrement = lambda b : mod(b,n)^d

for a in range(4):
    print(f"Dechiffrement du chiffrement de {a} :", Dechiffrement(Chiffrement(a)))

'''
Exercice 1 : 

Le type correspond à la classe SageMath à laquelle appartient l'élément.
Le parent correspond à une classe de nombres.
Le calcul de l'inverse de e1 et de e2 ne fonctionne pas de la même manière car ils n'appartiennent pas à la même classe (pour e1, c'est l'inverse dans Q alors que pour e2, c'est l'inverse modulaire, modulo phi)

On a codé ici le cryptosystème RSA 
(a^e)^d = a^(e*d) or e*d = 1 mod phi donc a^(e*d) = a^(1+phi*k) or a^phi = 1 donc = a et on retrouve le message original
'''

'''
Exercice 2 :
'''

'''
1.
Avec l'algorithme d'Euclide, on trouve:
29*435-106*119 = 1
'''

m = 119
n = 435
print("Coefficients extended gcd :", xgcd(m, n))

'''
2. 
On trouve comme solution à l'aide de la fonction crt (chinese remainder theorem, ie théorème des restes chinois) : x = 227 (mod m*n)
'''

alpha, beta = 2, 3
m, n = 45, 14
x = crt([alpha, beta], [m, n])
print("Trouvé par chinese remainder theorem (technique 1):", x)
# on vérifie que x est bien solution
# print(mod(x, m) == alpha)
# print(mod(x, n) == beta)


# Technique plus "brute force", on parcourt les alpha + m*k, puis on vérifie si la deuxième équation est vérifiée
for x in [alpha + m*k for k in range (n)] :
    if mod(x, n) == beta :
        print("Trouvé par brute-force (technique 3):", x)

# 3e idée : sorte d'interpolation de Lagrange sur les entiers
# on réutilise les coefficient de extended gcd (celui qui nous donne les coefficient u, v tels que au + bv = gcd(a, b))

g, u, v = xgcd(m, n)
y = alpha * v * n + beta * u * m
print("Résultat obtenu en utilisant les coefficients de l'extended gcd (technique 2):", y)

'''
Exercice 3 :
'''

p = 157
k = 4
q = p^k

Fp = FiniteField(p)
Fq.<alpha> = FiniteField(q)

# pour retrouver le polynôme irreductible utilisé par SageMath :
P = Fq.modulus()
print("Polynôme irreductible utilisé par SageMath :", P)

def sigma(z) :
    return z^p

z = 130*alpha^3 + 97*alpha^2 + 99*alpha + 18
print("Sigma(z) = ", sigma(z))

# nous donne 109*alpha^3 + 88*alpha^2 + 7*alpha + 103

Q = matrix(Fp,k,k)

for i in range (k) :
    z_poly = sigma(alpha^i).polynomial()
    coeffs = z_poly.coefficients()
    vector_coeffs = coeffs + [0] * (k + 1 - len(coeffs))
    for j in range (k) :
        Q[j, i] = vector_coeffs[j]

print("Matrice Q :\n", Q)

v = [1, alpha, alpha^2, alpha^3]
print("Calcul de z via la matrice Q :", vector(v) * Q * vector(z)) # cela fonctionne bien

# Note : le Frobenius nous fait passer d'une racine à une suivante
# donc alpha -> alpha^p -> alpha^(2*p) etc...

# On utilise la matrice inverse de Q (avec Q^(-1))
# Autre méthode : on sait que sigma^4 = Id, donc sigma^-1 = sigma^3

# Définir la variable x pour F[x]
R.<x> = Fp[]

f = x^4 - 48*x^3 + 19*x^2 - 2*x - 32
print("Le polynôme est irreductible :", f.is_irreducible())

roots = f.roots(Fq)

root1 = roots[0][0] # on prend la première racine
for i in range (k) :
    print(f"La {i}eme racine correspond bien :", root1 == roots[i][0])
    root1 = sigma(root1)


'''
Exercice 4: 
'''

# on va fixer n = 4, p = 3
n = 4
p = 2

Fp = FiniteField(p)
R.<x> = Fp[]

irred_degn = []

print("Polynomes irreductibles de degré n sur Fp[X] :")

for P in R.polynomials(of_degree=n) :
    if P.is_irreducible() and P.leading_coefficient() == 1:
        irred_degn.append(P)
        print(P)

t = p^n-1
print("Nombre des polynômes unitaires irred de deg n sur Fp[X] :", len(irred_degn))
print("PHI(p^n-1)/n =", euler_phi(t)/n)