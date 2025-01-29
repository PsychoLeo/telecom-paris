import FunList

empty = object()

# renvoie le rang de l'arbre
def rank(l):
    if l == empty :
        return -1
    h, t = l
    v, rk = h
    return rk
    
# combine deux arbres de même rang
def combine(a,b):
    if a == empty :
        return b
    elif b == empty :
        return a
    ha, tla, tra = a
    hb, tlb, trb = b
    va, ra = ha
    vb, rb = hb
    assert ra == rb, "Arbres n'ont pas le même rang"
    if va > vb :
        return ((vb, rb+1), tb, a)
    else :
        return ((va, ra+1), ta, b)


# renvoie l'arbre de rang 0 contenant x
def singleton(x):
    return ((x, 0), empty, empty)

# renvoie la valeur minimale d'un arbre
def get_min(t):
    h, _, _ = t
    v, r = h
    return v
    
# renvoie une paire avec l'élément de valeur minimale
# et la liste des arbres sous cet élément
def extract_min(t):
    h, a1, a2 = t
    v, r = h
    return (v, (a1, a2))


if __name__ == "__main__" :
    t1 = singleton(2)
    t2 = singleton(5)
    t3 = combine(t1, t2)
    t4 = singleton(6)
    t5 = combine(t4, t1)

    print(combine(t3, t5))
