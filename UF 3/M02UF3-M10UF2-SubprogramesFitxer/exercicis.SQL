-- Active: 1713175824955@@10.94.255.110@3306@rrhh
    USE rrhh;
    SELECT * FROM empleats;

    DROP PROCEDURE IF EXISTS spDobleCursor;
    DELIMITER //
    CREATE PROCEDURE spDobleCursor()
    BEGIN

        DECLARE vFiCursorEmp BOOLEAN DEFAULT false;
        DECLARE vFiCursorDep BOOLEAN DEFAULT false;

        DECLARE vDevId INT;
        DECLARE vEmpleatId INT;

        DECLARE vDepNom VARCHAR(30);
        DECLARE vNom VARCHAR(20);
        DECLARE vCognoms VARCHAR(25);
            
        DECLARE cDepartaments CURSOR FOR    SELECT departament_id, nom
                                                FROM departaments;

        DECLARE cEmpleats CURSOR FOR    SELECT empleat_id, nom, cognoms
                                            FROM empleats
                                        WHERE departament_id = vDepId;

        DECLARE CONTINUE HANDLER FOR NOT FOUND
        BEGIN
            -- Comprovo si estic al final del cursor de departaments o el d'empleats
            SET vFiCursorDep = true;
            SET vFiCursorEmp = true;
        END;




        
        -- Recurregut per la taula departaments
        OPEN cDepartaments;
        FETCH cDepartaments INTO vDepId,vDepNom;
        WHILE NOT vFiCursorDep DO    -- 
            IF vDevId IS NOT NULL THEN
                INSERT INTO departament_copia (departament_id, nom)
                    VALUES (vDevId, vDepNom);
            END IF;

            -- Recorregut per la taula empleats del departament actual.
            OPEN cEmpleats;
            set vFiCursorEmp = false;
            FETCH cEmpleats INTO vEmpleatId,vNom,vCognoms;
            WHILE NOT vFiCursorEmp DO
                IF vEmpleatId IS NOT NULL THEN
                    INSERT INTO empleats_copia (empleat_id, nom, cognoms)
                        VALUES (vEmpleatId, vNom, vCognoms);
                END IF;
                FETCH cEmpleats INTO vEmpleatId, vNom, vCognoms;
            END WHILE;
            CLOSE cEmpleats;

            FETCH cDepartaments INTO vDepId,vDepNom;
        END WHILE;
    
    
    END
    //
    