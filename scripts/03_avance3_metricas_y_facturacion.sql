
	-- 3° avance DAM2L5 
	--1.) ¿Cuál es el total de ventas (TotalCompra) a nivel global?
USE FastFoodDa
SELECT 
	SUM ([TotalCompra]) AS TotalVentas
   FROM [dbo].[Ordenes]
   ;
    --2) ¿Cuál es el precio promedio de los productos dentro de cada categoría?
SELECT 
    [CategoriasId],
    AVG ([Precio]) AS PrecioPromedio
   FROM Productos 
   GROUP BY [CategoriasId]
   ORDER BY PrecioPromedio DESC
   ;
-- Con join implicito
SELECT
    Cat.[CategoriasId],
    Cat.Nombre AS NombreCategoria,
    AVG ([Precio]) AS PrecioPromedio
   FROm Productos AS Prd,
        [dbo].[Categorias] AS Cat
    WHERE Prd.CategoriasId=Cat.CategoriasId
   GROUP BY Cat.Nombre, Cat.[CategoriasId]
   ORDER BY PrecioPromedio DESC;
   --3)¿Cuál es el valor de la orden mínima y máxima por cada sucursal?
 
SELECT  
      [SucursalesId],
     MIN ([TotalCompra]) AS ValorMinimoOrden,
     MAX ([TotalCompra]) AS ValorMaximoOrden
   FROM [dbo].[Ordenes]
   GROUP BY [SucursalesId]
   ORDER BY [SucursalesId] ASC
   ;
--Con join implícito
SELECT  
      Suc.SucursalesId,
	  Suc.Nombre,
     MIN (Ord.TotalCompra) AS ValorMinimoOrden,
     MAX (Ord.TotalCompra) AS ValorMaximoOrden
   FROM [dbo].[Ordenes] AS Ord,
        [dbo].[Sucursales] AS Suc
   WHERE Ord.SucursalesId = Suc.SucursalesId
   GROUP BY Suc.Nombre,Suc.SucursalesId
   ORDER BY Suc.[SucursalesId] ASC;

      --4)¿Cuál es el mayor número de kilómetros recorridos para una entrega?
SELECT
    MAX ([KilometrosRecorrer]) AS MaxKmRecorridos
   FROM [dbo].[Ordenes]
   ;
   --5)¿Cuál es la cantidad promedio de productos por orden?
SELECT  OrdenesId,
   AVG([Cantidad]) AS CantidadPromedioxOrden
   FROM [dbo].[DetalleOrden]
    GROUP BY OrdenesId
	;
	
	--6)¿Cómo se distribuye la Facturación Total del Negocio de acuerdo a los métodos de pago?
SELECT 
	 [TiposDePagoId],   
     SUM([TotalCompra]) AS DistribucionDeFacturacion
   FROM [dbo].[Ordenes]
    GROUP BY [TiposDePagoId]
	ORDER BY DistribucionDeFacturacion DESC
	;
-- Con join implicito
SELECT 
	 TdP.Descripcion AS TiposDePago,   
     SUM([TotalCompra]) AS DistribucionDeFacturacion
   FROM [dbo].[Ordenes] AS Ord,
        [dbo].[TiposDePago] AS TdP
		WHERE Ord.TiposDePagoId=TdP.TiposDePagoId
    GROUP BY Ord.[TiposDePagoId],TdP.Descripcion
	ORDER BY DistribucionDeFacturacion DESC
	;
	--7)¿Cuál Sucursal tiene el ingreso promedio más alto?
SELECT   
	 [SucursalesId],
     AVG([TotalCompra]) AS IngresoPromMasAlto
   FROM [dbo].[Ordenes]
   GROUP BY [SucursalesId]
   ORDER BY IngresoPromMasAlto DESC;

-- Con join implicito

SELECT  
	 Suc.Nombre AS NombreSucursal,
     AVG([TotalCompra]) AS IngresoPromMasAlto
   FROM [dbo].[Ordenes] AS Ord,
        [dbo].[Sucursales] AS Suc
		WHERE Ord.SucursalesId=Suc.SucursalesId
   GROUP BY Suc.Nombre
   ORDER BY IngresoPromMasAlto DESC
   ;

   --8)¿Cuáles son las sucursales que han generado ventas totales por encima de $ 1000?
 SELECT
      [SucursalesId],
	  SUM ([TotalCompra]) AS VentasTotales
    FROM [dbo].[Ordenes]
	GROUP BY SucursalesId
	HAVING SUM([TotalCompra])> 1000
	ORDER BY VentasTotales DESC;

