import cosas.*

object camion {
	const property cosas = #{}
		
	method cargar(unaCosa) {
		unaCosa.reaccionar()
		cosas.add(unaCosa)
	}

	method descargar(unaCosa) {
		cosas.remove(unaCosa)
	}

	method todoPesoPar() {
	  return cosas.all({cosa => self.pesoEsPar(cosa)})
	}
	//
	method pesoEsPar(cosa) {
	 return (cosa.peso() % 2) == 0
	}
	//

	method hayAlgunoQuePesa(peso) {
	  return cosas.any({cosa => cosa.peso() == peso})
	}

	method elDeNivel(nivel) {
	  return cosas.findOrDefault(
		{cosa => cosa.nivelPeligrosidad() == nivel}, null)
	}

	method pesoTotal() {
	  return 1000 + cosas.sum({cosa => cosa.peso()})
	}

	method excedidoDePeso() {
	  return self.pesoTotal() > 2500
	}

	method objetosQueSuperanPeligrosidad(nivel) {
	  return cosas.filter(
		{cosa => cosa.nivelPeligrosidad() > nivel})
	}

	method objetosMasPeligrososQue(cosa) {
	  return cosas.filter(
		{objeto =>
			 objeto.nivelPeligrosidad() > cosa.nivelPeligrosidad()})
	}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
	  return not self.excedidoDePeso() and
	  	cosas.all(
			{cosa => cosa.nivelPeligrosidad() < nivelMaximoPeligrosidad})
	}

	method tieneAlgoQuePesaEntre(min, max) {
	  return cosas.any({cosa => cosa.peso() > min and cosa.peso() < max})
	}

	method cosaMasPesada() {
	  return cosas.max({cosa => cosa.peso()})
	}

	method pesos() {
	  return cosas.map({cosa => cosa.peso()})
	}

	method totalBultos() {
	  return cosas.sum({cosa => cosa.bulto()})
	}

	method transportar(destino, camino) {
	  self.validarTransporte(destino, camino)
	  destino.almacenarCosas(cosas)
	  cosas.clear()
	}
	
	method validarTransporte(destino, camino) {
	  if (not self.condicionesParaTransportar(destino, camino)) {
		self.error("No se cumplen las condiciones para poder transportar")
	  }
	}

	method condicionesParaTransportar(destino, camino) {
	  return not self.excedidoDePeso() and
	  			self.totalBultos() <= destino.bultosAdmitidos() and
					camino.validarPaso(self)
	}
}
 //  puedeCircularEnRuta //
object ruta9 {
  	const property nivelDePeligrosidad = 40

	method validarPaso(vehiculo) {
	  return vehiculo.puedeCircularEnRuta(nivelDePeligrosidad)
	}
}

object caminosVecinales {
  	var property pesoAdmitible = 1500

 	method validarPaso(vehiculo) {
	  return vehiculo.pesoTotal() < pesoAdmitible
	}
}

object almacen {
	var property maximoBultos = 3
  	const property cosasAlmacenadas = #{}

   method almacenarCosas(cosasALmacenar) {
	 cosasAlmacenadas.addAll(cosasALmacenar)
   }

   method bultosAdmitidos() {
	 return maximoBultos - cosasAlmacenadas.sum({cosa => cosa.bulto()}) 
   }
}

