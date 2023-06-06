-- PRODUCTO

CREATE OR REPLACE TYPE tProducto AS OBJECT (
    id_producto int,
    nombre_producto varchar(100),
    categoria varchar(100),
    disponibilidad char(3),
    precio float,
    dimensiones_producto_talla varchar(50),
    MEMBER FUNCTION getProducto RETURN varchar
);

CREATE OR REPLACE TYPE BODY tProducto AS 
    MEMBER FUNCTION getProducto RETURN varchar IS
    BEGIN
        RETURN '¿El producto '||nombre_producto||' está disponible?: '||disponibilidad;
    END;
END;

CREATE TABLE producto of tProducto;

ALTER TABLE producto ADD PRIMARY KEY (id_producto);

-- CLIENTE

CREATE OR REPLACE TYPE tCliente AS OBJECT (
    CIF varchar(10),
    razon_social varchar(100),
    nombre_contacto varchar(100),
    tipo_empresa varchar(100),
    ciudad varchar(100),
    tlf varchar(100),
    MEMBER FUNCTION getDatosCliente RETURN varchar,
    MEMBER FUNCTION getDatosCiudadTlf RETURN varchar
);

CREATE OR REPLACE TYPE BODY tCliente AS
    MEMBER FUNCTION getDatosCliente RETURN varchar IS
    BEGIN
        RETURN 'Nombre de empresa: '||razon_social||' Tipo de empresa: '||tipo_empresa;
    END;
    MEMBER FUNCTION getDatosCiudadTlf RETURN varchar IS
    BEGIN
        RETURN 'Ciudad: '||ciudad||' Teléfono: '||tlf;
    END;
END;

CREATE TABLE cliente of tCliente;

ALTER TABLE cliente ADD PRIMARY KEY (CIF);
    
-- PEDIDO

CREATE OR REPLACE TYPE tPedido AS OBJECT (
    id_pedido int,
    fecha date,
    gastos_transporte float,
    CIF varchar(10),
    MEMBER FUNCTION getPedido RETURN varchar
);

CREATE OR REPLACE TYPE BODY tPedido AS 
    MEMBER FUNCTION getPedido RETURN varchar IS
    BEGIN
        RETURN 'Fecha de pedido: '||fecha;
    END;
END;

CREATE TABLE pedido of tPedido;

ALTER TABLE pedido ADD PRIMARY KEY (id_pedido);

ALTER TABLE pedido ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (CIF) REFERENCES cliente(CIF);

-- PRODUCTO-PEDIDO


CREATE OR REPLACE TYPE tProductoPedido AS OBJECT (
    id_producto int,
    id_pedido int,
    precio float,
    MEMBER FUNCTION getProductoPedido RETURN varchar
);

CREATE TABLE producto_pedido of tProductoPedido;

ALTER TABLE producto_pedido 
ADD CONSTRAINT fk_id_producto
FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

ALTER TABLE producto_pedido
ADD CONSTRAINT fk_id_pedido
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

-- VEHICULO

CREATE OR REPLACE TYPE tVehiculo AS OBJECT (
    matricula varchar(100),
    marca_vehiculo varchar(100),
    modelo_vehiculo varchar(100),
    MEMBER FUNCTION getVehiculo RETURN varchar
);

CREATE TABLE vehiculo of tVehiculo;

ALTER TABLE vehiculo ADD PRIMARY KEY(matricula);

-- ORDEN TRANSPORTE

CREATE OR REPLACE TYPE tOrden_transporte AS OBJECT (
    id_orden_transporte int,
    direccion varchar(100),
    fecha_entrega date,
    fecha_recogida date,
    id_pedido int,
    matricula_entrega varchar(100),
    matricula_recogida varchar(100),
    MEMBER FUNCTION getOrden_transporte RETURN int
);

