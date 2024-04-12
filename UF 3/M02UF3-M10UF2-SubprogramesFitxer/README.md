# EXERCICIS SubProgramesFitxer

## ACTIVITAT - EXERCICIS SUBPROGRAMES

### **Exercici 1 - SubProgrames**

Exercici 1 - Fes una funció anomenada spData, tal que donada una data en format
MySQL ( AAAA-MM-DD ) ens retorni una cadena de caràcters en format DD-MM-AAAA

```mysql
DELIMITER //
DROP FUNCTION IF EXISTS sp_Data //
CREATE FUNCTION sp_Data(p_dataOrigen DATE) RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
    DECLARE v_dataFinal VARCHAR(10);
    
    SET v_dataFinal = DATE_FORMAT(p_dataOrigen, '%d-%m-%Y');
    
    RETURN v_dataFinal;
END //
DELIMITER ;
SELECT rrhh.sp_Data('1988-12-01');
```

### **Exercici 2 - SubProgrames**

Exercici 2 - Fes una funció anomenada spPotencia, tal que donada una base i un
exponent, ens calculi la seva potència. Intenta no utilitzar la funció POW.

```mysql
DELIMITER //
DROP FUNCTION IF EXISTS sp_Potencia //
CREATE FUNCTION sp_Potencia (p_num1 INT, p_num2 INT) RETURNS BIGINT DETERMINISTIC
BEGIN
    DECLARE v_potencia BIGINT;
    
    /* SET v_potencia = POWER(p_num1, p_num2); */
    
    IF p_num1 IS NOT NULL AND p_num2 IS NOT NULL THEN
        SET v_potencia = 1;
        WHILE p_num2 > 0 DO
            SET v_potencia = v_potencia * p_num1;
            SET p_num2 = p_num2 - 1;
        END WHILE;
    END IF;
  
    RETURN v_potencia;
END //
DELIMITER ;
SELECT rrhh.sp_Potencia(2, NULL);

```

### **Exercici 3 - SubProgrames**

Exercici 3 - Fes una funció anomenada spIncrement que donat un codi d’empleat i un
% de increment, ens calculi el salari sumant aquest percentatge.

```mysql
DELIMITER //
DROP FUNCTION IF EXISTS sp_Increment // 
CREATE FUNCTION sp_Increment (p_codi INT, p_persentatge FLOAT) RETURNS FLOAT 
NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_salariFinal FLOAT;
    DECLARE v_salariEmpleat FLOAT;
    
    SET v_salariEmpleat = (SELECT salari 
                                FROM empleats 
                            WHERE empleat_id = p_codi);
    
    SET v_salariFinal = (v_salariEmpleat * (p_persentatge / 100)) + v_salariEmpleat;
    
    RETURN v_salariFinal;
END //
DELIMITER ;
SELECT rrhh.sp_Increment(212, 20);

```

### **Exercici 4 - SubProgrames**

Exercici 4 - Fes una funció anomenada spPringat, tal que li passem un codi de
departament, i ens torni el codi d’empleat que guanya menys d’aquell departament.

```mysql
DELIMITER //
DROP FUNCTION IF EXISTS sp_Pringat //
CREATE FUNCTION sp_Pringat (p_codi INT) RETURNS INT 
NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_empleat INT;
    
    SET v_empleat = (SELECT empleat_id 
                        FROM empleats
                    WHERE departament_id = p_codi
                    ORDER BY salari ASC
                    LIMIT 1);
       
    RETURN v_empleat;
END //
DELIMITER ;
SELECT rrhh.sp_Pringat(60);
```

### **Exercici 5 - SubProgrames**

Exercici 5 - Utilitzant la funció spPringat fes una consulta per obtenir de cada
departament, l’empleat pringat. Mostra el codi i nom del departament, i el codi d’empleat.

```mysql
SELECT empleat_id, departament_id
    FROM empleats
WHERE rrhh.sp_Pringat();
```

### **Exercici 6 - SubProgrames**

Exercici 6 - Fes una funció anomenada spCategoria, tal que donat un codi d’empleat,
ens digui en quina categoria professional està. El criteri que volem seguir per determinar
la categoria professional és en funció dels anys que porta treballant a l’empresa:

