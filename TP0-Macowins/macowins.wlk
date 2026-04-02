class Prenda {
  const tipo
  var estado
  var precioBase
  
  method precio() = precioBase - estado.modificacion(precioBase)
  
}

class Nueva {
  method modificacion(precioBase) = 0
}

class Promocion {
  const valor
  
  method modificacion(precioBase) = valor.min(precioBase)
}

class Liquidacion {
  method modificacion(precioBase) = precioBase * 0.5
}

class ItemPrenda {
  const prenda
  const cantidad

  method total() = prenda.precio() * cantidad()
}

class Venta {
  var prendas = []
  var fecha

  method agregarPrenda(prendaConCantidad) { prendas.add(itemPrenda) }

  method monto() = prendas.sum({ p => p.total() })
}

class VentaConTarjeta inherits Venta {
  const coeficiente
  const cuotas 
  
  override method monto() = super() + recargo()

  method recargo() = cuotas * coeficiente + prendas.sum({ p => p.total() * 0.01 })
}

class Empresa {
  var ventas = []

  method agregarVenta(venta) { ventas.add(venta) }

  method gananciasDelDia(fechaSeleccionada) = ventas.filter({ v => v.fecha == fechaSeleccionada }).sum({ v => v.monto() }) 
}
