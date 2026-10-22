# RetailPro

Proyecto académico del curso de **Data Analytics**, desarrollado por **Mariano Mairone**.

Repositorio: [https://github.com/maironemariano/ventas-tech-db](https://github.com/maironemariano/ventas-tech-db)

## Propósito

RetailPro analiza datos de ventas de una empresa de tecnología. El proyecto incluye una base y consultas de ejemplo en SQL Server, y un proceso de transformación, modelado y medidas en Power BI a partir del dataset Excel documentado en el módulo 6.

## Herramientas utilizadas

- SQL Server
- SQL Server Management Studio 22 (SSMS)
- Power BI Desktop
- Power Query
- DAX
- GitHub

## Requisitos

- Una instancia de SQL Server accesible y SSMS 22 para ejecutar los scripts.
- Power BI Desktop para abrir los archivos `.pbix`.
- El archivo original `Pipeline_ETL_Dataset.xlsx` para actualizar los datos del ETL documentado; ese Excel no está incluido en el repositorio.
- Permisos para crear bases de datos y tablas en la instancia.

## Contenido del repositorio

Todos los archivos están en la raíz:

| Archivo                             | Descripción                                                                                                                                                                     |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `ventas_tech_db.sql`                | Crea la base `Ventas_Tech_DB` si no existe, elimina las tablas `ventas`, `productos`, `clientes` y `categorias` si existen, las recrea con sus claves y carga datos de ejemplo. |
| `m4_consultas_negocio.sql`          | Consultas de negocio: resumen mensual, ranking de productos, clientes recurrentes y comparación de cada mes con el promedio.                                                    |
| `m5_consultas_joins.sql`            | Consultas con `INNER JOIN`, `LEFT JOIN` y `UNION ALL`.                                                                                                                          |
| `Pipeline_ETL_Mairone_Mariano.pbix` | Trabajo de conexión y transformación de datos en Power Query.                                                                                                                   |
| `Mairone_Mariano_Checkpoint2.pbix`  | Modelo con dimensiones, calendario y cinco medidas DAX.                                                                                                                         |

## Cómo ejecutar los scripts SQL

> ⚠️ **Advertencia:** `ventas_tech_db.sql` elimina las tablas `ventas`, `productos`, `clientes` y `categorias` antes de recrearlas. **Volver a ejecutarlo borra los datos existentes en esas tablas.** Si tenés información que quieras conservar, hacé una copia de seguridad antes.

Seguí este orden:

1. Abrí SSMS y conectate a tu instancia de SQL Server.
2. Abrí `ventas_tech_db.sql` (menú *Archivo > Abrir > Archivo*) y ejecutalo con **F5**. Esto crea la base `Ventas_Tech_DB`, sus tablas y los datos de ejemplo.
3. Abrí `m4_consultas_negocio.sql`. Antes de ejecutarlo, asegurate de estar usando la base correcta: seleccioná `Ventas_Tech_DB` en el selector de bases de datos de SSMS o ejecutá:
   ```sql
   USE Ventas_Tech_DB;

   ```
4. Ejecutá las consultas que quieras revisar.
5. Repetí el paso 3 con `m5_consultas_joins.sql`.

Los scripts `m4` y `m5` dependen de que `ventas_tech_db.sql` se haya ejecutado primero.

### Control de los datos de ejemplo SQL

Después de cargar los datos, ejecutá esta consulta de lectura:

```sql
USE Ventas_Tech_DB;

SELECT
    COUNT(*) AS registros_venta,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas;
```

Para la carga de ejemplo validada en SSMS, el resultado es **10 registros** y **6.444,00 de facturación calculada**. Este control aplica exclusivamente a los datos SQL de ejemplo; cambiarán los resultados si se modifica esa carga.

## Cómo abrir los archivos de Power BI

1. Abrí Power BI Desktop.
2. Elegí *Archivo > Abrir* y seleccioná `Pipeline_ETL_Mairone_Mariano.pbix` o `Mairone_Mariano_Checkpoint2.pbix`.

### Fuente documentada y actualización

El ETL del módulo 6 utiliza el archivo Excel `Pipeline_ETL_Dataset.xlsx`. El modelo del checkpoint 2 continúa ese trabajo. Para actualizar los datos, necesitás disponer del Excel original y ajustar su ruta local:

1. En Power BI Desktop, abrí *Archivo > Opciones y configuración > Configuración de origen de datos*.
2. Revisá los orígenes del archivo actual y seleccioná el correspondiente al Excel.
3. En *Cambiar origen*, indicá la ubicación de `Pipeline_ETL_Dataset.xlsx` en tu equipo y confirmá.
4. Actualizá los datos y comprobá que las consultas carguen correctamente.

Los scripts SQL y el ETL de Excel son actividades documentadas del proyecto con fuentes distintas. Crear `Ventas_Tech_DB` permite ejecutar los scripts SQL; actualizar estos PBIX requiere el Excel indicado.

## Alcance de las consultas de negocio

- El resumen mensual agrupa por `MONTH(fecha_venta)`, sin año. Si se incorporan varios años, deberá incluirse también el año en la agrupación para distinguir sus meses.
- `cantidad_pedidos` utiliza `COUNT(*)` y cuenta registros de `ventas`; su interpretación como pedidos depende de qué representa cada fila. El promedio calculado corresponde a esos registros.
- El ranking utiliza `TOP (5)`: muestra los cinco productos con mayor facturación y puede excluir otros productos. Sus porcentajes de unidades deben indicar si la base es el ranking o todas las ventas.

## Autor

**Mariano Mairone**: [github.com/maironemariano](https://github.com/maironemariano)
