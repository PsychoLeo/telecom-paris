import matroid as mtr
from examples import *

M0 = mtr.Matroid()

M1 = mtr.GraphicMatroid([(1,2),(2,3),(3,1)])
M2 = mtr.PartitionMatroid({(1,2):'red',(2,3):'red',(3,1):'blue'}, {'red':1, 'blue':1})

#mtr.intersection(M1, M2)
