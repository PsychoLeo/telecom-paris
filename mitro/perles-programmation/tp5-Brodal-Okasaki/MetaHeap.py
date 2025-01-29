import FunBinSkewHeap as Heap
import FunList
from functools import total_ordering

empty = object()

# Ce type est utilisé pour stocker des éléments dans le tas
# FunBinSkewHeap. À utiliser pour que la comparaison dans les Heap
# standard soit la comparaison sur l'élément distingué, sinon vous
# risquez d'avoir des problèmes de comparaison.
@total_ordering
class meta_type:
    def __init__(self, el, q):
        self.el = el
        self.q = q

    def __lt__(self,other):
        return self.el < other.el
    
    def __eq__(self, other):
        if other == empty:
            return False
        return self.el == other.el
    
def get_min(h):
    # todo
    pass

def insert(x,q):
    # todo
    pass

def meld(a, b):
    # todo
    pass
    
def extract_min(a):
    # todo
    pass
