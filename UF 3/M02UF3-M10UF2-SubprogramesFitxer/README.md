# ACTIVITAT - EXERCICIS SUBPROGRAMES

**Exercici 1**

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

**Exercici 2**

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

**Exercici 3**

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

**Exercici 4**

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

**Exercici 5**

```mysql
SELECT empleat_id, departament_id
    FROM empleats
WHERE rrhh.sp_Pringat();
```

**Exercici 6**

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

**Exercici 7**

```mysql

```

**Exercici 8**

```mysql

```

**Exercici 9**

```mysql

```

**Exercici 10**

```mysql

```


# ACTIVITAT - ENUNCIATS DE PROCEDIMENTS

**Exercici 1**

**Exercici 2**

**Exercici 3**

**Exercici 4**

**Exercici 5**

**Exercici 6**

**Exercici 7**

**Exercici 8**

**Exercici 9**

**Exercici 10**

**Exercici 11**

**Exercici 12**

**Exercici 13**

**Exercici 14**