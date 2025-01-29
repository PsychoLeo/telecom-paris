# Graphe bicolore

edges_color = {(0, 4): 'blue', (0, 5): 'blue', (0, 7): 'red', 
               (0, 8): 'red', (1, 5): 'blue', (1, 6): 'blue', 
               (2, 1): 'blue', (2, 3): 'blue', (2, 5): 'red', 
               (3, 4): 'blue', (4, 5): 'blue', (6, 7): 'blue', 
               (7, 8): 'red'}

color_max = {'blue': 4, 'red':4 }

# Graphe biparti

e1  = ('purple'  , 'triangle')
e2  = ('orange'  , 'star'    )
e3  = ('orange'  , 'triangle')
e4  = ('orange'  , 'circle'  )
e5  = ('green'   , 'triangle')
e6  = ('green'   , 'square'  )
e7  = ('yellow'  , 'disk'    )
e8  = ('yellow'  , 'hexagon' )
e9  = ('yellow'  , 'circle'  )
e10 = ('red'     , 'square'  )
e11 = ('blue'    , 'disk'    )

E = [e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11]

# Graph taken from the slides (p38)

antenna   = ('astronaut'   , 'builder'    )
chat      = ('policewoman' , 'judge'      )
dove      = ('farmer'      , 'builder'    )
fax       = ('judge'       , 'mechanic'   )
horse     = ('farmer'      , 'mechanic'   ) 
mail      = ('policewoman' , 'farmer'     )
pager     = ('builder'     , 'policewoman')
phone     = ('judge'       , 'builder'    )
sat       = ('astronaut'   , 'farmer'     )
telescope = ('astronaut'   , 'judge'      )
tower     = ('mechanic'    , 'policewoman')

network = { antenna, chat, dove, fax, horse, mail, pager, phone, sat, telescope, tower}
