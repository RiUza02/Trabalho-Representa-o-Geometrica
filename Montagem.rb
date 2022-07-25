#Inicia as variavéis com os tamanhos parametrizados

ents = Sketchup.active_model.entities
tl          = 11.25.m
b_grande   = (10   / 22.5) * tl
b_pequeno  = (3    / 22.5) * tl
diagonal_1 = (3.6  / 22.5) * tl
diagonal_2 = (4.2  / 22.5) * tl
diagonal_3 = (1    / 22.5) * tl
diagonal_4 = (5.8  / 22.5) * tl
interior_1 = (2.5  / 22.5) * tl
interior_2 = (5    / 22.5) * tl
interior_3 = (4    / 22.5) * tl
interior_4 = (4.25 / 22.5) * tl
interior_5 = (3.9  / 22.5) * tl
h = (10.5 / 22.5) * tl


#________________________________PARTE INFERIOR_____________________

#Cria a barra grande
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]

sec.reverse!
sec.pushpull b_grande

b_b_g = ents.add_group sec.all_connected

#coloca no lugar
tr = Geom::Transformation.new [0,0,0], [0,1,0], 90.degrees
t  = Geom::Transformation.new [(-b_grande/2),0,11.cm]
ents.transform_entities t*tr, b_b_g

#cria um barra pequena
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]

sec.reverse!
sec.pushpull b_pequeno
b_b_p = ents.add_group sec.all_connected
#coloca no lugar
tr = Geom::Transformation.new [0,0,0], [0,1,0], -90.degrees
t  = Geom::Transformation.new [(-b_grande/2-11.cm),0,0]
ents.transform_entities t*tr, b_b_p

#faz copia da barra pequena e coloca no lugar
group2 = b_b_p.copy
t  = Geom::Transformation.new [(-b_pequeno-11.cm),0,0]
ents.transform_entities t, group2

#faz copia da barra pequena e coloca no lugar
group3 = b_b_p.copy
t  = Geom::Transformation.new [(b_grande+b_pequeno+22.cm),0,0]
ents.transform_entities t, group3

#faz copia da barra pequena e coloca no lugar
group4 = b_b_p.copy
t  = Geom::Transformation.new [(b_grande+b_pequeno+b_pequeno+33.cm),0,0]
ents.transform_entities t, group4

#_______________________DIAGONAIS____________________________________


tamtot = b_grande + 4 * b_pequeno + 44.cm #tamanho total
f = b_grande / 2 + b_pequeno + b_pequeno + 22.cm #metade do tamanho total

#Cria primeira parte da diagonal esquerda
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]
sec.reverse!
sec.pushpull diagonal_1
d1 = ents.add_group sec.all_connected
#coloca no lugar
t = Geom::Transformation.new [-f,0,11.cm]
ents.transform_entities t, d1

#seção 11x5
#Cria segunda parte da diagonal esquerda
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]
sec.reverse!
sec.pushpull diagonal_2
d2 = ents.add_group sec.all_connected
#coloca no lugar
t = Geom::Transformation.new [-f,0,diagonal_1+11.cm+11.cm]
ents.transform_entities t, d2

#Cria 3º parte da diagonal esquerda
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]
sec.reverse!
sec.pushpull diagonal_3
d3 = ents.add_group sec.all_connected
#coloca no lugar
t = Geom::Transformation.new [-f,0,diagonal_1+diagonal_2+11.cm+2*11.cm]
ents.transform_entities t, d3

#Cria 4º parte da diagonal esquerda
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]
sec.reverse!
sec.pushpull diagonal_4
d4 = ents.add_group sec.all_connected
#coloca no lugar
t = Geom::Transformation.new [-f,0,diagonal_1+diagonal_2+diagonal_3+11.cm+3*11.cm]
ents.transform_entities t, d4

#cria grupo Diagonal Esquerda
model = Sketchup.active_model
entities = model.active_entities
ladoE = entities.add_group(d1,d2,d3,d4)

#Copia a Diagonal Esquerda
ladoD = ladoE.copy

#Rotaciona a Diagonal Esquerda
tr = Geom::Transformation.new [-f+11.cm,0,11.cm], [0,1,0], 47.1.degrees
ents.transform_entities tr, ladoE

#Move a copia da Diagonal Esquerda para a Direita e Rotaciona
t = Geom::Transformation.new [(tamtot-11.cm),0,0]
tr = Geom::Transformation.new [f-11.cm,0,11.cm], [0,1,0], -47.1.degrees
ents.transform_entities t, ladoD
ents.transform_entities tr, ladoD

#______________________INTERIOR_____________________________________
#Cria uma barra interior pequena e faz uma copia
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]

sec.reverse!
sec.pushpull interior_1
int1 = ents.add_group sec.all_connected
int2 = int1.copy
#Coloca a primeira no lugar
t = Geom::Transformation.new [-b_grande/2-22.cm-b_pequeno,0,11.cm]
ents.transform_entities t, int1
#coloca a segunda no lugar
t = Geom::Transformation.new [b_grande/2+11.cm+b_pequeno,0,11.cm]
ents.transform_entities t, int2

#Cria um barra interior grande e faz uma copia
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]

sec.reverse!
sec.pushpull interior_2
int3 = ents.add_group sec.all_connected
int4 = int3.copy
#Coloca a primeira no lugar
t = Geom::Transformation.new [-b_grande/2-11.cm,0,11.cm]
ents.transform_entities t, int3
#Coloca a segunda no lugar
t = Geom::Transformation.new [b_grande/2,0,11.cm]
ents.transform_entities t, int4

#Cria a barra interior do alto
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]

sec.reverse!
sec.pushpull interior_3
int5 = ents.add_group sec.all_connected
#Coloca no lugar
t = Geom::Transformation.new [-11.cm/2,0,h-interior_3]
ents.transform_entities t, int5

#Cria uma barra interior horizontal e faz  uma copia
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]

sec.reverse!
sec.pushpull interior_4
int6 = ents.add_group sec.all_connected
int7 = int6.copy
#Coloca a primeira no lugar
t = Geom::Transformation.new [-11.cm/2,0,h-interior_3-11.cm]
tr = Geom::Transformation.new [0,0,0], [0,1,0], -90.degrees 
ents.transform_entities t*tr, int6
#Coloca a segunda no lugar
t = Geom::Transformation.new [11.cm/2,0,h-interior_3]
tr = Geom::Transformation.new [0,0,0], [0,1,0], 90.degrees
ents.transform_entities t*tr, int7

#Cria uma barra interior diagonal e faz  uma copia
#seção 11x5
sec = ents.add_face [0,0,0],
[11.cm,0,0],
[11.cm,5.cm,0], 
[0,5.cm,0]

sec.reverse!
sec.pushpull interior_5
int8 = ents.add_group sec.all_connected
int9 = int8.copy
#coloca a primeira no lugar
t = Geom::Transformation.new [-b_grande/2-11.cm,0,11.cm]
tr = Geom::Transformation.new [0,0,0], [0,1,0], -51.1.degrees 
ents.transform_entities t*tr, int8
#coloca a segunda no lugar
t = Geom::Transformation.new [b_grande/2,0,11.cm]
tr = Geom::Transformation.new [11.cm,0,0], [0,1,0], 51.1.degrees
ents.transform_entities t*tr, int9
