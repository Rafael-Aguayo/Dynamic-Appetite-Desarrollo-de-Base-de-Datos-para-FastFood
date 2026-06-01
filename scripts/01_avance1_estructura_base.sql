--Paso 1. Crear base de datos
-- La indentación o sangría es importante para hacer mas efectiva la visualización
CREATE DATABASE FastFoodDa
ON 
( NAME = 'FastFoodDa_Data',
  FILENAME = 'C:\FastFood_DA\FastFoodDa_Data.mdf',
  SIZE = 50MB,
  MAXSIZE = 1GB,
  FILEGROWTH = 5MB )
LOG ON
( NAME = 'Carrera_BD_Log',
  FILENAME = 'C:\FastFood_DA\FastFoodDa_Log.ldf',
  SIZE = 25MB,
  MAXSIZE = 256MB,
  FILEGROWTH = 5MB );
  --Paso 2. Activar la base de datos
USE FastFoodDa
  --Paso 3. Crear las tablas
  --Categorias
CREATE TABLE Categorias
  (
  CategoriasId INT PRIMARY KEY IDENTITY(1,1),
  Nombre NVARCHAR (100) NOT NULL
   )
   ;
   --Productos
CREATE TABLE Productos
   (
   ProductosId INT PRIMARY KEY IDENTITY,
   Nombre NVARCHAR(100) NOT NULL,
   CategoriasId INT,
   Precio DECIMAL(10,2) NOT NULL,
   FOREIGN KEY (CategoriasId) REFERENCES Categorias (CategoriasId)
   )
   ;
   --SUCURSALES
CREATE TABLE Sucursales
   (
   SucursalesId INT PRIMARY KEY IDENTITY,
   Nombre NVARCHAR(100) NOT NULL,
   CategoriasId INT,
   Direccion NVARCHAR(100) NOT NULL
   )
   ;
   --Empleados
CREATE TABLE Empleados
   (
   EmpleadosId INT PRIMARY KEY IDENTITY,
   Nombre NVARCHAR(100) NOT NULL,
   Rol NVARCHAR(50),
   Posicion NVARCHAR(100),
   Departamento NVARCHAR(100),
   SucursalesId INT,
   FOREIGN KEY (SucursalesId) REFERENCES Sucursales (SucursalesId)
   )
   ;
   --Clientes
CREATE TABLE Clientes
   (
   ClientesId INT PRIMARY KEY IDENTITY,
   Nombre NVARCHAR(100) NOT NULL,
   Direccion NVARCHAR(100) NOT NULL,
   Precio DECIMAL(10,2) NOT NULL,
   )
   ;
   --OrigenesOrden
CREATE TABLE OrigenesOrden
   (
   OrigenesOrdenId INT PRIMARY KEY IDENTITY,
   Descripcion NVARCHAR(255) NOT NULL,
   )
   ;
   --TiposDePago
CREATE TABLE TiposDePago
   (
   TiposDePagoId INT PRIMARY KEY IDENTITY,
   Descripcion NVARCHAR(100) NOT NULL,
   )
   ;
   --Mensajero
CREATE TABLE Mensajero
   (
   MensajeroId INT PRIMARY KEY IDENTITY,
   Nombre NVARCHAR(100) NOT NULL,
   EsExterno BIT NOT NULL
   )
   ;
   --Ordenes
CREATE TABLE Ordenes
   (
   OrdenesId INT PRIMARY KEY IDENTITY,
   ClientesId	INT,
   EmpleadosId INT,
   SucursalesId INT,
   MensajeroId INT,
   TiposDePagoId INT,
   OrigenesOrdenId INT,
   HorarioVenta CHAR(10),
   TotalCompra DECIMAL(10,2) NOT NULL,
   KilometrosRecorrer DECIMAL(10,2),
   FechaDespacho DATETIME,
   FechaEntrega DATETIME,
   FechaOrdenTomada DATETIME,
   FechaOrdenLista DATETIME,
   FOREIGN KEY (ClientesId) REFERENCES Clientes (ClientesId),
   FOREIGN KEY (EmpleadosId) REFERENCES Empleados (EmpleadosId),
   FOREIGN KEY (SucursalesId) REFERENCES Sucursales (SucursalesId),
   FOREIGN KEY (MensajeroId) REFERENCES Mensajero (MensajeroId),
   FOREIGN KEY (TiposDePagoId) REFERENCES TiposDePago (TiposDePagoId),
   FOREIGN KEY (OrigenesOrdenId) REFERENCES OrigenesOrden (OrigenesOrdenId),
   )
   ;
   --Detalle Ordenes