CREATE OR REPLACE TYPE BODY tOrden_transporte AS
    MEMBER FUNCTION getOrden_transporte RETURN int IS
        v_fecha_entrega VARCHAR2(20);
        v_fecha_recogida VARCHAR2(20);
        v_days NUMBER;
    BEGIN
        v_fecha_entrega := TO_CHAR(fecha_entrega, 'DD/MM/YYYY');
        v_fecha_recogida := TO_CHAR(fecha_recogida, 'DD/MM/YYYY');
        v_days := TO_DATE(v_fecha_recogida,'DD/MM/YYYY') - TO_DATE(v_fecha_entrega,'DD/MM/YYYY');
        RETURN v_days;
    END;
END;

CREATE TABLE orden_transporte of tOrden_transporte;

ALTER TABLE orden_transporte ADD PRIMARY KEY (id_orden_transporte);

ALTER TABLE orden_transporte ADD CONSTRAINT fk_orden_transporte_pedido
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);

ALTER TABLE orden_transporte ADD CONSTRAINT fk_orden_transporte_matricula_entrega
FOREIGN KEY (matricula_entrega) REFERENCES vehiculo(matricula);

ALTER TABLE orden_transporte ADD CONSTRAINT fk_orden_transporte_matricula_recogida
FOREIGN KEY (matricula_recogida) REFERENCES vehiculo(matricula);


-- INSERT INTO

-- producto

INSERT INTO producto VALUES (1, 'Espada medieval', 'Armas', 'No', 49.99, '1 metro');
INSERT INTO producto VALUES (2, 'Sombrero de copa', 'Accesorios', 'Sí', 19.99, 'Talla única');
INSERT INTO producto VALUES (3, 'Botas de vaquero', 'Calzado', 'Sí', 59.99, '42');
INSERT INTO producto VALUES (4, 'Pistola de juguete', 'Armas', 'Sí', 14.99, '20 cm');
INSERT INTO producto VALUES (5, 'Réplica de la Estatua de la Libertad', 'Decoración', 'No', 299.99, '1 metro');
INSERT INTO producto VALUES (6, 'Lámpara de lava', 'Decoración', 'Sí', 39.99, '30 cm');
INSERT INTO producto VALUES (7, 'Gafas de aviador', 'Accesorios', 'Sí', 39.99, 'Única');
INSERT INTO producto VALUES (8, 'Chaqueta de cuero', 'Ropa', 'Sí', 99.99, 'M');
INSERT INTO producto VALUES (9, 'Globo terráqueo antiguo', 'Decoración', 'Sí', 59.99, '30 cm');
INSERT INTO producto VALUES (10, 'Busto de Beethoven', 'Decoración', 'No', 89.99, '20 cm');

-- cliente

INSERT INTO cliente VALUES ('A1234567', 'Empresa ABC', 'Juan Pérez', 'Cine', 'Madrid', '911234567');
INSERT INTO cliente VALUES ('B9876543', 'Empresa XYZ', 'María García', 'Teatro', 'Barcelona', '932345678');

-- pedido CAMBIAR DATE

INSERT INTO pedido VALUES (1, '15/05/2023', 10.0, 'A1234567');
INSERT INTO pedido VALUES (2, '16/05/2023', 5.0, 'B9876543');
INSERT INTO pedido VALUES (3, '16/05/2023', 0.0, 'A1234567');
INSERT INTO pedido VALUES (4, '17/05/2023', 15.0, 'B9876543');
INSERT INTO pedido VALUES (5, '18/05/2023', 20.0, 'A1234567');

-- producto_pedido

INSERT INTO producto_pedido VALUES (2, 1, 19.99);
INSERT INTO producto_pedido VALUES (3, 1, 59.99);
INSERT INTO producto_pedido VALUES (4, 2, 14.99);
INSERT INTO producto_pedido VALUES (10, 3, 89.99);
INSERT INTO producto_pedido VALUES (5, 4, 299.99);

-- vehiculo

