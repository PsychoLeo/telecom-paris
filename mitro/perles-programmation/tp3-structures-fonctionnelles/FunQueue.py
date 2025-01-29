import FunList

# List datastructure
empty = object()

def size(l):  # renvoyer la taille
    if l == empty :
        return 0
    # O(1)
    a, b = l
    return FunList.size(a) + FunList.size(b)
    
def enqueue(x, l): # ajouter x en queue
    if l == empty :
        return (FunList.cons(x, FunList.empty), FunList.empty)
    a, b = l
    return (FunList.cons(x, a), b)

def invert(l) :
    if l == empty :
        return empty
    a, b = l
    if a == FunList.empty :
        return l
    h, t = a
    v, _ = h
    return invert((t, FunList.cons(v, b)))


def dequeue(l): # retirer le premier élément inséré
    if l == empty :
        return empty
    a, b = l
    if b == FunList.empty :
        if a == FunList.empty :
            return empty
        else :
            return dequeue(invert(l))
    else :
        h, t = b
        val, _ = h
        return (val, (a, t))
