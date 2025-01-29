import FunList
import FunBinSkewTree as ST # raccourci pour le code

empty = FunList.empty

# cette fonction doit s'assurer qu'il ne reste pas deux tas de même
# rang dans la liste l en "propageant" la retenue
def propagate_carry(l):
    if l == empty :
        return empty
    h1, q = FunList.head(l), FunList.tail(l)
    if q == empty :
        return l
    h2 = FunList.head(q)
    q2 = FunList.queue(q)
    if ST.rank(h1) == ST.rank(h2) :
        return propagate_carry(FunList.cons(ST.simple_link(h1, h2), q2))
    return l


# cette fonction prend deux listes d'arbres par triées par rang
# décroissant et fait l'union d'une façon à ce que les rangs soient
# tous distincts et triées dans le même ordre
def rec_meld_lists(a,b):
    if a == empty :
        return b
    elif b == empty :
        return a
    ha, qa = FunList.head(a), FunList.tail(a)
    hb, qb = FunList.head(b), FunList.tail(b)
    if ST.rank(ha) > ST.rank(hb) :
        return propagate_carry(FunList.cons(ha, rec_meld_lists(qa, b)))
    elif ST.rank(ha) < ST.rank(hb) :
        return rec_meld_lists(b, a)
    assert ST.rank(ha) == ST.rank(hb) # rank sont égaux
    return propagate_carry(FunList.cons(ST.simple_link(ha, hb), rec_meld_lists(qa, qb)))


# même chose que la fonction ci haut mais avec l'ordre inverse
def combine_list(lA, lB):
    pass
    
def singleton(x):
    pass

def insert(x, l):
    pass

# insère les éléments de to_insert dans into
def insert_list(to_insert, into):
    pass

def extract_min_tree(t):
    pass


def extract_min(t):
    pass

def meld(a,b):
    pass
