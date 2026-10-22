USE calzados_sa;
-- Integrantes: Julian Paglialunga, Genaro Francisco Oviedo, Mariano Antonelli, Ricardo Xavier Cardozo, Federico Andres Baumgartner.

-- 1. Zapatos y talles
INSERT INTO zapato (MODELO, COLOR, PRECIO) 
VALUES 
	('MOCASIN NAUTICO WOLF', 'NEGRO', 67400),
    ('STILETTO ANGRA', 'ROJO', 62900),
    ('ZAPATO VESTIR VULCANO', 'NEGRO', 40000),
    ('BORCEGO BRIGANTI', 'MARRON', 186000),
    ('BOTAS CATALANA', 'BLANCO Y NEGRO', 90000);

INSERT INTO talle (NUMERO) 
VALUES 
	(34), (35), (36), (37), (38), (39), (40), (41), (42), (43);

-- 2. Proveedores
INSERT INTO proveedor (CUIT, TEL_FIJO, DIRECCION, RAZON_SOCIAL) 
VALUES 
	('30500525327', '011-4000-1000', 'Buenos Aires 120', 'WOLF ARGENTINA S.A.'),
    ('30505687279', '0383-6509-200', 'Catamarca 464', 'ANGRA & CATALANA S.A.'),
    ('30649959265', '011-4200-3000', 'San MArtín 600', 'BRIGANTI S.R.L.'),
    ('30636478295', '0358-2589-200', 'Constitución 900', 'VULCANO COMPANY');
    
INSERT INTO mcelular (CELULAR, CUITPROVEEDOR) 
VALUES 
	('351 400-0001', '30500525327'),
    ('351 400-0002', '30500525327'),
    ('358 400-0001', '30505687279'),
    ('221 400-0001', '30649959265'),
    ('11 4000-0001', '30636478295'),
    ('11 4000-0002', '30636478295');

-- 3. Personas, clientes y vendedores

INSERT INTO persona (DNI, NOMBRE, APELLIDO, DIRECCION)
VALUES
    (30111222, 'Juan', 'Perez', 'San Martin 120'),
    (28444555, 'Maria', 'Gomez', 'Belgrano 450'),
    (35666777, 'Lucas', 'Fernandez', 'Rivadavia 320'),
    (32123456, 'Sofia', 'Martinez', 'Constitucion 800'),
    (29888777, 'Carlos', 'Rodriguez', 'Alvear 560'),
    (40111222, 'Ana', 'Lopez', 'Mitre 230'),
    (37999888, 'Pedro', 'Sanchez', 'Sarmiento 750');

-- Clientes
INSERT INTO cliente (DNI)
VALUES
    (30111222),
    (28444555),
    (35666777),
    (40111222);

-- Clientes mayoristas
INSERT INTO mayorista (DNI, DESCUENTO_GENERAL)
VALUES
    (30111222, 15.00),
    (28444555, 10.00);

-- Clientes minoristas
INSERT INTO minorista (DNI, FECHA_NACIMIENTO)
VALUES
    (35666777, '1998-05-12'),
    (40111222, '2001-09-23');

-- Vendedores
INSERT INTO vendedor (DNI)
VALUES
    (32123456),
    (29888777),
    (37999888);


-- 4. Stock y proveedores de zapatos

INSERT INTO tiene (MODELO, COLOR, NUMERO, CANTIDAD)
VALUES
    ('MOCASIN NAUTICO WOLF', 'NEGRO', 38, 10),
    ('MOCASIN NAUTICO WOLF', 'NEGRO', 39, 8),
    ('MOCASIN NAUTICO WOLF', 'NEGRO', 40, 12),
    ('STILETTO ANGRA', 'ROJO', 36, 5),
    ('STILETTO ANGRA', 'ROJO', 37, 7),
    ('STILETTO ANGRA', 'ROJO', 38, 6),
    ('ZAPATO VESTIR VULCANO', 'NEGRO', 39, 10),
    ('ZAPATO VESTIR VULCANO', 'NEGRO', 40, 8),
    ('ZAPATO VESTIR VULCANO', 'NEGRO', 41, 6),
    ('BORCEGO BRIGANTI', 'MARRON', 40, 4),
    ('BORCEGO BRIGANTI', 'MARRON', 41, 7),
    ('BORCEGO BRIGANTI', 'MARRON', 42, 5),
    ('BOTAS CATALANA', 'BLANCO Y NEGRO', 37, 3),
    ('BOTAS CATALANA', 'BLANCO Y NEGRO', 38, 4),
    ('BOTAS CATALANA', 'BLANCO Y NEGRO', 39, 6);

