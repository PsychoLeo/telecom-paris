import FunList

label = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
]

neighbors = [
    [1],
    [2, 5],
    [],
    [6],
    [6],
    [7,8],
    [8],
    [9, 10],
    [11, 12],
    [],
    [],
    [],
    []    
]

output_content = []
def output(x):
    output_content.append(x)

def do_enumeration(enum_fun, in_order = False):
    global output_content
    for n in range(len(neighbors)):
        output_content = []
        enum_fun(n)
        if in_order:
            output_content.sort()
        res = ", ".join(map(str,output_content))
        print(f"Enum from {n}: {res}")
        
def enumerate_node_dfs(node):
    output(node)
    for nxt in neighbors[node]:
        enumerate_node_dfs(nxt)

def enumerate_node_stack(node):
    stack = [node]
    while stack :
        v = stack.pop()
        output(v)
        for nxt in neighbors[v] :
            stack.append(nxt)

def enumerate_leaf_dfs(node):
    if neighbors[node] == [] :
        output(node)
    for nxt in neighbors[node] :
        enumerate_leaf_dfs(nxt)

def enumerate_leaf_stack(node) :
    stack = [node]
    while stack :
        v = stack.pop()
        if neighbors[v] == [] :
            output(v)
        for nxt in neighbors[v] :
            stack.append(nxt)
    
def preprocess_leaf_enumeration():
    pass

def enumerate_leaf_fast(node):
    pass

def enumerate_path_dfs(node):
    pass

def preprocess_path_enumeration():
    pass

def enumerate_path_fast(node):
    pass
        
print(" === ENUMERATION WITH DFS === ")    
do_enumeration(enumerate_node_dfs, in_order = True) # le paramètre in_order
# permet d'afficher les noeuds énumérés dans l'ordre des entiers, sinon
# c'est dans l'ordre d'énumération
print("\n"*3)

print(" === ENUMERATION WITH DFS STACK === ")    
do_enumeration(enumerate_node_stack)
print("\n"*3)

print(" === ENUMERATING LEAVES WITH DFS === ")    
do_enumeration(enumerate_leaf_dfs)
print("\n"*3)

print(" === ENUMERATING LEAVES WITH STACK === ")    
do_enumeration(enumerate_leaf_stack)
print("\n"*3)

print(" === ENUMERATING LEAVES WITH FAST ALGORITHM === ")
preprocess_leaf_enumeration()
do_enumeration(enumerate_leaf_fast)
print("\n"*3)



print(" === ENUMERATING PATH WITH DFS ALGORITHM === ")

do_enumeration(enumerate_path_dfs)
print("\n"*3)

print(" === ENUMERATING PATH WITH FAST ALGORITHM === ")
preprocess_path_enumeration()
do_enumeration(enumerate_path_fast)
print("\n"*3)


