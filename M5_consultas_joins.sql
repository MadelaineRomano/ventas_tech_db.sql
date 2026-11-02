--CONSULTA 1 — Vista base del proyecto (INNER JOIN)
--Combiná ventas, clientes, productos y territorios para obtener en una sola fila: fecha, nombre del cliente, 
--segmento, región, nombre del producto, categoría, cantidad, precio unitario, total de venta y canal.

SELECT 
	v.fecha_venta,
	c.id_cliente,
	c.nombre AS nombre_cliente,
	c.ciudad,
	p.nombre_producto,
	v.cantidad,
	v.precio_unitario,
	(v.cantidad * v.precio_unitario) AS total_ventas
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;

--Hallazgo: Aqui vemos la informacion consolidada de RetailPro, vinculando cada venta con el cliente sumando la 
--descripcion del producto, sin perder informacion sobre las cantidades de los productos vendidos o el total 
--generado por la venta.



--CONSULTA 2 — Clientes sin ventas (LEFT JOIN)
--Identificá clientes registrados que aún no compraron. Mostrá su nombre, email y fecha de registro.

SELECT
	c.nombre,
	c.email,
	c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

--Hallazgo: esta consulta nos arroja cero registros, lo que indica que todos los clientes registrados tienen al menos
--una venta realizada.Por lo cual, el area de CRM deberia enfocarse en retener y fidelizar esos clientes, no requiere de
--campañas de reactivacion.


--CONSULTA 3 — Productos sin ventas (LEFT JOIN)
--Identificá productos del catálogo que no tienen ninguna venta registrada. Mostrá nombre del producto, categoría y precio.

SELECT 
	p.nombre_producto,
	cat.nombre_categoria,
	p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

--Hallazgo: la consulta arroja cero registros, significa que el area de producto tiene un catalogo podriamos decir 
--estable, ya que, todos los productos marcan una venta. Entonces, no se requeriran campañas o liquidacion para 
--promover productos en sobrestock.



--CONSULTA 4 — Consolidado por canal (UNION ALL)
--Usá UNION ALL para combinar en un solo resultado las ventas Online y Presencial, agregando una columna 
--canal que identifique el origen de cada fila. Al final, calculá el total por canal con un GROUP BY.

SELECT 
	canal,
	SUM(total) AS total_canal
FROM (
	SELECT 
		fecha_venta,
		(cantidad * precio_unitario) AS total,
		'Online' AS canal
	FROM ventas
	WHERE id_venta % 2 <> 0

	UNION ALL

	SELECT
		fecha_venta,
		(cantidad * precio_unitario) AS total,
		'Presencial' AS canal
		FROM ventas
		WHERE id_venta % 2 = 0
	) AS consolidado
	GROUP BY canal;

--Hallazgo: La segmentacion por canal simulada nos permite evaluar los ingresos distribuidos entre el canal online y
--presencial, demostrando un fuerte volumen de ingresos por el canal online con una diferencia de $2.676.