INSERT INTO vehiculo VALUES ('1234-ABC', 'Ford', 'Focus');
INSERT INTO vehiculo VALUES ('5678-DEF', 'Renault', 'Clio');
INSERT INTO vehiculo VALUES ('9012-GHI', 'Citroën', 'C4');
INSERT INTO vehiculo VALUES ('3456-JKL', 'Opel', 'Corsa');
INSERT INTO vehiculo VALUES ('7890-MNO', 'Peugeot', '308');

-- orden_transporte

INSERT INTO orden_transporte VALUES (1, 'Calle Mayor 1, Madrid', '20/05/2023', '25/05/2023', 1, '1234-ABC', '5678-DEF');
INSERT INTO orden_transporte VALUES (2, 'Calle Diagonal 2, Barcelona', '21/05/2023', '26/05/2023', 2, '5678-DEF', '9012-GHI');
INSERT INTO orden_transporte VALUES (3, 'Calle Sevilla 3, Barcelona', '22/05/2023', '27/05/2023', 4, '9012-GHI', '3456-JKL');
INSERT INTO orden_transporte VALUES (4, 'Calle Valencia 4, Madrid', '23/05/2023', '28/05/2023', 3, '3456-JKL', '7890-MNO');
INSERT INTO orden_transporte VALUES (5, 'Calle Gran Vía 5, Madrid', '24/05/2023', '29/05/2023', 5, '7890-MNO', '1234-ABC');


SELECT * FROM producto_pedido;

-- SELECTS


SELECT p.id_producto,p.nombre_producto,p.disponibilidad FROM producto p ORDER BY p.nombre_producto;

SELECT c.* FROM cliente c INNER JOIN pedido pe ON c.CIF=pe.CIF;

SELECT p.nombre_producto, pp.precio FROM producto p 
INNER JOIN producto_pedido pp ON  p.id_producto=pp.id_producto
INNER JOIN pedido pe ON pp.id_pedido=pe.id_pedido WHERE pe.id_pedido=1;

SELECT COUNT(*) AS TOTAL_PRODUCTOS_EN_PEDIDO FROM producto_pedido WHERE id_pedido=2;

SELECT pe.fecha, COUNT(pe.id_pedido), SUM(pe.gastos_transporte)
FROM pedido pe
GROUP BY pe.fecha;

SELECT p.* FROM producto p 
INNER JOIN producto_pedido pp ON p.id_producto=pp.id_producto
INNER JOIN pedido pe ON pp.id_pedido=pe.id_pedido WHERE pe.CIF='A1234567';

SELECT ot.*, v1.marca_vehiculo as marca_entrega, v1.modelo_vehiculo as modelo_entrega, v2.marca_vehiculo as marca_recogida, v2.modelo_vehiculo as modelo_recogida
FROM orden_transporte ot
INNER JOIN vehiculo v1 ON ot.matricula_entrega=v1.matricula
INNER JOIN vehiculo v2 ON ot.matricula_recogida=v2.matricula;

SELECT ot.id_orden_transporte, ot.fecha_entrega, ot.fecha_recogida, ot.getOrden_transporte() as DIAS_DE_ENTREGA FROM orden_transporte ot;

SELECT p.*, pp.precio, pe.fecha, c.razon_social FROM producto p
INNER JOIN producto_pedido pp ON p.id_producto = pp.id_producto
INNER JOIN pedido pe ON pp.id_pedido = pe.id_pedido
INNER JOIN cliente c ON pe.CIF = c.CIF;

SELECT c.*,p.nombre_producto, p.categoria FROM cliente c
INNER JOIN pedido pe ON c.CIF=pe.CIF
INNER JOIN producto_pedido pp ON pe.id_pedido=pp.id_pedido
INNER JOIN producto p ON pp.id_producto=p.id_producto
WHERE p.categoria='Armas';

