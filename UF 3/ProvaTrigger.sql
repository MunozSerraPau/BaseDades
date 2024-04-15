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

SELECT * FROM departaments;
SELECT * FROM empleats;

DELIMITER ;

INSERT INTO empleats (empleat_id, nom, cognoms, email, data_contractacio, feina_codi)
    VALUES ('208', 'Pau', 'Munoz', 'p.munoz@sapa,cat', '2004-10-4', 'IT_PROG');

INSERT INTO departaments (departament_id, nom, localitzacio_id)
    VALUES ('70', 'IT', '1500');