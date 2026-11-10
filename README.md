## RETAILPRO - BASE DE DATOS VENTAS TECH 
En este proyecto trabajamos con un caso de negocio de una empresa distribuidora de tecnología llamada RetailPro. 
EL objetivo es definir el problema de negocio, sus fuentes de datos y KPIS. 

Este proyecto integrador del curso de Data Analytics contiene: diseño de un modelo de datos de ventas, construcción de la 
base en SQL Server

### TABLA DE CONTENIDO
1. Modelo de datos
2. Herramientas y Tecnologías Usadas
3. Estructura del proyecto por modulos
4. Guía de Ejecución de los Scripts SQL
    Prer-requisitos
    Paso a Paso
5. Hallazgos de negocio



### 1 MODELO DE DATOS 
Esquema normalizado tipo estrella, con una tabla de hechos y tres dimensiones, por un lado tenemos la tabla de hechos
(tabla ventas) que se estructura por columnas de id_venta, id_cliente,id_producto,cantidad, precio_unitario y fecha venta. 
Ademas esta la tabla dimension clientes, cuya columnas son id_cliente,nombre,email,ciudad y fecha registro. La tabla 
productos, con columnas identificadas como id_producto, nombre_producto, id_categoria, precio, stock y activo. Y una ultima 
tabla de dimension, la tabla categorias, cuyas columnas son id_categoria, nombre_categoria y descripcion. 

Las relaciones son de 1 a muchos. 


### 2 HERRAMINETAS Y TECNOLOGIAS USADAS
La base de datos está normalizada (hasta 3FN) e incluye las siguientes entidades principales y sus relaciones:
1. Herramienta	SQL Server como	Motor de base de datos.
2. SQL Server Management Studio (SSMS)	para la ejecución de scripts y consultas.
3. Power BI Desktop	Modelado, medidas y visualización.
4. Power Query / Lenguaje M	Transformación y carga de datos.
5. DAX	Tabla calendario y medidas.
6. Git / GitHub	Control de versiones y documentación.


### 3 ESTRUCTURA DEL PROYECTO POR MODULOS
Modulo 1: 	Brief del proyecto	Definición del caso de negocio RetailPro y sus objetivos.
Modulo 2: 	Modelo de datos	Diseño del modelo a mano alzada: entidades, claves y relaciones.
Modulo 3: Script SQL de esquema y datos iniciales	Creación de la base de datos, tablas, columnas con tipos de datos, 
restricciones e inserción de datos.
Modulo 4: 	Consultas con funciones de agregación	SUM, COUNT, AVG, etc. con GROUP BY para métricas de negocio.
Modulo 5: 	Consultas con JOIN	Combinación de ventas con clientes, productos y categorías mediante INNER JOIN.
Modulo 6: Power Query y lenguaje M	Conexión a SQL Server y transformación de datos en Power BI.
Modulo 7: 	Boceto del dashboard (PDF)	Prototipo previo de cómo se imaginó el tablero.
Modulo 8: Power BI: modelo y medidas	Relaciones entre tablas, tabla calendario, tabla de medidas y matriz de validación.


### 4 GUIA DE EJECUCION
### Pre-requisitos
1. Tener instalado **SQL Server** (Developer o Express).
2. Tener instalado **SQL Server Management Studio (SSMS)** o **Azure Data Studio**.
3. Tener instalado **Power BI Desktop**.
4. Clonar el repositorio localmente o descargar los archivos:
   git clone https://github.com/MadelaineRomano/ventas_tech_db.sql.git

### Paso a paso
1. Abrir SQL Server Management Studio (SSMS) y conectarse al servidor local.
2. Abrir y ejecutar el script schema.sql (o el script de creación de base y tablas) haciendo clic en Execute
(o presionando F5). Esto creará la base de datos ventas_tech_db y su estructura normalizada.
3. Abrir y ejecutar el Modulo3_ScriptSQL.sql (inserción de datos) para poblar las tablas Clientes, Productos, Categorias y Ventas.
4. Abrir y ejecutar queries.sql para validar las consultas con funciones de agregación y JOINs.

### 5 Hallazgos del negocio
A partir de las consultas del mes analizado (marzo):
1. Facturación total: $6.444 en 10 pedidos, con un ticket promedio de $644,40.
2. Concentración: el producto 1 genera el 55,9% de la facturación y, junto con el producto 3, suman el 76,8%.
3. Volumen vs. valor: el producto 2 es el más vendido en unidades (13), pero aporta solo el 5,6% de la facturación.
4. Precio como factor clave: con el mismo volumen (3 unidades), los productos 1, 3 y 5 facturan montos muy distintos por
  su diferencia de precio.
5. Es una muestra de un solo mes y 10 pedidos: describe concentración y mezcla de productos, no tendencias.


### AUTORA
  Madelaine Romano — Proyecto del curso de Data Analytics.
