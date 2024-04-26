-- Active: 1713175824955@@10.94.255.110@3306@rrhh
USE rrhh;

-- Exercici 5
MODIFY TABLE departaments
    ADD COLUMN num_empleats     INT, UNSIGNED;

DELIMITER //
DROP TRIGGER IF EXISTS trgNumEmpleatsInsert AFTER INSERT ON empleats FOR EACH  ROW
BEGIN
    UPDATE departemants
        SET num_empleats = num_empleats + 1;
    WHERE departaments_id = NEW.departament_id;
END //

DROP TRIGGER IF EXISTS trgNumEmpleatsDelete 
CREATE TRIGGER trgNumEmpleatsDelete AFTER DELETE ON empleats FOR EACH  ROW
BEGIN
    UPDATE departemants
        SET num_empleats = num_empleats + 1;
    WHERE departaments_id = OLD.departament_id;
END //

DROP TRIGGER IF EXISTS trgNumEmpleatsUpdate 
CREATE TRIGGER trgNumEmpleatsUpdate AFTER UPDATE ON empleats FOR EACH  ROW
BEGIN
    IF NEW.departaments_id != old.departament_id THEN
        UPDATE departaments
            SET num_empleats
END //