# Hydroélectricité :
k, n = list(map(int, input().split()))
force_courant = list(map(int, input().split()))

# Plus long palindrome
s = input()

# Block sequence
t = int(input())
for i in range (t) :
    n = int(input())
    a = list(map(int, input().split()))

# LASTDIG : the last digit
t = int(input())
for i in range (t) :
    a, b = list(map(int, input().split()))

# Pour accélérer la lecture de l'entrée :
import sys
input = sys.stdin.readline


# Hydroélectricité :
k, n = list(map(int, input().split()))
force_courant = list(map(int, input().split()))

'''
input() -> "3 9" # lit la ligne 
input().split() -> ["3", "9"] # par défaut .split() sépare le str à l'espace
map(int, input().split()) -> iterateur(3, 9) # map renvoie un itérateur 
list(map(int, input().split())) -> [3, 9] # on convertit cet itérateur en liste
k, n = list(map(int, input().split())) # associe k->3 et n->9

input() -> "3 2 5 7 4 2 3 8 4"
input().split() -> ["3", "2", "5", "7", "4", "2", "3", "8", "4"]
map(int, input().split()) -> itérateur(3, 2, 5, 7, 4, 2, 3, 8)
list(map(int, input().split())) -> [3, 2, 5, 7, 4, 2, 3, 8]
'''

