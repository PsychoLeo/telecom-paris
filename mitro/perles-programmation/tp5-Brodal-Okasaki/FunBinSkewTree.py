import FunList

empty = object()

def rank(t):
    return t[0]

def simple_link(a,b):
    ra, xa, rg0a, rga = a
    rb, xb, rg0b, rgb = b
    assert ra == rb
    if xa > xb :
        return simple_link(b, a)
    return (ra+1, xa, rg0a, FunList.cons(b, rga))

    
def skew_link_A(a,b,top):
    ra, xa, rg0a, rga = a
    rb, xb, rg0b, rgb = b
    assert ra == rb
    return (ra+1, top, (), (a, b))
    
def skew_link_B(a,b,top):
    ra, xa, rg0a, rga = a
    rb, xb, rg0b, rgb = b
    assert ra == rb
    if xa > xb :
        return skew_link_B(b, a, top)
    return (ra+1, xa, FunList.cons(top, rg0a), FunList.cons(b, rga))


def skew_link(a,b,top):
    # 2 arbres
    ra, xa, rg0a, rga = a
    rb, xb, rg0b, rgb = b
    assert ra == rb
    if xa > xb :
        return skew_link(b, a, top)
    # xa <= xb
    if top <= xa :
        return skew_link_A(a, b, top)
    return skew_link_B(a, b, top)

def singleton(x):
    return (1, x, (), ())

def get_min(t):
    return t[1]