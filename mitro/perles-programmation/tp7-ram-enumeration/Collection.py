import FunList

# Collection datastructure
empty = object()

# Retourne une collection qui contient tous les éléments de myCollection
# ainsi que ceux dans listOfItems (myCollection est une collection, listOfItems
# est une liste).

def insertAll(myCollection, listOfItems):
    return FunList.cons(listOfItems, myCollection)

# Retourne une paire avec un élément de la collection et la collection sans cet élément 
def retrieve(myCollection):
    assert myCollection != empty
    h = FunList.head(myCollection)
    q = FunList.tail(myCollection)
    if h == empty :
        return retrieve(q)
    h2 = FunList.head(h)
    q2 = FunList.tail(h)
    return (h2, FunList.cons(q2, q))
