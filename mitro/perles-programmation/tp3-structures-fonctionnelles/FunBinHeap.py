import FunList
import FunBinTree

empty = FunList.empty

# renvoie le rang du plus grand arbre de la liste t
def rank(l):
    if l == empty :
        return -1
    h, t = l
    return FunBinTree.rank(h) # les arbres sont triés du plus grand au plus petit

# fait l'union de deux tas
def meld(a,b):
    assert(False)

# renvoie un tas contenant simplement x
def singleton(x):
    assert(False)

# insère un élément x dans un tas l
def insert(x, t):
    assert(False)

# trouve dans la liste des racines le plus grand arbre et
# renvoie cet arbre ainsi que la liste des arbres sans celui-ci
def extract_min_tree(t):
    assert(False)

# renvoie une paire élément minimum et le tas sans ce minimum
def extract_min(t):
    assert(False)
