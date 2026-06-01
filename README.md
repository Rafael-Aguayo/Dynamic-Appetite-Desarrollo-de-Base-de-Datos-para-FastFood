# Dynamic Appetite: Desarrollo de Base de Datos para FastFood

> **Proyecto Integrador - Módulo 2 (DAPT08)**  
> **Autor:** Rafael Antonio Aguayo  
> **Contacto:** fenixequi3@gmail.com  
> **Fecha:** 29 de mayo de 2025  

---

## 📌 Introducción y Propósito del Proyecto

El propósito central de este proyecto consistió en centralizar, estructurar y gestionar información operativa y comercial que previamente se encontraba dispersa en archivos de Google Sheets y registros manuales. El objetivo principal fue realizar la transición hacia una **base de datos relacional consolidada**, garantizando la integridad de los datos, la escalabilidad del sistema y la eficiencia en la toma de decisiones estratégicas para una cadena de comida rápida (*FastFood*).

Con este desarrollo se logró una infraestructura sólida capaz de responder a consultas complejas sobre el rendimiento global de la empresa, permitiendo auditar movimientos diarios por sucursal, analizar tendencias de ventas, evaluar la eficiencia logística de entregas y comprender el comportamiento del consumidor según horarios y canales de atención.

---

## 🛠️ Tecnologías y Arquitectura del Sistema

* **Motor de Base de Datos:** SQL Server (T-SQL)
* **Enfoque de Diseño:** DDL (Data Definition Language) y DML (Data Manipulation Language)
* **Notación de Código:** Pascal Case (ej. `CategoriasId`, `DetalleOrden`)
* **Configuración de Almacenamiento:**
  * Creación de la base de datos `FastFoodDa`.
  * Archivo de datos inicial de **50 MB** (con crecimiento configurado hasta **1 GB**).
  * Archivo de registro (*Log*) de **25 MB** (con crecimiento configurado hasta **256 MB**).
  * Ruta física parametrizada en el servidor: `C:\FastFood_DA\`.

---

## 📐 Modelo de Datos y Diseño Relacional

El diseño se estructuró a partir de un **Diagrama Entidad-Relación (DER)** riguroso, implementando restricciones de clave primaria (`PRIMARY KEY IDENTITY`), claves foráneas (`FOREIGN KEY`) para preservar la integridad referencial y la regla `NOT NULL` en campos críticos de negocio para evitar la existencia de registros huérfanos o inconsistentes.

La creación de tablas siguió un orden lógico de dependencias (de tablas padre a tablas hijas):
1. **Tablas Maestras / Padre:** `Categorias`, `Sucursales`, `Clientes`, `OrigenesOrden`, `TiposDePago`, `Mensajero`.
2. **Tablas Dependientes / Hijas:** `Productos`, `Empleados`.
3. **Tablas Transaccionales (Eje Central):** `Ordenes` (centraliza las operaciones de venta) y `DetalleOrden` (conecta los productos específicos con cada transacción).

### 🗺️ Diagrama Entidad-Relación (DER)
Para visualizar la estructura del esquema relacional, puedes consultar el diagrama del modelo:

![Diagrama Entidad Relación](https://github.com/tu-usuario/tu-repositorio/raw/main/assets/der_fastfood.png) 
*(Nota: Asegúrate de subir tu imagen en una carpeta llamada assets y nombrarla der_fastfood.png)*

---

## 📊 Insights de Negocio y Análisis de Datos (DML)

A pesar de contar con una muestra inicial acotada para la fase de pruebas (10 órdenes y 10 empleados registrados en la sucursal central), la base de datos demostró su valor analítico al arrojar métricas e indicadores clave de rendimiento (KPIs):

### 1. Eficiencia Operativa en Sucursales
* **Hallazgo Histórico:** Se identificó a la **Sucursal Lago** como el modelo de máxima eficiencia operativa. Registra el promedio de ingresos por venta más alto de la cadena (**$1,095.00**) y, al mismo tiempo, el menor recorrido promedio de entrega (**3.0 Km**).
* **Acción Estratégica:** Investigar y documentar las prácticas de gestión de rutas de esta sucursal para replicarlas mediante capacitaciones y software de optimización de rutas en las ubicaciones menos eficientes.

### 2. Rendimiento de Canales de Venta
* El canal **Presencial** lidera la facturación total con **$2,140.00**, demostrando que el contacto directo sigue siendo el pilar de ingresos.
* Los canales **Drive Thru ($2,025.00)**, **Teléfono ($2,005.00)** y **En línea ($1,998.51)** muestran un rendimiento parejo y maduro.
* El canal **App Móvil** presenta el rendimiento más bajo (**$1,855.00**), revelando un área de oportunidad crítica para implementar promociones exclusivas y mejoras en la experiencia de usuario (UX).

### 3. Comportamiento Temporal y Estacionalidad
* **Crecimiento:** Las ventas del segundo semestre superaron al primero en un **5.67%**, marcando una tendencia positiva de crecimiento anual.
* **Dinámica de Horarios:** La **Mañana** concentra el mayor volumen de transacciones (4 órdenes), pero la **Tarde** registra el ticket promedio más alto (**$1,038.33** por orden). Por su parte, la **Noche** ostenta el importe máximo individual registrado (**$1,095.00**), ideal para estrategias de venta cruzada o combos grupales.

### 4. Logística y Auditoría de Tiempos (Cuello de Botella Identificado)
El análisis de tiempos reveló una oportunidad crítica de mejora en los flujos internos de trabajo:
* **Preparación en cocina:** 16 minutos (Eficiente).
* **Traslado del mensajero:** 30 minutos (Estable).
* **Espera Total del Cliente:** 63 minutos promedio.
* ⚠️ **El Cuello de Botella:** Existe un **tiempo muerto promedio de 17 minutos** entre que la cocina marca la "Orden Lista" y el mensajero efectivamente realiza el "Despacho". La estrategia prioritaria del negocio debe enfocarse en optimizar este traspaso mediante alertas automáticas y mejor asignación de turnos de mensajería.

---

## 📈 Sostenibilidad y Próximos Pasos (Visión de Futuro)

### Optimización del Esquema Financiero
Para subsanar la falta de trazabilidad de costos en el modelo actual, se proyecta la expansión de la base de datos mediante la incorporación de:
* Una tabla maestra de `CategoriaGastos` (Insumos, Sueldos, Alquiler, Marketing, etc.).
* Una tabla transaccional de `Gastos` para registrar egresos financieros.
* Una tabla de `Proveedores` y la adición del campo `SalarioBase` en la entidad `Empleados` para calcular márgenes reales de ganancia neta.

### 🧠 Reflexión Profesional
Este proyecto permitió consolidar las capacidades técnicas operativas en el uso de **T-SQL (DDL/DML)** bajo un entorno corporativo de SQL Server. Reconociendo que el rol del Analista de Datos se potencia al máximo al consumir estructuras optimizadas para la explotación de información, la evolución natural e ideal para una segunda etapa de este proyecto sería migrar la arquitectura actual hacia un **Data Warehouse (Almacén de Datos)**, diseñado específicamente para soportar grandes históricos analíticos y alimentar dashboards de inteligencia de negocios de manera óptima.
