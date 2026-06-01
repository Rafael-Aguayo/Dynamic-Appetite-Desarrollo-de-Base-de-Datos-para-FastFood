--PREGUNTAS DAM2L4
--1. Pregunta: ¿Cuál es la cantidad total de registros únicos en la tabla de órdenes?

SELECT 
  COUNT ([OrdenesId]) AS RegistrosUnicos
  FROM Ordenes
  ;
  --2. Pregunta: ¿Cuántos empleados existen en cada departamento?

 SELECT 
	Departamento,
    COUNT (EmpleadosId) AS CantidadEmpleados
   FROM [dbo].[Empleados] 
   GROUP BY Departamento
   ORDER BY CantidadEmpleados DESC;

   --3. Pregunta: ¿Cuántos productos hay por código de categoría?
SELECT 
   P.[CategoriasId],
   C.Nombre,
   count ([ProductosId]) AS Productos
  FROM Productos AS P, Categorias AS C
  WHERE C.CategoriasId = P.CategoriasId
  GROUP BY P.[CategoriasId], C.Nombre
  ORDER BY Productos DESC;

  ---4. Pregunta: ¿Cuántos clientes se han importado a la tabla de clientes?
  SELECT
  COUNT ([ClientesId]) AS CantidadClientes
  FROM 
	[dbo].[Clientes];

  /*5.Pregunta: ¿Cuáles son las sucursales con un promedio de Facturación/Ingresos 
  superior a 1000.00 y que minimizan sus costos en base al promedio de kilómetros 
  recorridos de todas de sus entregas gestionadas? Para un mejor relevamiento, 
  ordene el listado por el Promedio Km Recorridos.*/
  --Con join implícito
  use FastFoodDa
 SELECT
    S.[SucursalesId],
	S.[Nombre] AS Sucursal,
	AVG ([TotalCompra]) AS PromedioFacturacion,
	AVG ([KilometrosRecorrer]) AS PromKmRecorridos
    FROM [dbo].[Ordenes] AS O,
	[dbo].[Sucursales] AS S
    WHERE O.SucursalesId = S.SucursalesId
	GROUP BY S.[Nombre],S.[SucursalesId]
	HAVING AVG ([TotalCompra])> 1000
	ORDER BY PromkmRecorridos ASC;
-- Sin join implícito
SELECT
	[SucursalesId],
	AVG ([TotalCompra]) AS PromedioFacturacion,
	AVG ([KilometrosRecorrer]) AS PromKmRecorridos
    FROM [dbo].[Ordenes]
	GROUP BY [SucursalesId]
	HAVING AVG ([TotalCompra])> 1000
	ORDER BY PromkmRecorridos ASC;