-- Proveedores de cada modelo y color
INSERT INTO provee (MODELO, COLOR, CUIT)
VALUES
    ('MOCASIN NAUTICO WOLF', 'NEGRO', '30500525327'),
    ('STILETTO ANGRA', 'ROJO', '30505687279'),
    ('BOTAS CATALANA', 'BLANCO Y NEGRO', '30505687279'),
    ('BORCEGO BRIGANTI', 'MARRON', '30649959265'),
    ('ZAPATO VESTIR VULCANO', 'NEGRO', '30636478295');


-- 5. Ventas y sus detalles

INSERT INTO venta
    (NUM_FACTURA, FECHA, MONTO, DNI, NRO_VENDEDOR, DESCUENTO)
VALUES
    (
        1001, '2026-10-10', 114580.00, 30111222,
        (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 32123456),
        15.00
    ),
    (
        1002, '2026-10-12', 125800.00, 35666777,
        (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 29888777),
        0.00
    ),
    (
        1003, '2026-10-15', 167400.00, 28444555,
        (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 37999888),
        10.00
    ),
    (
        1004, '2026-10-18', 90000.00, 40111222,
        (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 32123456),
        0.00
    );

-- Detalle de los productos vendidos
INSERT INTO vendido
    (NUM_FACTURA, MODELO, COLOR, NUMERO, CANT_VENDIDO, PRECIO_VENTA)
VALUES
    (1001, 'MOCASIN NAUTICO WOLF', 'NEGRO', 38, 2, 67400.00),
    (1002, 'STILETTO ANGRA', 'ROJO', 37, 2, 62900.00),
    (1003, 'BORCEGO BRIGANTI', 'MARRON', 41, 1, 186000.00),
    (1004, 'BOTAS CATALANA', 'BLANCO Y NEGRO', 38, 1, 90000.00);


-- 6. Horarios, días y francos

INSERT INTO dia (NOMBRE_DIA)
VALUES
    ('Lunes'),
    ('Martes'),
    ('Miercoles'),
    ('Jueves'),
    ('Viernes'),
    ('Sabado'),
    ('Domingo');

INSERT INTO horario
    (NOMBRE_DIA, NRO_VENDEDOR, H_ENTRADA, H_SALIDA)
VALUES
    ('Lunes',     (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 32123456), '09:00:00', '18:00:00'),
    ('Martes',    (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 32123456), '09:00:00', '18:00:00'),
    ('Miercoles', (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 32123456), '09:00:00', '18:00:00'),

    ('Jueves',    (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 29888777), '09:00:00', '18:00:00'),
    ('Viernes',   (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 29888777), '09:00:00', '18:00:00'),
    ('Sabado',    (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 29888777), '09:00:00', '13:00:00'),

    ('Lunes',     (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 37999888), '10:00:00', '19:00:00'),
    ('Miercoles', (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 37999888), '10:00:00', '19:00:00'),
    ('Viernes',   (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 37999888), '10:00:00', '19:00:00');

-- Francos de los vendedores
INSERT INTO franco (FECHA, OBSERVACION, NRO_VENDEDOR)
VALUES
    (
        '2026-10-11',
        'Franco semanal',
        (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 32123456)
    ),
    (
        '2026-10-13',
        'Franco semanal',
        (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 29888777)
    ),
    (
        '2026-10-17',
        'Franco semanal',
        (SELECT NRO_VENDEDOR FROM vendedor WHERE DNI = 37999888)
    );