SELECT p.nombre_producto, pp.precio, pe.fecha
FROM producto p
INNER JOIN producto_pedido pp ON p.id_producto = pp.id_producto
INNER JOIN pedido pe ON pp.id_pedido = pe.id_pedido
WHERE pe.fecha BETWEEN '15/05/2023' AND '17/05/2023';

SELECT c.*
FROM cliente c
INNER JOIN pedido pe ON c.CIF = pe.CIF
INNER JOIN producto_pedido pp ON pe.id_pedido = pp.id_pedido
INNER JOIN producto p ON pp.id_producto = p.id_producto
WHERE p.disponibilidad = 'No';

SELECT p.nombre_producto, pp.precio, pe.fecha
FROM producto p
INNER JOIN producto_pedido pp ON p.id_producto = pp.id_producto
INNER JOIN pedido pe ON pp.id_pedido = pe.id_pedido
INNER JOIN cliente c ON pe.CIF = c.CIF
WHERE c.razon_social = 'Empresa ABC';

UPDATE producto p SET p.precio = p.precio * 0.9 WHERE p.precio > 100;
SELECT * FROM producto;

SELECT p.nombre_producto, COUNT(pp.id_pedido), SUM(pp.precio)
FROM producto p
INNER JOIN producto_pedido pp ON p.id_producto = pp.id_producto
GROUP BY p.nombre_producto;

SELECT c.*
FROM cliente c
INNER JOIN pedido pe ON c.CIF = pe.CIF
INNER JOIN producto_pedido pp ON pe.id_pedido = pp.id_pedido
INNER JOIN producto p ON pp.id_producto = p.id_producto
WHERE pp.precio > 100;

SELECT p.nombre_producto, pp.precio, pe.fecha
FROM producto p
INNER JOIN producto_pedido pp ON p.id_producto = pp.id_producto
INNER JOIN pedido pe ON pp.id_pedido = pe.id_pedido
INNER JOIN cliente c ON pe.CIF = c.CIF
WHERE c.ciudad = 'Barcelona';

SELECT c.*
FROM cliente c
INNER JOIN pedido pe ON c.CIF = pe.CIF
INNER JOIN producto_pedido pp ON pe.id_pedido = pp.id_pedido
INNER JOIN producto p ON pp.id_producto = p.id_producto
INNER JOIN orden_transporte ot ON pe.id_pedido = ot.id_pedido
INNER JOIN vehiculo v ON ot.matricula_entrega = v.matricula
WHERE p.categoria = 'Accesorios' AND v.marca_vehiculo = 'Ford';


DELETE FROM producto p WHERE p.categoria = 'Ropa' AND p.disponibilidad = 'No';
SELECT * FROM producto;

UPDATE cliente c SET c.razon_social = 'Empresa 123ABC' WHERE c.razon_social='Empresa ABC';
SELECT * FROM cliente;


DROP TABLE CLIENTE;
DROP TABLE ORDEN_TRANSPORTE;
DROP TABLE PEDIDO;
DROP TABLE PRODUCTO;
DROP TABLE PRODUCTO_PEDIDO;
DROP TABLE VEHICULO;

CREATE OR REPLACE PROCEDURE obtener_articulos IS
    CURSOR c_articulos IS
        SELECT nombre_producto,categoria,precio FROM producto;
    
    v_nombre_prod producto.nombre_producto%TYPE;
    v_categoria producto.categoria%TYPE;
    v_precio producto.precio%TYPE;
    BEGIN
        OPEN c_articulos;
        LOOP
            FETCH c_articulos INTO v_nombre_prod, v_categoria, v_precio;
            EXIT WHEN c_articulos%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('Nombre del producto: '||v_nombre_prod);
            DBMS_OUTPUT.PUT_LINE('Categoría: '||v_categoria);
            DBMS_OUTPUT.PUT_LINE('Precio: '||v_precio);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_articulos;
    END obtener_articulos;

SET SERVEROUTPUT ON;
call obtener_articulos();