import FunQueue
import sys

def test_OneFunQueue():    
    a = FunQueue.empty
    for x in range(100):
        assert(FunQueue.size(a) == x)
        a = FunQueue.enqueue(x,a)
        
    for x in range(100):
        assert(FunQueue.size(a) == 100)
        el,nouv_a = FunQueue.dequeue(a)
        a = nouv_a
        assert(FunQueue.size(a) == 99)
        assert x == el
        a = FunQueue.enqueue(x,a)

    for x in range(100):
        el,a = FunQueue.dequeue(a)
        assert x == el

        
        
def test_FunQueues():    
    a = [ [] for _ in range(10) ]
    b = [ FunQueue.empty for _ in range(10) ]
    
    for i in range(10000):
        q = (i%33)%10
        r = (i%37)%10
        if len(a[r]) <= i%42:
            a[q] = [i]+a[r]
            b[q] = FunQueue.enqueue(i,b[r])
        else:
            elA = a[r][-1]
            a[q] = a[r][:-1]
            el, b[q] = FunQueue.dequeue(b[r])
            assert(el==elA)
        for j in range(10):
            assert len(a[j]) == FunQueue.size(b[j])
            if len(a[j]):
                assert a[j][-1] == FunQueue.dequeue(b[j])[0]
                
