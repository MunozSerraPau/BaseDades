# REPAS

## REPAS - Trigger

``` sql
DELIMITER //
-- Dona error si intentas ficar una data més nova que la d'avui
CREATE TRIGGER trg_CataCOntractacioINSERT BEFORE INSERT ON emplats FOR EACH ROW
BEGIN
    IF NEW.data_contractacio > NOW() THEN
        SIGNAL SQLSTATE '43000'
        SET MESSAGE_TEXT = 'La data de contractació no pot ser superior a avui';
    END IF;
END
//

CREATE TRIGGER trg_CataCOntractacioUPDATE BEFORE UPDATE ON emplats FOR EACH ROW
BEGIN
    IF NEW.data_contractacio > NOW() THEN
        SIGNAL SQLSTATE '43000'
        SET MESSAGE_TEXT = 'La data de contractació no pot ser superior a avui';
    END IF;
END
//
```

## REPAS - HANDLER

``` sql
DELIMITER //
-- Actualitzar les dades d'una taula i assignar-li el nom complet a una columna
DROP PROCEDURE IF EXISTS spGenerarNomComplet//
CREATE PROCEDURE spGenerarNomComplet()
BEGIN
    DECLARE vFiCursor BOOLEAN DEFAULT False;
    DECLARE vNomComplet VARCHAR(45);
    DECLARE vEmplat_id INT;
    DECLARE cEmpleats CURSOR FOR SELECT empleat_id,  CONCAT(UPPER(LEFT(nom,1)),'.',cognoms)
                                        FROM empleats;

    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    BEGIN 
        SET vFiCursor = True;
    END;


    OPEN cEmpleats;                                 -- Obra la taula EMPLEATS AMB LES DADES empleat_id i el  nom.cognoms
    FETCH cEmpleats INTO vEmplat_id,vNomComplet;    -- Agafo el primer registre
    WHILE (vFiCursor = FALSE) DO                    -- Repeteixo fins que vFiCursor sigui FALSE
        UPDATE empleats	                            -- Actualitzo empleat i li assigno a nom_complet el vNomComplet i nomes assignar-li al empleat_id seu
            SET nom_complet = vNomComplet
    WHERE empleat_id = vEmplat_id;
        
        FETCH cEmpleats INTO vEmplat_id,vNomComplet; -- Ara agafem la info del següent registre
    
    END WHILE;                                      -- Acaba el bucle
    CLOSE cEmpleats;                                -- "Tanquem" la taula
 
END
//
```
