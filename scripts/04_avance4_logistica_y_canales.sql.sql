--4° Avance

--1) ¿Cómo puedo obtener una lista de todos los productos junto con sus categorías?
  
USE FastFoodDa
SELECT 
	P.Nombre AS Producto,
	C.Nombre AS Categoria
FROM 
	[dbo].[Productos] AS P INNER JOIN [dbo].[Categorias] AS C
ON 
	P.CategoriasId=C.CategoriasId
	
--2)¿Cómo puedo saber a qué sucursal está asignado cada empleado?
SELECT 
	E.Nombre AS Empleado,
	S.Nombre AS Sucursal
	FROM
[dbo].[Empleados] AS E LEFT JOIN [dbo].[Sucursales] AS S
ON
    E.SucursalesId = S.SucursalesId
--3) ¿Existen productos que no tienen una categoría asignada?
SELECT 
	P.Nombre,
	CASE 
		WHEN P.CategoriasId = C.CategoriasId THEN 'SI'
		ELSE 'NO'
		END AS CategoriaAsignada
	FROM [dbo].[Productos] AS P INNER JOIN [dbo].[Categorias] AS C
	ON P.CategoriasId = C.CategoriasId
	GROUP BY P.Nombre,P.CategoriasId,C.CategoriasId ;
use FastFoodDa
--4) ¿Cómo puedo obtener un detalle completo de las órdenes, 
--incluyendo el Nombre del cliente, Nombre del empleado que tomó la orden, y Nombre del mensajero que la entregó?
SELECT 
	 O.OrdenesId AS OrdenId,
     C.Nombre AS Cliente,
	 E.Nombre AS Empleado,
	 M.Nombre AS Mensajero
	FROM 
	 [dbo].[Ordenes] AS O INNER JOIN Clientes AS C 
	 ON O.ClientesId = C.ClientesId INNER JOIN Empleados AS E
	 ON O.EmpleadosId = E.EmpleadosId INNER JOIN Mensajero AS M
	 ON O.MensajeroId = M.MensajeroId;

--5)¿Cuántos artículos correspondientes a cada Categoría de Productos se han vendido en cada sucursal?

	
USE [FastFoodDa]
SELECT*
FROM Ordenes

SELECT
	COUNT(D.Cantidad) AS CantidadArticulos,
	C.Nombre AS Categoria,
	S.Nombre AS Sucursal		  
  FROM
	[dbo].[Ordenes] AS O INNER JOIN [dbo].[DetalleOrden] AS D
  ON O.OrdenesId = D.OrdenesId INNER JOIN
	[dbo].[Productos] AS P
  ON D.ProductosId = P.ProductosId INNER JOIN
	[dbo].[Sucursales] AS S
  ON S.SucursalesId = O.SucursalesId INNER JOIN
	[dbo].[Categorias] AS C
  ON C.CategoriasId = P.CategoriasId
  GROUP BY C.Nombre, S.Nombre
  ORDER BY CantidadArticulos, C.Nombre DESC;