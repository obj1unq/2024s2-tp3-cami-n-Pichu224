object knightRider {
	method peso() {
	  return 500 
	}

	method nivelPeligrosidad() {
	 return 10 
	}

	method bulto() {
	  return 1
	}

	method reaccionar() {
	  //
	}
}

object bumblebee {
	var property transformacion = auto

	method peso() { 
	  return 800 
	}

	method nivelPeligrosidad() {
	  return transformacion.peligrosidad() 
	}

	method bulto() {
	  return 2
	}

	method reaccionar() {
	  transformacion = robot
	}
}
//
object auto {
  	method peligrosidad() {
	  return 15
  	}
}

object robot {
  	method peligrosidad() {
		return 30
 	}
}
//

object paqueteDeLadrillos {
  	var property cantidadDeLadrillos = 1

  	method peso() { 
	  return cantidadDeLadrillos * 2
	}

	method nivelPeligrosidad() {
	  return 2
	}

	method bulto() {
	  return if (cantidadDeLadrillos < 0 and cantidadDeLadrillos <= 100) 1
	  else if (cantidadDeLadrillos < 100 and cantidadDeLadrillos <= 300) 2
	  else 3
	}

	method reaccionar() {
	  cantidadDeLadrillos += 12
	}
}

object arenaAGranel {
	var property peso = 0
  	
	method nivelPeligrosidad() {
	  return 1
	}

	method bulto() {
	  return 1 
	}

	method reaccionar() {
	  peso += 20
	}
}

object bateriaAntiaerea {
	var property tieneMisiles = false

	method peso() { 
	  return if(tieneMisiles) 300 else 200
	}

	method nivelPeligrosidad() {
	  return if(tieneMisiles) 100 else 0
	}

	method bulto() {
	  return if (tieneMisiles) 2 else 1
	}

	method reaccionar() {
	  tieneMisiles = true 
	}
}

object contenedorPortuario {
	const property cosasDentro = #{}

	method peso() { 
	  return 100 + cosasDentro.sum({cosa => cosa.peso()})
	}

	method nivelPeligrosidad() {
	  return if(cosasDentro.isEmpty()) 0 else 
	  	cosasDentro.max({cosa => cosa.nivelPeligrosidad()})
	}

	method bulto() {
	  return 1 + cosasDentro.sum({cosa => cosa.bulto()})
	}

	method reaccionar() {
	  cosasDentro.forEach({cosa => cosa.reaccionar()}) 
	}
}

object residuosRadiactivos {
	var property peso = 0
  	
	method nivelPeligrosidad() {
	  return 200
	}

	method bulto() {
	  return 1 
	}

	method reaccionar() {
	  peso += 15 
	}
}

object embalajeDeSeguridad {
	var property cosaEnvuelta = null

	method peso() { 
	  return cosaEnvuelta.peso()
	}

	method nivelPeligrosidad() {
	  return cosaEnvuelta.nivelPeligrosidad() / 2
	}

	method bulto() {
	  return 2 
	}

	method reaccionar() {
	  // 
	}
}