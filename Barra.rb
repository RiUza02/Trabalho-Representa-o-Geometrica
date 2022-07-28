	class Barra
		attr_accessor :comprimento

		def initialize (comprimento)
			@comprimento = comprimento
		end
		# Monta a barra
		def monta()
			ents =  Sketchup.active_model.entities
			barra = ents.add_face [0, 0, 0], [11.cm, 0, 0], [11.cm, 5.cm, 0], [0, 5.cm, 0]
			barra.pushpull comprimento
			grupo_barra = ents.add_group barra.all_connected
			return grupo_barra	
		end

		#returna o comprimento da barra
		def getComprimento()
			return comprimento
		end	
	end