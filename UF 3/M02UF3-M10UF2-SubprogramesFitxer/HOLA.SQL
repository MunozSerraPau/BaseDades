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
        SET num_empleats = num_empleats + 1
    WHERE departament_id = NEW.departament_id;

END//