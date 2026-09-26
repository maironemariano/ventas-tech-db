USE Ventas_Tech_DB;
GO

-- CONSULTA 1: VISTA BASE DEL PROYECTO CON INNER JOIN
SELECT
    ventas.fecha_venta,
    ventas.id_cliente,
    clientes.nombre,
    clientes.ciudad,
    productos.nombre_producto,
    categorias.nombre_categoria,
    ventas.cantidad,
    ventas.precio_unitario,
    ventas.cantidad * ventas.precio_unitario AS total_venta
FROM ventas
INNER JOIN clientes
    ON ventas.id_cliente = clientes.id_cliente
INNER JOIN productos
    ON ventas.id_producto = productos.id_producto
INNER JOIN categorias
    ON productos.id_categoria = categorias.id_categoria;

-- CONSULTA 2: CLIENTES SIN VENTAS CON LEFT JOIN
SELECT
    clientes.nombre,
    clientes.email,
    clientes.fecha_registro
FROM clientes
LEFT JOIN ventas
    ON clientes.id_cliente = ventas.id_cliente
WHERE ventas.id_venta IS NULL;

-- CONSULTA 3: PRODUCTOS SIN VENTAS CON LEFT JOIN
SELECT
    productos.nombre_producto,
    categorias.nombre_categoria,
    productos.precio
FROM productos
INNER JOIN categorias
    ON productos.id_categoria = categorias.id_categoria
LEFT JOIN ventas
    ON productos.id_producto = ventas.id_producto
WHERE ventas.id_venta IS NULL;


-- CONSULTA 4: CONSOLIDADO POR CANAL CON UNION ALL
SELECT
    ventas_por_canal.canal,
    SUM(ventas_por_canal.total_venta) AS total_por_canal
FROM (
    SELECT
        ventas.fecha_venta,
        ventas.cantidad * ventas.precio_unitario AS total_venta,
        'Inicio de marzo' AS canal
    FROM ventas
    WHERE ventas.fecha_venta BETWEEN '2024-03-05' AND '2024-03-10'

    UNION ALL

    SELECT
        ventas.fecha_venta,
        ventas.cantidad * ventas.precio_unitario AS total_venta,
        'Mitad de marzo' AS canal
    FROM ventas
    WHERE ventas.fecha_venta BETWEEN '2024-03-11' AND '2024-03-15'
) AS ventas_por_canal
GROUP BY ventas_por_canal.canal;