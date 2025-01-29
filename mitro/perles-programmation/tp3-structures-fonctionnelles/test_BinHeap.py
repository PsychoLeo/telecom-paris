import FunBinHeap
from heapq import heappush, heappop
import sys
import random

def test_OneHeap():    
    a = FunBinHeap.empty
    heap  = []
    for x in range(100,1000):
        v = x*33%1001
        heappush(heap, v)
        a = FunBinHeap.insert(v,a)
        
    for x in range(1000,2000):
        v = heappop(heap)
        mini, a = FunBinHeap.extract_min(a)
        assert(v==mini)
        v = x * 33 % 3001
        a = FunBinHeap.insert(v, a)
        heappush(heap, v)

    while len(heap):
        v = heappop(heap)
        mini, a = FunBinHeap.extract_min(a)
        assert(mini == v)
    assert(FunBinHeap.empty == a)


    
def test_Heaps():    
    a = FunBinHeap.empty
    all_val = []
    for x in range(100): # on fait 100 fois

        # faire un tas avec [20 à 60] valeurs
        values = [ random.randint(0,100000) for _ in range(random.randint(20,60))]
        all_val += values
        b = FunBinHeap.empty
        for v in values:
            b = FunBinHeap.insert(v, b)

        # que l'on fusionne à a
        a = FunBinHeap.meld(a, b)
        target = max(5, len(all_val)-random.randint(50,100))
        # puis on retire des éléments,  au moins 5
        # et de sorte que a contienne au plus entre 50 et 100 éléments
        all_val.sort()
        
        for i in range(target):
            mini,na = FunBinHeap.extract_min(a)
            assert(mini==all_val[i])
            a = na
        all_val = all_val[target:]
