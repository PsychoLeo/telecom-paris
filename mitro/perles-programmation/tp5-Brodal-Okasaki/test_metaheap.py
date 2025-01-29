import MetaHeap as FunHeap
from heapq import heappush, heappop
import sys
import random

def test_OneHeap():    
    a = FunHeap.empty
    heap  = []
    for x in range(100,1000):
        v = x*33%1001
        heappush(heap, v)
        a = FunHeap.insert(v,a)
        
    for x in range(1000,2000):
        v = heappop(heap)
        mini, a = FunHeap.extract_min(a)
        assert(v==mini)
        v = x * 33 % 3001
        a = FunHeap.insert(v, a)
        heappush(heap, v)

    while len(heap):
        v = heappop(heap)
        mini, a = FunHeap.extract_min(a)
        assert(mini == v)
    assert(FunHeap.empty == a)


    
def test_FunOneHeap():    
    a = FunHeap.empty
    heap  = []
    for x in range(100,1000):
        v = x*33%1001
        heappush(heap, v)
        a = FunHeap.insert(v,a)
        b = FunHeap.insert(v//2, a)
        
    for x in range(1000,2000):
        v = heappop(heap)
        mini2, a2 = FunHeap.extract_min(a)
        mini, a = FunHeap.extract_min(a)
        assert(v==mini)
        v = x * 33 % 3001
        a = FunHeap.insert(v, a)
        b = FunHeap.insert(v//2, a)
        c = FunHeap.insert(v*2, b)
        heappush(heap, v)

    while len(heap):
        v = heappop(heap)
        mini, a = FunHeap.extract_min(a)
        assert(mini == v)
    assert(FunHeap.empty == a)



    
def test_Heaps():    
    a = FunHeap.empty
    all_val = []
    for x in range(100): # on fait 100 fois

        # faire un tas avec [20 à 60] valeurs
        values = [ random.randint(0,100000) for _ in range(random.randint(20,60))]
        all_val += values
        b = FunHeap.empty
        for v in values:
            b = FunHeap.insert(v, b)

        # que l'on fusionne à a
        a = FunHeap.meld(a, b)
        target = max(5, len(all_val)-random.randint(50,100))
        # puis on retire des éléments,  au moins 5
        # et de sorte que a contienne au plus entre 50 et 100 éléments
        all_val.sort()
        
        for i in range(target):
            mini,na = FunHeap.extract_min(a)
            assert(mini==all_val[i])
            a = na
        all_val = all_val[target:]
