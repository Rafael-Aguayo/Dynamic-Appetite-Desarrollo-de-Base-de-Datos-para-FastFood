--1) Eficiencia de los mensajeros: ¿Cuál es el tiempo promedio desde el despacho 
--hasta la entrega de los pedidos gestionados por todo el equipo de mensajería?
USE FastFoodDa;

SELECT 
	AVG(DATEDIFF(MINUTE,[FechaDespacho],[FechaEntrega])) AS TiempoPromedioEntregas
	FROM
	  [dbo].[Ordenes] ;
	
--2)Análisis de Ventas por Origen de Orden: ¿Qué canal de ventas genera más ingresos?

SELECT 
	  B.Descripcion AS CanalVentas,
	  SUM(A.TotalCompra)  AS Ingresos
	FROM 
	  [dbo].[Ordenes] AS A INNER JOIN [dbo].[OrigenesOrden] AS B
	ON A.OrigenesOrdenId  = B.OrigenesOrdenId
	GROUP BY B.Descripcion
	ORDER BY Ingresos DESC;

--3)Productividad de los Empleados: ¿Cuál es el nivel de ingreso generado por Empleado?
SELECT 
	  B.Nombre AS Empleado,
	  SUM(A.TotalCompra)  AS IngresosGenerados
	FROM 
	  [dbo].[Ordenes] AS A INNER JOIN [dbo].[Empleados] AS B
	ON A.EmpleadosId  = B.EmpleadosId
	GROUP BY B.Nombre
	ORDER BY IngresosGenerados DESC;
/*4)Análisis de Demanda por Horario y Día: ¿Cómo varía la demanda de productos a lo largo del día? 
NOTA: Esta consulta no puede ser implementada sin una definición
clara del horario (mañana, tarde, noche) en la base de datos existente. 
Asumiremos que HorarioVenta refleja esta información correctamente.*/
use FastFoodDa
SELECT 
	HorarioVenta AS HorarioVenta,
	[TotalCompra] AS Importe,
	FechaOrdenTomada as Dia
	FROM [dbo].[Ordenes]
	GROUP BY HorarioVenta,[TotalCompra],FechaOrdenTomada
	ORDER BY  Dia  DESC;
	       
SELECT 
	HorarioVenta,
	TotalCompra
    FROM [dbo].[Ordenes]

-- 5)¿Cuál es la tendencia de los ingresos generados en cada periodo mensual?
use FastFoodDa
SELECT 
	[TotalCompra] AS Ingresos,
	DATEPART(MONTH,FechaOrdenTomada) AS Mes
	FROM [dbo].[Ordenes]
	GROUP BY HorarioVenta,[TotalCompra],FechaOrdenTomada
	ORDER BY  Mes ASC;

 