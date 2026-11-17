-- Creamo la tabla para el ejercicio guiado
	CREATE TABLE ventas_semana (
    sucursal VARCHAR(50),
    venta DECIMAL(10,2)
);


-- Insertamos los datos de ventas (USD)
    INSERT INTO ventas_semana (sucursal, venta)
VALUES 
    ('Norte', 500),
    ('Norte', 510),
    ('Norte', 490),
    ('Norte', 505),
    ('Norte', 495),
    ('Sur', 100),
    ('Sur', 900),
    ('Sur', 50),
    ('Sur', 1200),
    ('Sur', 250);


SELECT * from ventas_semana


-- Parte 1: Analizando la consistencia de ventas — caso guiado

    --1.Calculá la media de ambas sucursales.
    --2.Calculá el rango de ambas sucursales.

    SELECT
  sucursal,
  AVG(venta)              AS media,
  MAX(venta) - MIN(venta) AS rango
FROM ventas_semana
GROUP BY sucursal;

    --3.Calculá la desviación estándar muestral para ambas (asumí que son una muestra de la operación anual).

    SELECT
  sucursal,
  STDEV(venta) AS desvio_muestral
FROM ventas_semana
GROUP BY sucursal;

--Misma media, dispersión muy distinta: Norte es la estable.

    --4. Redactá una conclusión de 3 líneas explicando cuál sucursal preferirías gestionar y por qué, 
    --basándote en la variabilidad.

        --personalmente preferiría gestionar la sucursal norte. Si bien el promedio de venta es de 500USD para ambas 
        --sucursales, las medidas de dispersión nos revelan que la sucursal norte (20 USD y 7.91) demuestran un 
        --comportamiento estable, homogéneo y predecible.



--Parte 2: Validación estadística de RetailPro (nueva — acumulativa)
--a) Ticket promedio real vs. representativo (al no tener una columna con el total_venta, realizamos el calculo)
    
    SELECT DISTINCT
    CAST(AVG(CAST((cantidad * precio_unitario) AS DECIMAL(10,2))) OVER() AS DECIMAL(10,2)) AS media,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (cantidad * precio_unitario)) OVER() AS mediana
FROM ventas;


--b) Detección de outliers con IQR Aplicá el método IQR sobre la columna total_venta de tu dataset:

    WITH q AS (
SELECT DISTINCT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (cantidad * precio_unitario)) OVER() AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (cantidad * precio_unitario)) OVER() AS q3
FROM ventas
)
SELECT
    CAST(q1 AS DECIMAL(10,2)) AS q1,
    CAST(q3 AS DECIMAL(10,2)) AS q3,
    CAST((q3 - q1) AS DECIMAL(10,2)) AS iqr,
    CAST(q1 - 1.5*(q3 - q1) AS DECIMAL(10,2)) AS limite_inferior,
    CAST(q3 + 1.5*(q3 - q1) AS DECIMAL(10,2)) AS limite_superior
FROM q;

--Identificá cuántos registros son outliers y cuáles son sus valores.

       WITH q AS (
SELECT DISTINCT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (cantidad * precio_unitario)) OVER() AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (cantidad * precio_unitario)) OVER() AS q3
FROM ventas
)
SELECT COUNT(*) AS cantidad_outliers
FROM ventas v, q
WHERE (v.cantidad * v.precio_unitario) > q.q3 + 1.5 * (q.q3 - q.q1);

--Para identificar los valores especificos

   WITH q AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY (cantidad * precio_unitario)) OVER() AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY (cantidad * precio_unitario)) OVER() AS q3
    FROM ventas
)
SELECT DISTINCT 
    (v.cantidad * v.precio_unitario) AS valor_outlier, 
    COUNT(*) AS veces_que_se_repite
FROM ventas v, q
WHERE (v.cantidad * v.precio_unitario) > q.q3 + 1.5 * (q.q3 - q.q1)
GROUP BY (v.cantidad * v.precio_unitario)
ORDER BY valor_outlier DESC;

--Determiná si representan errores de datos o eventos legítimos de negocio.