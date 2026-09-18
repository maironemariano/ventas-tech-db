USE Ventas_Tech_DB;

--RESUMEN EJECUTIVO MENSUAL
SELECT
MONTH(fecha_venta) AS mes,
SUM(cantidad*precio_unitario) AS total_facturado,
COUNT(*) AS cantidad_pedidos,
SUM(Cantidad*precio_unitario) / COUNT(*) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- RANKING DE PRODUCTOS

SELECT TOP (5)
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- CLIENTES RECURRENTES
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY id_cliente;

--COMPARAR CADA MES CON EL PROMEDIO
WITH resumen_mensual AS (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_mensual
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT
    mes,
    total_mensual,
    CASE
        WHEN total_mensual > (SELECT AVG(total_mensual) FROM resumen_mensual)
            THEN 'Por encima'
        WHEN total_mensual < (SELECT AVG(total_mensual) FROM resumen_mensual)
            THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS comparacion_promedio
FROM resumen_mensual
ORDER BY mes;
-- Hallazgos:
-- 1. En marzo de 2024 se facturaron 6444 en 10 pedidos; el ticket promedio fue 644,40.
-- 2. El producto con id_producto 1 generó 3600, aproximadamente el 55,9 % de la facturación total.
-- 3. Los cinco clientes registrados realizaron 2 pedidos cada uno.