--Con join implicito

SELECT
      Suc.Nombre AS NombreSucursal,
	  SUM ([TotalCompra]) AS VentasTotales
    FROM [dbo].[Ordenes] AS Ord,
       [dbo].[Sucursales] AS Suc
	   WHERE Ord.SucursalesId = Suc.SucursalesId
	GROUP BY Suc.Nombre
	HAVING SUM([TotalCompra])> 1000
	ORDER BY VentasTotales DESC 
	;
	--9)¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?

-- Antes del 1 de julio sin considerar hora
SELECT AVG([TotalCompra]) AS promedioAntes
FROM [dbo].[Ordenes]
WHERE CAST([FechaOrdenTomada] AS DATE) < '2023-07-01';

-- Después del 1 de julio sin considerar hora
SELECT AVG([TotalCompra]) AS promedioDespues
FROM [dbo].[Ordenes]
WHERE CAST([FechaOrdenTomada] AS DATE) >= '2023-07-01';

-- QUERYS UNIDAS

SELECT 'Antes del 1-Jul-2023' AS periodo,
       AVG([TotalCompra]) AS promedio
FROM [dbo].[Ordenes]
WHERE CAST([FechaOrdenTomada] AS DATE) < '2023-07-01'

UNION ALL

SELECT 'Desde el 1-Jul-2023' AS periodo,
       AVG([TotalCompra]) AS promedio
FROM [dbo].[Ordenes]
WHERE CAST([FechaOrdenTomada] AS DATE) >= '2023-07-01';
--Mostrando la diferencia entre periodos
SELECT 
    AVG(CASE WHEN CAST(FechaOrdenTomada AS DATE) < '2023-07-01' THEN TotalCompra END) AS promedioAntes,
    AVG(CASE WHEN CAST(FechaOrdenTomada AS DATE) >= '2023-07-01' THEN TotalCompra END) AS promedioDespues,
    AVG(CASE WHEN CAST(FechaOrdenTomada AS DATE) >= '2023-07-01' THEN TotalCompra END) -
    AVG(CASE WHEN CAST(FechaOrdenTomada AS DATE) < '2023-07-01' THEN TotalCompra END) AS diferencia
FROM [dbo].[Ordenes];
-- Cálculo del porcentraje de incremento en las ventas del segundo semestre sobre el primero con una CTE

WITH CalculoPromedios AS (
    SELECT
        AVG(CASE WHEN CAST(FechaOrdenTomada AS DATE) < '2023-07-01' THEN TotalCompra END) AS promedioAntes,
        AVG(CASE WHEN CAST(FechaOrdenTomada AS DATE) >= '2023-07-01' THEN TotalCompra END) AS promedioDespues,
        AVG(CASE WHEN CAST(FechaOrdenTomada AS DATE) >= '2023-07-01' THEN TotalCompra END) -
        AVG(CASE WHEN CAST(FechaOrdenTomada AS DATE) < '2023-07-01' THEN TotalCompra END) AS diferencia
    FROM
        [dbo].[Ordenes]
)
SELECT
    promedioAntes,
    promedioDespues,
    diferencia,
    -- Calcula el porcentaje de cambio
    CASE
        WHEN promedioAntes = 0 OR promedioAntes IS NULL THEN NULL -- Evita división por cero o nulos
        ELSE ((promedioDespues - promedioAntes) / promedioAntes) * 100
    END AS PorcentajeCambio
FROM
    CalculoPromedios;

   /*10) ¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor cantidad de ventas,
   cuál es el ingreso promedio de estas ventas, y cuál ha sido el importe máximo alcanzado 
   por una orden en dicha jornada?*/

SELECT [HorarioVenta],
    COUNT ([OrdenesId]) AS CantidadDeVentas,
	AVG([TotalCompra]) AS IngresoPromedio,
	MAX([TotalCompra]) AS ImporteMaximo
   FROM [dbo].[Ordenes]
   GROUP BY [HorarioVenta]
   ORDER BY CantidadDeVentas DESC
   ;