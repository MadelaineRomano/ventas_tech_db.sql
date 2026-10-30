--CONSULTA 1 — Resumen ejecutivo mensual
--Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. Con los datos que cargaste en M3 

SELECT
	MONTH (fecha_venta) AS Mes,
	COUNT (*) AS Cantidad_pedidos,
	SUM (cantidad * precio_unitario) AS Total_facturado,
	AVG (cantidad * precio_unitario) AS Ticket_promedio
FROM Ventas
GROUP BY MONTH(fecha_venta);



--CONSULTA 2 — Ranking de productos
--Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) y el total generado.

SELECT TOP 5 id_producto,
	SUM(cantidad) AS Unidades_vendidas,
	SUM(cantidad * precio_unitario) AS Total_generado
FROM ventas
GROUP BY id_producto
ORDER BY Total_generado DESC;



--CONSULTA 3- Clientes recurrentes
--id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado

SELECT id_cliente,
    COUNT(*) AS Cantidad_Pedidos,
    SUM(cantidad * precio_unitario) AS Total_Gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;



--CONSULTA 4 - Productos por encima/por debajo del promedio
--Total facturado por mes, con una columna adicional que etiquete con CASE WHEN si ese mes quedó 'Por encima' o 
--'Por debajo' del promedio mensual general.

WITH FacturacionProductos AS (
	SELECT id_producto,
		SUM(cantidad * precio_unitario) AS Total_facturado
	FROM ventas
	GROUP BY id_producto)

SELECT 
	id_producto,
	Total_facturado,
	CASE
		WHEN total_facturado > (SELECT AVG(total_facturado) FROM FacturacionProductos)
		THEN 'Por encima'
		ELSE 'Por debajo'
	END AS Comparacion_promedio

FROM FacturacionProductos
ORDER BY total_facturado DESC;



--BLOQUE DE CIERRRE 
--Al final del archivo agregá un bloque de comentarios
--con 3 hallazgos concretos que encontraste al revisar los resultados

	-- Hallazgo 1: se registraron un total de 10 pedidos concentrados en el mes de marzo de 2024.

	-- Hallazgo 2: el id_producto 2 es el mas vendido con  un volumen de 13 unidades vendidas,
	--				pero el de mayor ingreso es el id_producto 1 que genera mayores ingresos.

	-- Hallazgo 3: se identifica que la mayoría de los productos se encuentran por debajo del promedio de facturacion.
	--				Solo los producto 1 y 2 se destacan por encima del promedio de facturacion. 
	--				Se muestra que los ingresos dependen de los productos de alta gama, es decir, los mas caros.