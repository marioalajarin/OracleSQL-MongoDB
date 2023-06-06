-- 2
CREATE OR REPLACE TYPE tFamilia AS OBJECT(
    idFamilia int,
    familia varchar(100)
);

-- 3
CREATE TABLE FAMILIA OF tFamilia;

ALTER TABLE FAMILIA ADD PRIMARY KEY (idFamilia);

-- 4
insert into familia values (1, 'Aves');
insert into familia values (2, 'Mamíferos');
insert into familia values (3, 'Peces');


-- 5
CREATE OR REPLACE TYPE tNombres IS VARRAY(20) OF VARCHAR(50);

-- 6
CREATE OR REPLACE TYPE tAnimal AS OBJECT(
    idAnimal int,
    idFamilia int,
    Animal varchar(100),
    nombres tNombres,
    MEMBER FUNCTION ejemplares RETURN varchar
);

CREATE OR REPLACE TYPE BODY tAnimal AS
    MEMBER FUNCTION ejemplares RETURN VARCHAR IS
        numero_ejemplares int;
    BEGIN
        SELECT COUNT(*) INTO numero_ejemplares FROM ANIMAL WHERE idFamilia=self.idFamilia AND Animal=self.Animal;
        RETURN 'Hay '||numero_ejemplares||' animales de la especie '||self.Animal;
    END;
END;

-- 7

CREATE TABLE ANIMAL OF tAnimal;

-- 8

ALTER TABLE ANIMAL ADD PRIMARY KEY(idAnimal);

ALTER TABLE ANIMAL ADD CONSTRAINT fk_animal_familia FOREIGN KEY (idFamilia) REFERENCES familia(idFamilia);

-- 9

-- AVES
-- Garza
INSERT INTO animal VALUES(1,1,'Garza Real',tNombres('Calíope'));
INSERT INTO animal VALUES(2,1,'Garza Real',tNombres('Izaro'));
-- Cigüeña
INSERT INTO animal VALUES(3,1,'Cigüeña Blanca',tNombres('Perica'));
INSERT INTO animal VALUES(4,1,'Cigüeña Blanca',tNombres('Clara'));
INSERT INTO animal VALUES(5,1,'Cigüeña Blanca',tNombres('Miranda'));
-- Gorrión
INSERT INTO animal VALUES(6,1,'Gorrión',tNombres('coco'));
INSERT INTO animal VALUES(7,1,'Gorrión',tNombres('roco'));
INSERT INTO animal VALUES(8,1,'Gorrión',tNombres('loco'));
INSERT INTO animal VALUES(9,1,'Gorrión',tNombres('peco'));
INSERT INTO animal VALUES(10,1,'Gorrión',tNombres('rico'));

-- MAMÍFEROS
-- Zorro
INSERT INTO animal VALUES(11,2,'Zorro',tNombres('Lucas'));
INSERT INTO animal VALUES(12,2,'Zorro',tNombres('Mario'));
-- Lobo
INSERT INTO animal VALUES(13,2,'Lobo',tNombres('Pedro'));
INSERT INTO animal VALUES(14,2,'Lobo',tNombres('Pablo'));
-- Ciervo
INSERT INTO animal VALUES(15,2,'Ciervo',tNombres('Bravo'));
INSERT INTO animal VALUES(16,2,'Ciervo',tNombres('Listo'));
INSERT INTO animal VALUES(17,2,'Ciervo',tNombres('Rojo'));
INSERT INTO animal VALUES(18,2,'Ciervo',tNombres('Astuto'));

-- PECES
-- Pez Globo
INSERT INTO animal VALUES(19,3,'Pez globo',tNombres('Mike'));
-- Pez Payaso
INSERT INTO animal VALUES(20,3,'Pez payaso',tNombres('Tom'));
-- Ángel llama
INSERT INTO animal VALUES(21,3,'Ángel llama',tNombres('Paco'));

-- 10
SELECT a.animal, f.familia, a.ejemplares() FROM animal a
INNER JOIN familia f ON a.idFamilia=f.idFamilia;

DROP TABLE ANIMAL;