USE calzados_sa;

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
SELECT v.MODELO,
       SUM(v.CANT_VENDIDO * v.PRECIO_VENTA) AS RECAUDACION_TOTAL
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