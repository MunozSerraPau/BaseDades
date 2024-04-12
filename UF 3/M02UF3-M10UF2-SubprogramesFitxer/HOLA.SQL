ALTER TABLE departaments
    ADD COLUMN num_empleats TINYINT UNSIGNED; /* (el primer registre ficar 1 i el segon 2 al principi de toto) */

SELECT * FROM departaments;

SELECT departament_id, COUNT(*)
    FROM empleats
GROUP BY departament_id;

DELIMITER //
CREATE TRIGGER trgActualitzarNumEmpleatsI AFTER INSERT
    ON empleats FOR EACH ROW
BEGIN

    UPDATE departaments
        SET num_empleats = IFNULL(num_empleats,0) + 1
    WHERE departament_id = NEW.departament_id;

END//

DELIMITER //
CREATE TRIGGER trgActualitzarNumEmpleatsD AFTER DELETE
    ON empleats FOR EACH ROW
BEGIN

    UPDATE departaments
        SET num_empleats = num_empleats - 1
    WHERE departament_id = NEW.departament_id;

END//

DELIMITER //
CREATE TRIGGER trgActualitzarNumEmpleatsU AFTER UPDATE
    ON empleats FOR EACH ROW
BEGIN

    IF NEW.departament_id != OLD.departament_id THEN
        UPDATE departaments
            SET num_empleats = IFNULL(num_empleats,0) + 1
        WHERE departament_id = NEW.departament_id;
        
        UPDATE departaments
            SET num_empleats = num_empleats - 1
        WHERE departament_id = OLD.departament_id;
    END IF;

END//



/* ex 7 */
CREATE TABLE registre_usuaris (
    usuari      VARCHAR(100),
    acces      DATETIME
);

DROP PROCEDURE IF EXISTS spRegistrarUsuari;
DELIMITER //
CREATE PROCEDURE spRegistrarUsuari()
BEGIN   

    INSERT INTO registre_usuaris(usari,acces)
        VALUES(CURRENT_USER(), NOW());



END //
DELIMITER ;
CALL spRegistrarUsuari();


/* EX 9*/
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

/* ex 10 */
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

/* ex 12 */
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

/* ex 13 */
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
        UPDATE empleats
            SET id_cap = NULL
        WHERE emplat_id IN (SELECT empleat_id
                                FROM empleats
                            WHERE departament_id = dDepId);

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
CALL spEliminarDepartament(50);