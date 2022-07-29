toolbar = UI::Toolbar.new "Treliça"
# This toolbar icon simply displays Hello World on the screen
cmd = UI::Command.new("Test") {
  def montaBarra(tamanho)
    ents = Sketchup.active_model.entities
    barra = ents.add_face [0, 0, 0], [11.cm, 0, 0], [11.cm, 5.cm, 0], [0, 5.cm, 0]
    barra.reverse!
    barra.pushpull tamanho
    barra = ents.add_group barra.all_connected
    return barra	
end

def giraBarra(barra, centro, eixo, angulo)
    ents =  Sketchup.active_model.entities
    tr = Geom::Transformation.new centro, eixo, angulo
    ents.transform_entities tr, barra 
    return barra
end

def movimentaBarra(barra , destino)
    ents =  Sketchup.active_model.entities
    t = Geom::Transformation.new destino
    ents.transform_entities t, barra 
    return barra
end

#Inicia as variavéis com os tamanhos parametrizados

#_____________________Interação com Ususário____________________________

prompts = ["Comprimento da Treliça"]
defaults = [11.25.m,]
input = UI.inputbox prompts, defaults, "Insira os parâmetros da Treliça:"

tl, = input

while( tl < 6.m || tl > 11.25.m)

UI.messagebox "Fora dos Limites"


prompts = ["Comprimento da Treliça"]
defaults = [11.25.m,]
input = UI.inputbox prompts, defaults, "Insira os parâmetros da Treliaça:"
tl, = input

end

#_______________________________________________________________________

ents = Sketchup.active_model.entities
b_grande   = (10   / 22.5) * tl
b_pequeno  = (3    / 22.5) * tl
diagonal_1 = (3.6  / 22.5) * tl
diagonal_2 = (4.2  / 22.5) * tl
diagonal_3 = (1    / 22.5) * tl
diagonal_4 = (5.8  / 22.5) * tl
interior_1 = (2.5  / 22.5) * tl
interior_2 = (5.5    / 22.5) * tl
interior_3 = (4    / 22.5) * tl
interior_4 = (4.25 / 22.5) * tl
interior_5 = (3.9  / 22.5) * tl
h = (10.5 / 22.5) * tl

#________________________________PARTE INFERIOR_____________________

#Cria a barra grande
b_b_g = montaBarra(b_grande)

#coloca no lugar
b_b_g = giraBarra(b_b_g, [0,0,0], [0,1,0], 90.degrees)
b_b_g = movimentaBarra(b_b_g, [(-b_grande/2),0,11.cm])

#cria um barra pequena
b_b_p = montaBarra(b_pequeno)

#coloca no lugar
b_b_p = giraBarra(b_b_p, [0,0,0], [0,1,0], -90.degrees)
b_b_p = movimentaBarra(b_b_p, [(-b_grande/2-11.cm),0,0])

#faz copia da barra pequena e coloca no lugar
group2 = b_b_p.copy
group2 = movimentaBarra(group2, [(-b_pequeno-11.cm),0,0])

#faz copia da barra pequena e coloca no lugar
group3 = b_b_p.copy
group3 = movimentaBarra(group3, [(b_grande+b_pequeno+22.cm),0,0])

#faz copia da barra pequena e coloca no lugar
group4 = b_b_p.copy
group4 = movimentaBarra(group4, [(b_grande+b_pequeno+b_pequeno+33.cm),0,0])

#_______________________DIAGONAIS____________________________________


tamtot = b_grande + 4 * b_pequeno + 44.cm #tamanho total
f = b_grande / 2 + b_pequeno + b_pequeno + 22.cm #metade do tamanho total

#Cria primeira parte da diagonal esquerda
d1 = montaBarra(diagonal_1)

#coloca no lugar
d1 = movimentaBarra(d1, [-f,0,11.cm])

#Cria segunda parte da diagonal esquerda
d2 = montaBarra(diagonal_2)

#coloca no lugar
d2 = movimentaBarra(d2, [-f,0,diagonal_1+11.cm+11.cm])

#Cria terceira parte da diagonal esquerda
d3 = montaBarra(diagonal_3) 

#coloca no lugar
d3 = movimentaBarra(d3, [-f,0,diagonal_1+diagonal_2+11.cm+2*11.cm])

#Cria 4º parte da diagonal esquerda
d4 = montaBarra(diagonal_4) 

#coloca no lugar
d4 = movimentaBarra(d4, [-f,0,diagonal_1+diagonal_2+diagonal_3+11.cm+3*11.cm])

#cria grupo Diagonal Esquerda
model = Sketchup.active_model
entities = model.active_entities
ladoE = entities.add_group(d1,d2,d3,d4)

#Copia a Diagonal Esquerda
ladoD = ladoE.copy

#Rotaciona a Diagonal Esquerda
ladoE = giraBarra(ladoE, [-f+11.cm,0,11.cm], [0,1,0], 47.1.degrees)

#Move a copia da Diagonal Esquerda para a Direita e Rotaciona
ladoD = movimentaBarra(ladoD, [(tamtot-11.cm),0,0])
ladoD = giraBarra(ladoD, [f-11.cm,0,11.cm], [0,1,0], -47.1.degrees)

#______________________INTERIOR_____________________________________
#Cria uma barra interior pequena e faz uma copia
int1 =  montaBarra(interior_1)
int2 = int1.copy

#Coloca a primeira no lugar
int1 = movimentaBarra(int1, [-b_grande/2-22.cm-b_pequeno,0,11.cm])

#coloca a segunda no lugar
int2 = movimentaBarra(int2, [b_grande/2+11.cm+b_pequeno,0,11.cm])

#Cria um barra interior grande e faz uma copia
int3 = montaBarra(interior_2)
int4 = int3.copy

#Coloca a primeira no lugar
int3 = movimentaBarra(int3, [-b_grande/2-11.cm,0,11.cm])

#Coloca a segunda no lugar
int4 = movimentaBarra(int4, [b_grande/2,0,11.cm])

#Cria a barra interior do alto
int5 = montaBarra(interior_3)

#Coloca no lugar
int5 = movimentaBarra(int5, [-11.cm/2,0,h-interior_3])

#Cria uma barra interior horizontal e faz  uma copia
int6 = montaBarra(interior_4)
int7 = int6.copy

#Coloca a primeira no lugar
int6 = giraBarra(int6, [0,0,0], [0,1,0], -90.degrees)
int6 = movimentaBarra(int6, [-11.cm/2,0,h-interior_3-11.cm])

#Coloca a segunda no lugar
int7 = giraBarra(int7, [0,0,0], [0,1,0], 90.degrees)
int7 = movimentaBarra(int7, [11.cm/2,0,h-interior_3])

#Cria uma barra interior diagonal e faz  uma copia
int8 = montaBarra(interior_5)
int9 = int8.copy

#coloca a primeira no lugar
int8 = giraBarra(int8, [0,0,0], [0,1,0], -51.1.degrees )
int8 = movimentaBarra(int8, [-b_grande/2-11.cm,0,11.cm])

#coloca a segunda no lugar
int9 = giraBarra(int9, [11.cm,0,0], [0,1,0], 51.1.degrees)
int9 = movimentaBarra(int9, [b_grande/2,0,11.cm])

treliça_final = entities.add_group b_b_g , b_b_p , group2 , group3 , group4,
ladoD , ladoE , int1 , int2 , int3 , int4 , int5 , int6 , int7 , int8 ,  int9
}
#cmd.small_icon = "ToolPencilSmall.png"
#cmd.large_icon = "ToolPencilLarge.png"
cmd.tooltip = "Treliça"
cmd.status_bar_text = "Monta uma Treliça do tipo Room-in-Attic"
cmd.menu_text = "Treliça"
toolbar = toolbar.add_item cmd
toolbar.show
