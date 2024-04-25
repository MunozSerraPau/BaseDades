-- Active: 1713175824955@@10.94.255.110@3306@rrhh

SELECT CURRENT_USER;
SELECT * FROM mysql.user;


USE rrhh;


-- Exercici 1 --> Creacció d'Usuari 1
CREATE USER 'usuari1'@'localhost' IDENTIFIED BY 'P@ssw0rd';
GRANT INSERT,UPDATE,DELETE,SELECT ON rrhh.* TO 'usuari1'@'localhost';


-- Exercici 2 --> Creacció d'Usuari 2
CREATE USER 'usari2'@'localhost' IDENTIFIED BY 'P@ssw0rd';
GRANT SELECT ON rrhh.* TO 'usari2'@'localhost';
GRANT UPDATE (salari) ON rrhh.empleats TO 'usari2'@'localhost';


-- Exercici 3 --> Modificació Usuari 1 qualsevol maquina
CREATE USER 'usuari1'@'%' IDENTIFIED BY 'P@ssw0rd';
GRANT SELECT ON rrhh.* TO 'usuari1'@'%';