- Entre 0 i 1 anys -> Auxiliar
- Entre 2 i 10 anys -> Oficial de Segona
- Entre 11 i 20 Anys -> Oficial de Primera
- Més de 20 anys -> Que es jubili!

```mysql
DROP FUNCTION IF EXISTS sp_Categoria //
CREATE FUNCTION sp_Categoria (pEmpleatId INT) RETURNS VARCHAR(45) 
NOT DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE vRetorn VARCHAR(45);
    DECLARE anys_treballats INT DEFAULT NULL;
    
    SELECT TIMESTAMPDIFF(YEAR, e.data_contractacio, COUNT(*)) INTO anys_treballats
        FROM empleats e
    WHERE e.empleat_id = pEmpleatId;
    
    CASE 
        WHERE anys_treballats = 
    
    RET
END //
DELIMITER ;
```

### **Exercici 7 - SubProgrames**

Exercici 7 - Fes una consulta utilitzant la funció anterior perquè mostri mostri de cada empleat, el codi d’empleat, el nom, els anys treballats i la categoria professional a la que pertany.

```mysql

```

### **Exercici 8 - SubProgrames**

Exercici 8 - Fes una funció anomenada spEdat, tal que donada una data per paràmetre ens retorni l'edat d'una persona. Les dates posteriors a la data d'avui han de retornar 0.

```mysql

```

### **Exercici 9 - SubProgrames**

Exercici 9 - Fes una funció que ens retorni el número de directors (caps) diferents tenim.

```mysql

```

### **Exercici 10 - SubProgrames**

Exercici 10 - Quina instrucció utilitzarem si volem veure el contingut de la funció spPringat?

```mysql

```

## ACTIVITAT - ENUNCIATS DE PROCEDIMENTS

### **Funcio que farem servir per mes d'un exercici**

A continuació un codi per comprovar si el ID que ens passen per parametre existeix en la nostra BD de empleat.

```mysql
/* Comprovem si el ID que li passem existeix*/
DELIMITER //
CREATE FUNCTION spEmpleatExists (pEmpleatId) RETURNS BOOLEAN
NOT DETERMINISTIC READS 
BEGIN 
    DECLARE vRetorn BOOLEAN DEFAULT FALSE;
    
    IF (SELECT empleat_id
                FROM empleats
            WHERE empleat_id = pEmpleatId) THEN
        SET vRetorn = 1;
    END IF;

    RETURN vRetorn
END //
```

### **Exercici 1 - Procediments**

Fes un procediment que permeti obtenir la data i hora del sistema i l’usuari actual.

```mysql

```

### **Exercici 2 - Procediments**

Fes un procediment que intercanvii el sou de dos empleats passats per paràmetre.

```mysql
/* Fem el canvi de salari als dos empleats */
DELIMITER //
CREATE PROCEDURE spSwapSous (IN pEmpleatId1 INT, IN pEmpleatId2 INT)
BEGIN

    DECLARE vSalariTmp DECLARE (8,2);


    IF spEmpleatExists (pEmpleatId1) = 1 AND spEmpleatExists(pEmpleatId2) = 1 THEN

        SELECT salari INTO vSalariTmp
            FROM empleats
        WHERE empleat_id = pEmpleatId1;

        UPDATE empleats
            SET salari = (SELECT salari
                            FROM empleats
                        WHERE empleat_id = pEmpleatId2)
        WHERE empleat_id = pEmpleatId1;

        UPDATE empleats
            SET salari = vSalariTmp
        WHERE empleat_id = pEmpleatId2;
    END IF;
    
    END //
SELECT spSwapSous(7, 8);
```

### **Exercici 3 - Procediments**

Fes un procediment que donat dos Ids d'empleat assigni el codi de departament del primer en el segon.

