class Prenda {
  const property tipo
  var property estado
  var property precioBase
  
  method precio() = self.precioBase() - estado.modificacion(self.precioBase())
  
}

class Nueva {
  method modificacion(precioBase) = 0
}

class Promocion {
  const property valor
  
  method modificacion(precioBase) = self.valor().min(precioBase)
}

class Liquidacion {
  method modificacion(precioBase) = precioBase * 0.5
}

class PrendaConCantidad {
  const property prenda
  const property cantidad

  method total() = self.prenda().precio() * self.cantidad()
}

class Venta {
  var property prendas = []
  var property fecha

  method agregarPrenda(prendaConCantidad) { prendas.add(prendaConCantidad) }

  method monto() = self.prendas().sum({ p => p.total() })
}

class VentaConTarjeta inherits Venta {
  const property coeficiente
  const property cuotas 
  
  override method monto() = super() + self.recargo()

  method recargo() = self.cuotas() * self.coeficiente() + self.prendas().sum({ p => p.total() * 0.01 })
}

class Empresa {
  var property ventas = []

  method agregarVenta(venta) { self.ventas().add(venta) }

  method gananciasDelDia(fechaSeleccionada) = self.ventas().filter({ v => v.fecha() == fechaSeleccionada }).sum({ v => v.monto() }) 
}