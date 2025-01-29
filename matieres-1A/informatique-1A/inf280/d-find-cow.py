s = input()
n = len(s)

l1, l2 = [], [] # indices des endroits avec 2 parentheses ouvrantes et ceux avec 2 fermantes

for i in range (n-1) :
    if s[i] == s[i+1] :
        if s[i] == '(' :
            l1.append(i)
        else :
            l2.append(i)

# trouver nombre de paires (i1, i2) avec i1 in l1 et i2 in l2 et i1 < i2
n1 = len(l1)
n2 = len(l2)

c = 0
j2 = 0
for i1 in l1 :
    while j2 < n2 and l2[j2] < i1 :
        j2 += 1
    c += (n2-j2)
print(c)