CREATE TABLE DetalleOrden
   (
   OrdenesId INT,
   ProductosId INT,
   Cantidad INT,
   Precio DECIMAL(10,2),
   Primary KEY (OrdenesId,ProductosId), 
   FOREIGN KEY (ProductosId)REFERENCES Productos (ProductosId),
   Foreign key (OrdenesId) REFERENCES Ordenes (OrdenesId)
   )
   ;
USE FastFoodDa
   -- Insertar datos en Categorias
INSERT INTO Categorias (Nombre) VALUES 
  ('Comida Rápida'), ('Postres'), ('Bebidas'), ('Ensaladas'), ('Desayunos'),
  ('Cafetería'), ('Helados'), ('Comida Vegana'), ('Carnes'), ('Pizzas');

USE FastFoodDa
SELECT * 
  FROM Categorias
-- Insertar datos en Productos
INSERT INTO Productos (Nombre, CategoriasId, Precio) VALUES
  ('Hamburguesa Deluxe', 1, 9.99), 
  ('Cheeseburger', 1, 7.99), 
  ('Pizza Margarita', 10, 11.99),
  ('Pizza Pepperoni', 10, 12.99),
  ('Helado de Chocolate', 7, 2.99),
  ('Helado de Vainilla', 7, 2.99),
  ('Ensalada César', 4, 5.99), 
  ('Ensalada Griega', 4, 6.99), 
  ('Pastel de Zanahoria', 2, 3.99),
  ('Brownie', 2, 2.99);
SELECT *
  FROM [dbo].[Productos]
  -- Insertar datos en Sucursales
INSERT INTO Sucursales
  (Nombre, Direccion) VALUES
  ('Sucursal Central', '1234 Main St'), ('Sucursal Norte', '5678 North St'), 
  ('Sucursal Este', '9101 East St'), ('Sucursal Oeste', '1121 West St'),
  ('Sucursal Sur', '3141 South St'),('Sucursal Playa', '1516 Beach St'), 
  ('Sucursal Montaña', '1718 Mountain St'), ('Sucursal Valle', '1920 Valley St'), 
  ('Sucursal Lago', '2122 Lake St'), ('Sucursal Bosque', '2324 Forest St');
SELECT *
  FROM [dbo].[Sucursales]
  -- Insertar datos en Empleados
INSERT INTO Empleados (Nombre, Posicion, Departamento, SucursalesId, Rol) VALUES
  ('John Doe', 'Gerente', 'Administración', 1, 'Vendedor'), 
  ('Jane Smith', 'Subgerente', 'Ventas', 1, 'Vendedor'),
  ('Bill Jones', 'Cajero', 'Ventas', 1, 'Vendedor'), 
  ('Alice Johnson', 'Cocinero', 'Cocina', 1, 'Vendedor'),
  ('Tom Brown', 'Barista', 'Cafetería', 1, 'Vendedor'),
  ('Emma Davis', 'Repartidor', 'Logística', 1, 'Mensajero'),
  ('Lucas Miller', 'Atención al Cliente', 'Servicio', 1, 'Vendedor'), 
  ('Olivia García', 'Encargado de Turno', 'Administración', 1, 'Vendedor'),
  ('Ethan Martinez', 'Mesero', 'Restaurante', 1, 'Vendedor'), 
  ('Sophia Rodriguez', 'Auxiliar de Limpieza', 'Mantenimiento', 1, 'Vendedor');