```mysql
DROP PROCEDURE IF EXISTS spAssignarDepart
DELIMITER //
CREATE PROCEDURE spAssignarDepart (IN pEmpleatId1 INT, IN pEmpleatId2 INT)
BEGIN

    -- Comparar que pEmpleatId1 i pEmpleatId2 existeixen
    IF spEmpleatExists (pEmpleatId1) = 1 AND spEmpleatExists(pEmpleatId2) = 1 THEN
        
        -- Obtenir departament_id de pEmpleatId1
        -- modificar departament_id de pEmpleatId2
        UPDATE empleats
            departament_id = (SELECT departament_id
                                FROM empleats
                            WHERE empleat_id = pEmpleatId1)
        WHERE empleat_id = pEmpleatId2;
    END IF;

END //
SELECT spAssignarDepart(7, 8);
```

### **Exercici 4 - Procediments**

Fes un procediment que donat dos Ids d'empleat assigni el codi de departament del primer en el segon.

```mysql
DROP PROCEDURE IF EXISTS spMoureEmpleats
DELIMITER //
CREATE PROCEDURE spMoureEmpleats (IN pDepId1 INT, IN pDepId2 INT)
BEGIN

    IF pDepId1 IS NOT NULL THEN
        UPDATE empleats
            SET departament_id = pDepId1
        WHERE departamnet_id = pDepId2
    END IF;
    
END //
SELECT spMoureEmpleats(60, 90);
```

### **Exercici 5 - Procediments**

Fes un procediment per mostrar un llistat dels empleats. Volem veure el id_empleat, nom_empleat, nom_departament i el nom de la localització del departament

```mysql
    
```

### **Exercici 6 - Procediments**

Fes un procediment que donat un codi d’empleat, ens doni la informació de l’empleat ( agafa la informació que creguis rellevant)

```mysql

```

### **Exercici 7 - Procediments**

Volem fer un registre dels usuaris que entren al nostre sistema. Per fer-ho primer caldrà crear una taula amb dos camps, un per guardar l’usuari i l’altre per guardar la data i hora de l’accés.

```mysql
CREATE TABLE registre_usuaris (
    usuari      VARCHAR(100),
    acces      DATETIME
);
```

### **Exercici 8 - Procediments**

A continuació feu un procediment sense arguments, de manera que cada vegada que el crideu, insereixi en aquesta taula l’usuari actual i la data i hora en que s’ha executat el procediment.

```mysql
DROP PROCEDURE IF EXISTS spRegistrarUsuari;
DELIMITER //
CREATE PROCEDURE spRegistrarUsuari()
BEGIN   

    INSERT INTO registre_usuaris(usari,acces)
        VALUES(CURRENT_USER(), NOW());

END //
CALL spRegistrarUsuari()//
```

### **Exercici 9 - Procediments**

Fes un procediment que ens permeti afegir un nou departament però amb la següent particularitat: En cas que la localització no existeixi a la taula localitzacions, ens posarà un NULL en el camp id_localtizacio de la taula departaments. Al procediment li hem de passar el codi de departament, el nom del departament i el codi de la localització.

```mysql

```

### **Exercici 10 - Procediments**

Fes un procediment que donat un codi d’empleat, ens posi en paràmetres de sortida el nom i el cognom. Indica com ho pots fer per comprovar si el procediment et funciona.

```mysql
DROP PROCEDURE IF EXISTS spDadesEmpleat;
DELIMITER //
CREATE PROCEDURE spDadesEmpleat(IN pEmpleatId INT, OUT pEmpleatNom VARCHAR(20), OUT pEmpleatCognoms VARCHAR(25))
BEGIN
    SELECT nom, cognoms INTO pEmpleatNom,pEmpleatCognoms
        FROM empleats
    WHERE empleat_id = pEmpleatId
END //
DELIMITER ;
SET @vNom = 'Pere';
SET @vCognoms = 'Pi';
SELECT @vNom, @vCognoms;
CALL spDadesEmpleat(101, @vNom, @vCognoms)
```

### **Exercici 11 - Procediments**

Fes un procediment que ens permeti modificar el nom i cognom d’un empleat.

```mysql
DROP PROCEDURE IF EXISTS spModificarEmpleat;
DELIMITER //
CREATE PROCEDURE spModificarEmpleat(IN pEmpleatId INT, IN pEmpleatNom VARCHAR(20), IN pEmpleatCognoms VARCHAR(25))
BEGIN

    IF pEmpleatNom IS NOT NULL AND pEmpleatCognoms IS NOT NULL THEN
        UPDATE empleats
            SET nom = pEmpleatNom,
                cognoms = pEmpleatCognoms
        WHERE empleat_id = pEmpleatId
    END IF

END //
```

