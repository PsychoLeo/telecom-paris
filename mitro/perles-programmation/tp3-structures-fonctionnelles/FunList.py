# Objet liste
empty = object()

# renvoyer la taille de la liste
def size(l):
    if l == empty :
        return 0
    h, _ = l
    _, sz = h
    return sz
    
# renvoie une liste contenant x puis le reste de l
def cons(x, l):
    if l == empty :
        return ((x, 1), l) 
    h, _ = l
    _, sz = h
    return ((x, sz+1), l)
    
# renvoie la tete de la liste
def head(l):
    if l == empty :
        return empty
    h, _ = l
    val, _ = h
    return val

# renvoie la queue de la liste
def tail(l):
    if l == empty :
        return empty
    _, t = l
    return t
    

