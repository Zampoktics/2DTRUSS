                                 ----------------------------------INPUT--------------------------------------------
              

[x1 y1 x2 y2 x3 y3 x4 y4 so on...] using this pattern for dof and extf(nd) to enter index(remember in matlab index start from 1)


node- Give the co-ordinates of the nodes in the form of a vector 
       e.g.[x1 y1;x2 y2;x3 y3;so on...]

conn- This states the connection of the trusses i.e. the connection of the nodes by the trusses
       e.g.[n1 n2;n3 n4;so on.....]
       where, n1 is starting node and n2 end node of member 1 similarly for other members;

A-    Area of cross section of members

E-    Modulus of elasticity of members

dof-  This state the degree of freedom of nodes(Input in form of array)(enter index in which nodes free to move acc. to above pattern)
      e.g. if  y1,x2,y2,y3,x4,y4,x6 are free to move then input is: [2 3 4 6 7 8 11] i.e in input give which are free to move

extf- Enter no. of external loads (this will start for loop under which enter external load and corresponding index)

force- Enter external load 

nd(at node(with direction))- Enter index for force using above pattern  
  