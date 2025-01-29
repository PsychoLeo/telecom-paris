import FunList

def test_FunList():

    a = [FunList.empty]
    for x in range(100):
        a.append(FunList.cons(x,a[-1]))

    # a contient Empty, [0], [1,0], ... [99,...0]

    cutOff = len(a) # 101
    assert(cutOff == 101)

    for i in range(100):
        a.append(FunList.cons(i*100,a[1+i]))

    for i in range(100):
        a.append(FunList.cons(i*10000,a[i+cutOff]))

    for i in range(100):
        a.append(FunList.cons(i*1000000,FunList.tail(a[i+cutOff])))
        
    for i in range(100):
        assert( FunList.size(a[i]) == i )
        assert( FunList.head(a[i+1]) == i )
        assert( FunList.head(a[i+cutOff+100]) == i*10000 )
        assert( FunList.head(FunList.tail(a[i+cutOff+100])) == i*100 )
        assert( FunList.head(FunList.tail(FunList.tail(a[i+cutOff+100]))) == i )
        assert( FunList.head(FunList.tail(a[i+cutOff])) == i )
        assert( FunList.head(FunList.tail(a[i+cutOff+100])) == i*100 )
        assert( FunList.head(a[i+cutOff+200]) == i*1000000 )
        assert( FunList.head(FunList.tail(a[i+cutOff+200])) == i )
