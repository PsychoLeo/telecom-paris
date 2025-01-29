# List datastructure
empty = object()


def size(l):
    if l == empty:
        return 0
    else:
        return l[1]

# take an object x and a list l return the list containing
#  x followed by the rest of l
def cons(x, l):
    return (x,size(l)+1,l)

# take a list and returns the first integers
def head(l):
    return l[0]

# take a list and returns the tail
def tail(l):
    return l[2]


def rev(l, into=empty):
    if l == empty:
        return into
    else:
        return rev(tail(l),cons(head(l),into))

