# EXERCICIS Triggers

## ACTIVITAT - EXERCICIS TRIGGERS (Part 1)

### **Exercici 1 (Part 1)**

Omplir la següent taula indicant en cada cas si es pot accedir als registres NEW i OLD des del trigger corresponent i, en cas afirmatiu, quin tipus d'operació és pot realitzar (L(llegir) o M(modificar)).

```slq
            INSERT              DELETE           UDATE
```

| | before | after | before | after | before | after |
| --- | --- | --- | --- | --- | --- | --- |
| NEW |  X  | L/M |  X  |  X  | L/M | L/M |
| OLD |  X  |  X  |  L  |  X  |  L  |  L  |

### **Exercici 2 (Part 1)**

A quina taula o taules de la base de dades INFORMATION_SCHEMA de sql es poden consultar els triggers que hi ha a la base dades?

```sql
SELECT * FROM empleats;

```

### **Exercici 3 (Part 1)**

**Auditoria de la taula “empleats”.**

Crea el que creguis necessari per auditar la taula d’empleats. Aquesta auditoria pretén dur un control automàtic dels canvis (INSERT, UPDATE, DELETE) que es realitzen en aquesta taula. Si no la tens crea una taula anomenada auditoria_taules amb els següents camps:

```sql

```

### **Exercici 4 (Part 1)**

**Validació de dades d’entrada.**

Mitjançant triggers volem dur el control de dades d’entrada d’una taula. Concretament volem dur el control del camp salari de la taula empleats. Aquest salari ha de ser un valor dins del rang marcat pels camps salari_min i salari_max de la taula feines. En definitiva, volem controlar que el salari dels empleats estigui dins dels rangs de salaris marcats per el tipus de feina que fa l’empleat.

```sql
DELIMITER //
DROP TRIGGER IF EXISTS trgSalariEmpleatsUpdate //
CREATE TRIGGER trgSalariEmpleatsUpdate BEFORE UPDATE 
    ON empleats FOR EACH ROW
BEGIN
    -- Comprova que el salari estigui per sota del salari minim o per sobre del salari maxim
    IF((NEW.salari < (SELECT salari_min FROM feines WHERE feina_codi = NEW.feina_codi)) OR (NEW.salari > (SELECT salari_max FROM feines WHERE feina_codi = NEW.feina_codi))) THEN
        -- OPCIO 1 (Li assigna el salri anterior a l'empleat)
        SET NEW.salari = OLD.salari;
        -- OPCIO 2 (Passar un text conforme dona error i no deixar-lo assignar)
        SIGNAL SQLSTATE '43000'
        SET MESSAGE_TEXT = "El salari introduït no compleix el rand fe salri de la geina_codi";
    END IF;
END //

DROP TRIGGER IF EXISTS trgSalariEmpleatsInsert //
CREATE TRIGGER trgSalariEmpleatsInsert BEFORE INSERT ON empleats FOR EACH ROW
BEGIN
    -- Comprova que el salari estigui per sota del salari minim o per sobre del salari maxim
    IF((NEW.salari < (SELECT salari_min FROM feines WHERE feina_codi = NEW.feina_codi)) OR (NEW.salari > (SELECT salari_max FROM feines WHERE feina_codi = NEW.feina_codi))) THEN 
        -- OPCIO 1 (Li assigna el salri minim a l'empleat)
        SET NEW.salari = (SELECT salari_min FROM feines WHERE feina_codi = NEW.feina_codi);
        -- OPCIO 2 (Passar un text conforme dona error i no deixar-lo assignar)
        SIGNAL SQLSTATE '43000'
        SET MESSAGE_TEXT = "El salari introduït no compleix el rand fe salri de la geina_codi";
    END IF;
END //
DELIMITER ;


INSERT INTO empleats(empleat_id, nom, cognoms, email, salari, feina_codi, data_contractacio)
    VALUES(300, 'Pol', 'Roig', 'prog@empresa.cat', 2000, 'IT_PROG', NOW());
    
SELECT * FROM empleats;
```

### **Exercici 5 (Part 1)**

**Manteniment del camp num_empleats.**

Afegeix un el camp num_empleats a la taula departaments. Aquest camp simbolitza/modela el número d’empleats que té aquell departament. Implementa mitjançant triggers el manteniment d’aquest camp de manera automàtica. Per exemple si s’afegeix un nou empleat del departament amb codi 10 cal augmentar en 1 aquest camp del departament_id = 10

```sql
DELI
```

1. Proccediment /funcio
2. Cursors
3. Triggers (Manteniment)
4. Creame este Usuario con este rol

### **Exercici 6 (Part 1)**

**Manteniment de l’historial de feines.**

Implementa el que creguis necessari per mantenir la taula historial_feines de forma automàtica. És dir, quan es s’afegeix o es modifica la feina d’un empleat, cal registrar aquest canvi a la taula historial_feines.
Cal tenir en compte que si l’empleat canvia de departament no cal registrar-ho a la taula historial_feines.
La data_inici i data_fi han d’anar en consonància a les dates del canvi de feina.

```sql

```

## ACTIVITAT - EXERCICIS TRIGGERS (Part 2)

### **Abans dels exercicis**

Crea la base de dades botiga a partir del seu model relacional. Un cop hagis creat la BD de botiga implementa amb triggers les peticions que es demanen a continuació.

CLIENT (nif, nom, cognoms, data_naix, adreça, telefon)

| Domini: |  |
| --- | --- |
| nif | 8 números i 1 lletra|
|nom | 30 lletres|
|data_naix | data|
|adreça | 20 lletres|
|telefon | 12 caracters|
|edat | nomber de 1-150 |

COMERCIAL (nif, nom, dataNaix, telefon, email)

FACTURA (numFactura, dataFactura, baseImponible, tipusIva, totalIva, totalFactura, formaPagament, observacions, comissió, dniClient, dniComercial, totalPagat, dataCobrament)

### **Exercici 1 (Part 2)**

```sql

```

### **Exercici 2 (Part 2)**

```sql
fe

```

### **Exercici 3 (Part 2)**

```sql

```

### **Exercici 4 (Part 2)**

```sql

```

### **Exercici 5 (Part 2)**

```sql

```

### **Exercici 6 (Part 2)**

```sql

```

### **Exercici 7 (Part 2)**

```sql

```

### **Exercici 8 (Part 2)**

```sql

```