### **Exercici 12 - Procediments**

Crea una taula d’auditoria anomenada logs_usuaris. Aquesta taula la utilitzarem per monitoritzar algunes de les accions que fan els usuaris sobre les dades,per exemple si actualitzen dades, eliminen registres.
La taula ha de tenir els següents camps:

| Nom | Tipus | Descripció |
| --- | --- | --- |
| usuari | VARCHAR(100)  | Usuari que ha realitzat l’acció |
| data   | DATETIME      | Data-Hora en que s’ha realitzat l’acció |
| taula  | VARCHAR(50)   | Taula sobre la que es realitza l’acció |
| accio  | VARCHAR(20)   | “ELIMINAR”,”AFEGIR”,”MODIFICAR”,”INSERIR” |
| valor_pk | VARCHAR(200) | valor que identifica el registre que ha patit l’acció |

Fes un procediment amb nom spRegistrarLog que rebrà com a paràmetres el nom de la taula, l’acció i el valor_pk.
Aquest procediment només cal que insereixi un registre en la taula logs_usuaris amb les dades rebudes, tenint en compte l’usuari actual i la data-hora del sistema.

```mysql
DROP TABLE IF EXISTS logs_usuaris
CREATE TABLE logs_usuaris (
    usuari      VARCHAR(100),
    data        DATETIME,
    taula       VARCHAR(50),
    accio       VARCHAR(20),
    valor_pk    VARCHAR(200)
)

DROP PROCEDURE IF EXISTS spRegistrarLog;
DELIMITER //
CREATE PROCEDURE spRegistrarLog(IN pTaula VARCHAR(50), IN pAccio VARCHAR(20), IN pValorPK VARCHAR(200))
BEGIN

    INSERT INTO logs_usuaris (usuari,data,taula,accio,valor_pk)
        VALUES(CURRENT_USER(), NOW(), Ptaula, pAccio, pValorPK)

END //
DELIMITER ;
CALL spRegistrarLog('empleats', 'INSERT', '500');
SELECT * FROM logs_usuaris;
```

### **Exercici 13 - Procediments**

Fes un procediment que ens permeti eliminar un departament determinat. El departament s’ha d’eliminar de la taula departaments. Utilitza a més dins d’aquest procediment, el procediment creat anteriorment (spRegistrarLog) per guardar també un registre del que ha realitzat l’usuari. Ens ha de quedar clar que l’usuari actual, en data X ha eliminat de la taula DEPARTAMENTS el codi departament Y.

```mysql
DROP PROCEDURE IF EXISTS spEliminarDepartament;
DELIMITER //
CREATE PROCEDURE spEliminarDepartament(IN dDepId INT)
BEGIN

    DECLARE vDepID INT;
    

    IF (SELECT departamnet_id INTO vDepID
                FROM departaments
            WHERE departament_id = dDepId;) IS NOT NULL THEN
        SELECT 'dins if';

        -- Tenir en compte que no tingui "empleats"
        DELETE FROM empleats
            WHERE departament_id = pDepId;

        IF ROW_COUNT() > 0 THEN
            CALL spEliminarDepartament ('empleats', 'ELIMINAR', CONCAT("dep_id = ", dDepId));
        END IF;


        -- Tenir en compte que no tingui "historial_feines"
        DELETE FROM departaments
            WHERE departament_id = dDepId;

        IF ROW_COUNT() > 0 THEN
            CALL spEliminarDepartament ('departeaments', 'ELIMINAR', CONCAT("dep_id = ", dDepId));
        END IF;


        DELETE FROM departaments
            WHERE departaments_id = dDepId

        CALL spRegistrarLog('departamnets','ELIMINAR',dDepId)
    ELSE 
        SELECT 'dins else';

    END IF;

END //
CALL spEliminarDepartament(300);
```

### **Exercici 14 - Procediments**

Fes un procediment que ens posi en paràmetres de sortida el número d’empleats que tenim, el número de departaments i el número de localitzacions.

```mysql

```