SELECT *
  FROM 
  [dbo].[Empleados]


SELECT*
  FROM 
  [dbo].[Clientes];
  --Corrigiendo error columna que no corresponde en la tabla clientes
ALTER TABLE 
	[dbo].[Clientes]
DROP COLUMN 
	[Precio];
ALTER TABLE 
	[dbo].[Ordenes]
DROP CONSTRAINT 
	[FK__Ordenes__Cliente__5AEE82B9];
ALTER TABLE
	[dbo].[Clientes]
DROP CONSTRAINT 
	[PK__Clientes__E601B88E30A1AEAF];
DROP TABLE 
	[dbo].[Clientes];
  --Volviendo a crear la tabla clientes
CREATE TABLE Clientes
   (
   ClientesId INT PRIMARY KEY IDENTITY,
   Nombre NVARCHAR(100) NOT NULL,
   Direccion NVARCHAR(100) NOT NULL,
   )
   ;
   --Añadiendo relacion ClientesId con la tabla Ordenes
ALTER TABLE 
	[dbo].[Ordenes]
ADD CONSTRAINT
	[FK__Ordenes__Cliente__5AEE82B9]
FOREIGN KEY
	(ClientesId)
REFERENCES 
	[dbo].[Clientes] (ClientesId);
  -- Insertar datos en Clientes
INSERT INTO Clientes (Nombre, Direccion) VALUES
  ('Cliente Uno', '1000 A Street'), 
  ('Cliente Dos', '1001 B Street'), 
  ('Cliente Tres', '1002 C Street'),
  ('Cliente Cuatro', '1003 D Street'),
  ('Cliente Cinco', '1004 E Street'),
  ('Cliente Seis', '1005 F Street'),
  ('Cliente Siete', '1006 G Street'),
  ('Cliente Ocho', '1007 H Street'), 
  ('Cliente Nueve', '1008 I Street'), 
  ('Cliente Diez', '1009 J Street');
SELECT *
  FROM 
	[dbo].[Clientes];
  -- Insertar datos en OrigenesOrden
INSERT INTO OrigenesOrden (Descripcion) VALUES
  ('En línea'), ('Presencial'), ('Teléfono'), ('Drive Thru'), ('App Móvil'),
  ('Redes Sociales'), ('Correo Electrónico'), ('Publicidad'), ('Recomendación'), ('Evento');
SELECT*
  FROM 
    [dbo].[OrigenesOrden];
  -- Insertar datos en TiposPago
INSERT INTO TiposDePago (Descripcion) VALUES
  ('Efectivo'), ('Tarjeta de Crédito'), ('Tarjeta de Débito'), ('PayPal'), ('Transferencia Bancaria'),
  ('Criptomonedas'), ('Cheque'), ('Vale de Comida'), ('Cupón de Descuento'), ('Pago Móvil');
SELECT*
  FROM 
    [dbo].[TiposDePago];
  -- Insertar datos en Mensajeros
INSERT INTO Mensajero (Nombre, EsExterno) VALUES
  ('Mensajero Uno', 0), ('Mensajero Dos', 1), ('Mensajero Tres', 0), ('Mensajero Cuatro', 1), ('Mensajero Cinco', 0),
  ('Mensajero Seis', 1), ('Mensajero Siete', 0), ('Mensajero Ocho', 1), ('Mensajero Nueve', 0), ('Mensajero Diez', 1);
SELECT*
  FROM 
    [dbo].[Mensajero];
  -- Insertar datos en Ordenes
