    def montaBarra(tamanho)
        ents = Sketchup.active_model.entities
        barra = ents.add_face [0, 0, 0], [11.cm, 0, 0], [11.cm, 5.cm, 0], [0, 5.cm, 0]
        barra.reverse!
        barra.pushpull tamanho
        barra = ents.add_group barra.all_connected
        return barra	
    end

    def gira(barra, centro, eixo, angulo)
        ents =  Sketchup.active_model.entities
        tr = Geom::Transformation.new centro, eixo, angulo
        ents.transform_entities tr, barra 
        return barra
    end

    def movimenta(barra , destino)
        ents =  Sketchup.active_model.entities
        t = Geom::Transformation.new destino
        ents.transform_entities t, barra 
        return barra
    end

    def criaNo()
        model = Sketchup.active_model
        ents = model.active_entities
                no1 = ents.add_face [26.cm, -1.cm, -10.cm], [-26.cm, -1.cm, -10.cm], [-26.cm, 0, -10.cm], [26.cm, 0, -10.cm]
                no2 = ents.add_face [26.cm, 6.cm, -10.cm], [-26.cm, 6.cm, -10.cm], [-26.cm, 5.cm, -10.cm], [26.cm, 5.cm, -10.cm]
                no1.reverse!
                no1.pushpull 31.cm
                no2.pushpull 31.cm  
                no1 = ents.add_group no1.all_connected
                no2 = ents.add_group no2.all_connected
                no = ents.add_group no1, no2
                return no
    end
        
        tl = 6.m
        espacamento = 11.cm
        ents = Sketchup.active_model.entities
        b_grande   = (10   / 22.5) * tl #1
        b_pequeno  = (3    / 22.5) * tl #4
        diagonal_1 = (3.8  / 22.5) * tl #2
        diagonal_2 = (4.1  / 22.5) * tl #2
        diagonal_3 = (0.7  / 22.5) * tl #2
        diagonal_4 = (6  / 22.5) * tl #2
        interior_1 = (2.5  / 22.5) * tl #2
        interior_2 = (5.66  / 22.5) * tl #2
        interior_3 = (4    / 22.5) * tl #1  
        interior_4 = (4.4 / 22.5) * tl #2
        interior_5 = (3.9  / 22.5) * tl #2
        h = (10.5 / 22.5) * tl


        #________________________________PARTE INFERIOR_____________________

        #Cria a barra grande
        b_b_g = montaBarra(b_grande)

        #coloca no lugar
        b_b_g = gira(b_b_g, [0, 0, 0], [0, 1, 0], 90.degrees)
        b_b_g = movimenta(b_b_g, [(-b_grande/2), 0, 11.cm])

        #cria um barra pequena
        b_b_p = montaBarra(b_pequeno)

        #coloca no lugar
        b_b_p = gira(b_b_p, [0, 0, 0], [0, 1, 0], -90.degrees)
        b_b_p = movimenta(b_b_p, [(-b_grande/2 - espacamento), 0, 0])

        #faz copia da barra pequena e coloca no lugar
        group2 = b_b_p.copy
        group2 = movimenta(group2, [(-b_pequeno - espacamento), 0, 0])

        #faz copia da barra pequena e coloca no lugar
        group3 = b_b_p.copy
        group3 = movimenta(group3, [(b_grande + b_pequeno + 2*espacamento), 0, 0])

        #faz copia da barra pequena e coloca no lugar
        group4 = b_b_p.copy
        group4 = movimenta(group4, [(b_grande + 2*b_pequeno + 3*espacamento), 0, 0])

        #cria no
        no1 = criaNo()
        no1 = movimenta(no1, [(-b_grande/2) - espacamento/2,0,0])
        no2 = criaNo()
        no2 = movimenta(no2, [(b_grande/2) + espacamento/2,0,0])
        no3 = criaNo()
        no3 = movimenta(no3, [(b_grande/2 + b_pequeno) + (3*espacamento/2),0,0])
        no4 = criaNo()
        no4 = movimenta(no4, [-(b_grande/2 + b_pequeno) - (3*espacamento/2),0,0])
        #_______________________DIAGONAIS____________________________________


        tamtot = b_grande + 4*b_pequeno + 4*espacamento #tamanho total
        f = b_grande/2 + 2*b_pequeno + 2*espacamento #metade do tamanho total

        #Cria primeira parte da diagonal esquerda
        d1 = montaBarra(diagonal_1)

        #coloca no lugar
        d1 = movimenta(d1, [-f, 0, 11.cm])

        #Cria segunda parte da diagonal esquerda
        d2 = montaBarra(diagonal_2)

        #coloca no lugar
        d2 = movimenta(d2, [-f, 0, diagonal_1 + 11.cm + espacamento])

        #Cria terceira parte da diagonal esquerda
        d3 = montaBarra(diagonal_3) 

        #coloca no lugar
        d3 = movimenta(d3, [-f, 0, diagonal_1 + diagonal_2 + 11.cm + 2*espacamento])

        #Cria 4º parte da diagonal esquerda
        d4 = montaBarra(diagonal_4) 

        #coloca no lugar
        d4 = movimenta(d4, [-f, 0, diagonal_1 + diagonal_2 + diagonal_3 + 11.cm + 3*espacamento])

        #cria no
        no5 = criaNo()
        no5 = movimenta(no5, [-f + espacamento/2, 0, 0])
        no6 = criaNo()
        no6 = movimenta(no6, [+f - espacamento/2, 0, 0])
        no7 = criaNo()
        no7 = movimenta(no7, [-f + espacamento/2 , 0, diagonal_1 + espacamento])
        no8 = criaNo()
        no8 = movimenta(no8, [-f + espacamento/2 , 0, diagonal_1 + diagonal_2 + 2*espacamento])
        no9 = criaNo()
        no9 = movimenta(no9, [-f + espacamento/2 , 0, diagonal_1 + diagonal_2 + diagonal_3 + 3*espacamento])

        #cria grupo Diagonal Esquerda
        model = Sketchup.active_model
        entities = model.active_entities
        ladoE = entities.add_group(d1, d2, d3, d4, no7, no8, no9)    

        #Copia a Diagonal Esquerda
        ladoD = ladoE.copy

        Math.cos(47.1.degrees)
        #Rotaciona a Diagonal Esquerda
        ladoE = gira(ladoE, [-f + 11.cm, 0, 11.cm], [0, 1, 0], 47.1.degrees)

        #Move a copia da Diagonal Esquerda para a Direita e Rotaciona
        ladoD = movimenta(ladoD, [(tamtot - 11.cm), 0, 0])
        ladoD = gira(ladoD, [f - 11.cm, 0, 11.cm], [0, 1, 0], -47.1.degrees)

        #______________________INTERIOR_____________________________________
        #Cria uma barra interior pequena e faz uma copia
        int1 =  montaBarra(interior_1)
        int2 = int1.copy

        #Coloca a primeira no lugar
        int1 = movimenta(int1, [-b_grande/2 - b_pequeno - 2*espacamento, 0, 11.cm])

        #coloca a segunda no lugar
        int2 = movimenta(int2, [b_grande/2 + b_pequeno + espacamento, 0, 11.cm])

        #Cria um barra interior grande e faz uma copia
        int3 = montaBarra(interior_2)
        int4 = int3.copy

        #Coloca a primeira no lugar
        int3 = movimenta(int3, [-b_grande/2 - espacamento, 0, espacamento])

        #Coloca a segunda no lugar
        int4 = movimenta(int4, [b_grande/2, 0, espacamento])

        #Cria a barra interior do alto
        int5 = montaBarra(interior_3)

        #Coloca no lugar
        int5 = movimenta(int5, [-espacamento/2, 0, h - interior_3])

        #Cria uma barra interior horizontal e faz  uma copia
        int6 = montaBarra(interior_4)
        int7 = int6.copy

        #Coloca a primeira no lugar
        int6 = gira(int6, [0, 0, 0], [0, 1, 0], -90.degrees)
        int6 = movimenta(int6, [-espacamento/2 ,0 ,h - interior_3 - espacamento])

        #Coloca a segunda no lugar
        int7 = gira(int7, [0, 0, 0], [0, 1, 0], 90.degrees)
        int7 = movimenta(int7, [espacamento/2 , 0, h - interior_3])

        #Cria uma barra interior diagonal e faz  uma copia
        int8 = montaBarra(interior_5)
        int9 = int8.copy

        #coloca a primeira no lugar
        int8 = gira(int8, [0, 0, 0], [0, 1, 0], -51.1.degrees )
        int8 = movimenta(int8, [-b_grande/2 - espacamento, 0, espacamento])

        #coloca a segunda no lugar
        int9 = gira(int9, [espacamento, 0, 0], [0, 1, 0], 51.1.degrees)
        int9 = movimenta(int9, [b_grande/2 , 0, espacamento])

        #cria no
        no10 = criaNo()
        no10 = movimenta(no10, [0, 0, h - interior_3 - espacamento])
        no11 = criaNo()
        no11 = movimenta(no11, [0, 0, h])

        treliça_final = entities.add_group b_b_g , b_b_p , group2 , group3 , group4,
        ladoD , ladoE , int1 , int2 , int3 , int4 , int5 , int6 , int7 , int8 ,  int9, no1,
        no2, no3, no4, no5, no6, no10, no11

        totalMadeira = b_grande + 4 * b_pequeno + 2 * (diagonal_1 + diagonal_2 + diagonal_3 + diagonal_4) + 2 * (interior_1 + interior_2 + interior_4 + interior_5) + interior_3
