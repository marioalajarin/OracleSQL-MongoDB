-- Procedimientos y funciones
--Contar del 1 al 10 con una estructura FOR:
CREATE OR REPLACE PROCEDURE contarFor IS
BEGIN
FOR contador IN 1..10 LOOP
DBMS_OUTPUT.PUT_LINE(contador);
END LOOP;
END;

SET SERVEROUTPUT ON;

call contarFor();

-- Contar del 1 al 10 con una estructura WHILE:
CREATE OR REPLACE PROCEDURE contarWhile IS
contador NUMBER := 0;
BEGIN
WHILE contador < 10 LOOP
contador := contador + 1;
DBMS_OUTPUT.PUT_LINE(contador);
END LOOP;
END;

SET SERVEROUTPUT ON;

call contarWhile();

--Contar del 1 al 10 con una estructura HASTA (loop):
CREATE OR REPLACE PROCEDURE contarloop IS
contador NUMBER := 0;
BEGIN
LOOP
contador := contador + 1;
DBMS_OUTPUT.PUT_LINE(contador);
EXIT WHEN contador = 15;
END LOOP;
END;

SET SERVEROUTPUT ON;

call contarloop();

--IF para determinar rango de edad:
CREATE OR REPLACE FUNCTION rangoEdad(edad IN NUMBER) RETURN VARCHAR2 IS
  estado VARCHAR2(20);
BEGIN
  IF edad < 18 THEN
    estado := 'menor';
  ELSIF edad < 65 THEN
    estado := 'mayor';
  ELSE
    estado := 'jubilado';
  END IF;
  
  RETURN estado;
END;

-- Probando la función
SET SERVEROUTPUT ON;
BEGIN
DBMS_OUTPUT.PUT_LINE(rangoEdad(25));
END;

--CASE para determinar rango de edad:
CREATE OR REPLACE FUNCTION rangoEdadCase(edad NUMBER) RETURN VARCHAR2 IS
  estado VARCHAR2(20);
BEGIN
  estado := CASE
    WHEN edad < 18 THEN 'menor'
    WHEN edad >= 18 AND edad < 65 THEN 'mayor'
    ELSE 'jubilado'
  END;
  
  RETURN estado;
END;

-- Probando la función
SET SERVEROUTPUT ON;
BEGIN
DBMS_OUTPUT.PUT_LINE(rangoEdadCase(25));
END;

--Crear una tabla con 25 triángulos:
CREATE TABLE TRIANGULOS (
LADO1 INTEGER,
LADO2 INTEGER,
LADO3 INTEGER
);
CREATE OR REPLACE PROCEDURE CREARTRIANGULOS IS
BEGIN
DELETE FROM TRIANGULOS;
FOR i IN 1..25 LOOP
INSERT INTO TRIANGULOS VALUES (
DBMS_RANDOM.VALUE(1, 100),
DBMS_RANDOM.VALUE(1, 100),
DBMS_RANDOM.VALUE(1, 100)
);
END LOOP;
COMMIT;
END;
-- Ejecutando la función para actualizar los triángulos.
CALL CREARTRIANGULOS()

--Procedimiento para obtener información de un cliente:
create or replace procedure infoCliente(nif_cli varchar) IS
  v_nombre VARCHAR(50);
  v_facturas integer;
BEGIN
  SELECT nombre INTO v_nombre FROM CLIENTE WHERE NIF=nif_cli;
  DBMS_OUTPUT.PUT_LINE('Cliente: '|| v_nombre);
  SELECT COUNT(numero) INTO v_facturas FROM FACTURA WHERE NIF=nif_cli;
  DBMS_OUTPUT.PUT_LINE('Facturas: '|| v_facturas);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontró ningún cliente NIF '|| nif_cli);
END;


-- Ejecutando el procedimiento.
call infoCliente('11111111A');


SELECT * FROM TRIANGULOS;

--