INSERT INTO Ordenes (ClientesId, EmpleadosId, SucursalesId, MensajeroID, TiposDePagoId, OrigenesOrdenId, HorarioVenta, TotalCompra, KilometrosRecorrer, FechaDespacho, FechaEntrega, FechaOrdenTomada, FechaOrdenLista) VALUES
(1, 1, 1, 1, 1, 1, 'Mañana', 1053.51, 5.5, '2023-01-10 08:30:00', '2023-01-10 09:00:00', '2023-01-10 08:00:00', '2023-01-10 08:15:00'),
(2, 2, 2, 2, 2, 2, 'Tarde', 1075.00, 10.0, '2023-02-15 14:30:00', '2023-02-15 15:00:00', '2023-02-15 13:30:00', '2023-02-15 14:00:00'),
(3, 3, 3, 3, 3, 3, 'Noche', 920.00, 2.0, '2023-03-20 19:30:00', '2023-03-20 20:00:00', '2023-03-20 19:00:00', '2023-03-20 19:15:00'),
(4, 4, 4, 4, 4, 4, 'Mañana', 930.00, 0.5, '2023-04-25 09:30:00', '2023-04-25 10:00:00', '2023-04-25 09:00:00', '2023-04-25 09:15:00'),
(5, 5, 5, 5, 5, 5, 'Tarde', 955.00, 8.0, '2023-05-30 15:30:00', '2023-05-30 16:00:00', '2023-05-30 15:00:00', '2023-05-30 15:15:00'),
(6, 6, 6, 6, 6, 1, 'Noche', 945.00, 12.5, '2023-06-05 20:30:00', '2023-06-05 21:00:00', '2023-06-05 20:00:00', '2023-06-05 20:15:00'),
(7, 7, 7, 7, 7, 2, 'Mañana', 1065.00, 7.5, '2023-07-10 08:30:00', '2023-07-10 09:00:00', '2023-07-10 08:00:00', '2023-07-10 08:15:00'),
(8, 8, 8, 8, 8, 3, 'Tarde', 1085.00, 9.5, '2023-08-15 14:30:00', '2023-08-15 15:00:00', '2023-08-15 14:00:00', '2023-08-15 14:15:00'),
(9, 9, 9, 9, 9, 4, 'Noche', 1095.00, 3.0, '2023-09-20 19:30:00', '2023-09-20 20:00:00', '2023-09-20 19:00:00', '2023-09-20 19:15:00'),
(10, 10, 10, 10, 10, 5, 'Mañana', 900.00, 15.0, '2023-10-25 09:30:00', '2023-10-25 10:00:00', '2023-10-25 09:00:00', '2023-10-25 09:15:00');
SELECT*
  FROM 
    [dbo].[Ordenes];
  /*Mens. 242, Nivel 16, Estado 3, Línea 228
La conversión del tipo de datos varchar en datetime produjo un valor fuera de intervalo.*/
--Cambiando formato de fecah
SET DATEFORMAT 'YMD'
  --Corrigiendo error de columna OrdenesId
ALTER TABLE 
	[dbo].[DetalleOrden]
DROP CONSTRAINT
	[FK__DetalleOr__Orden__6383C8BA] ;
ALTER TABLE
	[dbo].[Ordenes]
DROP CONSTRAINT 
	[PK__Ordenes__E9716A3B79125A4D];
ALTER TABLE 
	[dbo].[Ordenes]
DROP COLUMN 
	[OrdenesId];
ALTER TABLE 
	[dbo].[Ordenes]
ADD OrdenesId INT PRIMARY KEY IDENTITY;
SELECT *
 FROM 
	[dbo].[Ordenes];
 -- Insertar datos en DetalleOrdenes
INSERT INTO DetalleOrden (OrdenesId, ProductosId, Cantidad, Precio) VALUES
(1, 1, 3, 23.44),
(1, 2, 5, 45.14),
(1, 3, 4, 46.37),
(1, 4, 4, 42.34),
(1, 5, 1, 18.25),
(1, 6, 4, 20.08),
(1, 7, 2, 13.31),
(1, 8, 2, 20.96),
(1, 9, 4, 30.13),
(1, 10, 3, 38.34);
SELECT *
FROM [dbo].[DetalleOrden];

-- Corrijo un error, agregué una columna que no corresponde en la tabla Sucursales

USE FastFoodDa;

 ALTER TABLE 
	[dbo].[Sucursales]
 DROP COLUMN 
	[CategoriasId];

