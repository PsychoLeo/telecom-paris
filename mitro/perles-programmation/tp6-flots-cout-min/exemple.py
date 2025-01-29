
# Données exemple de graphe

u = { ("A","B"):6, ("A","D"):1, ("A","E"):6, ("B","C"):7,
      ("B","D"):8, ("C","F"):9, ("D","C"):2, ("D","G"):1,
      ("D","E"):6, ("D","H"):3, ("E","H"):9, ("F","D"):2,
      ("G","F"):2, ("H","G"):8}

b = { "A":12, "B":8, "C":0, "D":0, "E":0, "F":-9, "G":-6, "H":-5 }

c = { ("A","B"):-1, ("A","D"): 2, ("A","E"): 1, ("B","C"): 0,
      ("B","D"): 1, ("C","F"): 3, ("D","C"):-1, ("D","G"): 3,
      ("D","E"): 0, ("D","H"): 0, ("E","H"): 0, ("F","D"):-4,
      ("G","F"): 9, ("H","G"):-1}

f = { ("A","B"):5, ("A","D"):1, ("A","E"):6, ("B","C"):7,
      ("B","D"):6, ("C","F"):8, ("D","C"):1, ("D","G"):1,
      ("D","E"):3, ("D","H"):2, ("E","H"):9, ("F","D"):0,
      ("G","F"):1, ("H","G"):6}

'''
# Données péniche sur le Rhin #
###############################

# Conteneurs en attente de voyage
b = { ("Bale"       , "Strasbourg") :  2, 
      ("Bale"       , "Mayence"   ) :  4,
      ("Bale"       , "Cologne"   ) :  1,
      ("Bale"       , "Rotterdam" ) :  5,
      ("Strasbourg" , "Mayence"   ) :  1,
      ("Strasbourg" , "Cologne"   ) :  7,
      ("Strasbourg" , "Rotterdam" ) : 11,
      ("Mayence"    , "Cologne"   ) :  2,
      ("Mayence"    , "Rotterdam" ) : 10,
      ("Cologne"    , "Rotterdam" ) :  3
}

# Profit par route
b = { ("Bale"       , "Strasbourg") :  3, 
      ("Bale"       , "Mayence"   ) :  4,
      ("Bale"       , "Cologne"   ) :  8,
      ("Bale"       , "Rotterdam" ) : 10,
      ("Strasbourg" , "Mayence"   ) :  2,
      ("Strasbourg" , "Cologne"   ) :  5,
      ("Strasbourg" , "Rotterdam" ) :  9,
      ("Mayence"    , "Cologne"   ) :  1,
      ("Mayence"    , "Rotterdam" ) :  6,
      ("Cologne"    , "Rotterdam" ) :  3
}


# Données Relais nage #
#######################

nageurs = ["Aya", "Badri", "Come", "Dalia", "Erynn"]
nages   = ["Dos", "Brasse", "Papillon", "Libre"]

temps = [ [37.7, 32.9, 33.8, 37.0, 35.4],
          [43.4, 33.1, 42.2, 34.7, 41.8],
          [33.3, 28.5, 38.9, 30.4, 33.6],
          [29.2, 26.4, 29.6, 28.5, 31.1]         
         ]

'''