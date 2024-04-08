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