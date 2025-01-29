import FunBinSkewHeap as sub

empty = object()

def insert(x, q):
    return meld( (x,sub.empty) )

def meld(q1, q2):
    if q1==empty:
        return q2
    if q2==empty:
        return q1
    (x1,s1) = q1
    (x2,s2) = q2
    if x2<x1:
        return meld(q2, q1)
    return (x1, sub.insert(q2,s1) )

def deleteMin(q):
    (x,s) = q
    if s==sub.empty:
        return (x,empty)
    else:
        (x,s2) = 
