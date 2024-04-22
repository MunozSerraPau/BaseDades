-- Active: 1713175824955@@10.94.255.110@3306@rrhh
USE rrhh;


-- Exercici 4
DELIMITER //
DROP TRIGGER IF EXISTS trgSalariEmpleatsUpdate //
CREATE TRIGGER trgSalariEmpleatsUpdate BEFORE UPDATE 
    ON empleats FOR EACH ROW
BEGIN
        IF((NEW.salari < (SELECT salari_min FROM feines WHERE feina_codi = NEW.feina_codi)) OR (NEW.salari > (SELECT salari_max FROM feines WHERE feina_codi = NEW.feina_codi))) THEN
                SET NEW.salari = OLD.salari;
    END IF;
END //

DROP TRIGGER IF EXISTS trgSalariEmpleatsInsert //
CREATE TRIGGER trgSalariEmpleatsInsert BEFORE INSERT ON empleats FOR EACH ROW
BEGIN
    -- Comprovar si el nou salri esta dins del salari minim 
    IF((NEW.salari < (SELECT salari_min FROM feines WHERE feina_codi = NEW.feina_codi)) OR (NEW.salari > (SELECT salari_max FROM feines WHERE feina_codi = NEW.feina_codi))) THEN 
            -- Li assigna un salari minim
            -- SET NEW.salari = (SELECT salari_min FROM feines WHERE feina_codi = NEW.feina_codi);
            SIGNAL SQLSTATE '43000'
            SET MESSAGE_TEXT = "El salari introduït no compleix el rand fe salri de la geina_codi"
    END IF;
END //
DELIMITER ;

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
CREATE TRIGGER trgNumEmpleatsDelete AFTER INSERT ON empleats FOR EACH  ROW
BEGIN
    UPDATE departemants
        SET num_empleats = num_empleats + 1;
    WHERE departaments_id = OLD.departament_id;
END //

DROP TRIGGER IF EXISTS trgNumEmpleatsDelete 
CREATE TRIGGER trgNumEmpleatsDelete AFTER INSERT ON empleats FOR EACH  ROW
BEGIN
    IF NEW.departaments_id != old.departament_id THEN
        UPDATE departaments
            SET num_empleats
END //