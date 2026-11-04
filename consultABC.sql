USE calzados_sa;

-- Consulta a) Número más vendido por modelo
SELECT MODELO, NUMERO, SUM(CANT_VENDIDO) AS TOTAL_VENDIDO
FROM vendido
GROUP BY MODELO, NUMERO
HAVING SUM(CANT_VENDIDO) >= ALL (
    SELECT SUM(CANT_VENDIDO)
    FROM vendido AS v
    WHERE v.MODELO = vendido.MODELO
    GROUP BY v.MODELO, v.NUMERO
);

-- Consulta b) Ventas totales de vendedores durante 2025 
SELECT vend.NRO_VENDEDOR, p.APELLIDO, p.NOMBRE, COALESCE(SUM(vent.MONTO), 0) AS VENTAS_TOTALES 
FROM vendedor vend
INNER JOIN persona p 
	ON vend.DNI = p.DNI
LEFT JOIN venta vent
    ON vend.NRO_VENDEDOR = vent.NRO_VENDEDOR
    AND vent.FECHA >= '2025-01-01'
    AND vent.FECHA < '2026-01-01'
GROUP BY vend.NRO_VENDEDOR, p.APELLIDO, p.NOMBRE;

-- Consulta c) Vendedores sin francos en enero de 2026
SELECT p.APELLIDO, p.NOMBRE
FROM vendedor v
INNER JOIN persona p ON v.DNI = p.DNI
WHERE NOT EXISTS (
    SELECT 1
    FROM franco f
    WHERE f.NRO_VENDEDOR = v.NRO_VENDEDOR
      AND f.FECHA >= '2026-01-01'
      AND f.FECHA < '2026-02-01'
);

-- Consulta d1) Listar los zapatos cuyo stock disponible sea inferior a una cantidad determinada.
SELECT t.MODELO, t.COLOR, t.NUMERO, t.CANTIDAD 
FROM tiene t
WHERE (t.CANTIDAD < 4);

-- Consulta d2) Identificar los clientes que todavía no registran ninguna venta.
SELECT p.DNI, p.APELLIDO, p.NOMBRE
FROM cliente c
INNER JOIN persona p ON c.DNI = p.DNI
LEFT JOIN venta v ON c.DNI = v.DNI
WHERE v.NUM_FACTURA IS NULL;

-- Consulta d3) Obtener los modelos cuya recaudación total supera el importe promedio vendido por modelo.
SELECT v.MODELO, SUM(v.CANT_VENDIDO * v.PRECIO_VENTA) AS RECAUDACION_TOTAL
FROM vendido v
GROUP BY v.MODELO
HAVING RECAUDACION_TOTAL > (
    SELECT AVG(t.TOTAL)
    FROM (
        SELECT SUM(CANT_VENDIDO * PRECIO_VENTA) AS TOTAL
        FROM vendido
        GROUP BY MODELO
    ) AS t
);
