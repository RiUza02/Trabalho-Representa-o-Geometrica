file = File.new "MARGO.txt", "a"

Dir.chdir "C:/Users/victo/Desktop"
file.puts
file.puts "____________________ORÇAMENTO TRELIÇA ROOM-IN-ATTIC____________________"
file.print "Comprimento: "
file.puts tl
file.print "Altura: "
file.puts h.to_m.round(2)
file.puts
file.print "Tipo da Madeira: "
file.puts tipoMadeira
file.print "Quantidade de Madeira: "
file.print totalMadeira.to_m.round(2)
file.puts " Metros"
file.puts
file.print "Preço Total: R$ "
file.print precoTotal.round(2)
file.puts
file.puts


file.close
