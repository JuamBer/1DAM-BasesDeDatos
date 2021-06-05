CREATE SCHEMA IF NOT EXISTS `Dentista2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci ;


CREATE TABLE IF NOT EXISTS `Dentista2`.`Seguro` (
  `cods` INT NOT NULL auto_increment,
  `nomseg` VARCHAR(100) ,
  `tipo` ENUM('N','I','P') ,
  PRIMARY KEY (`cods`));


CREATE TABLE IF NOT EXISTS `Dentista2`.`Paciente` (
  `codpac` INT NOT NULL,
  `nom` VARCHAR(45) ,
  `ape_1` VARCHAR(45) ,
  `ape_2` VARCHAR(45) ,
  `edad` smallint,
  `sexo` enum('V','M'),
  `F_NAC` DATE ,
  `Télefono` CHAR(9) ,
PRIMARY KEY (`codpac`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Dentista2`.`Tratamiento` (
  `siglas` VARCHAR(4) ,
  `coment` VARCHAR(256) ,
  `Nombre_Tratamiento` VARCHAR(45) ,
  `Precio` DECIMAL(9,3) ,
  `Etapas` INT ,
  `num` INT NOT NULL auto_increment,
  PRIMARY KEY (`num`));


CREATE TABLE IF NOT EXISTS `Dentista2`.`Asegurado` (
  `codaseg` INT ,
  `codpac` INT ,
  `cods` INT ,
  `poliza` float(6,2) ,
  `pac_fnac` date,
  PRIMARY KEY (`codaseg`),
   CONSTRAINT `Paciente_fk`
    FOREIGN KEY (`codpac`)
    REFERENCES `Dentista2`.`Paciente` (`codpac`)
     ON DELETE CASCADE
  ON UPDATE CASCADE,
  CONSTRAINT `Seguro_fk`
    FOREIGN KEY (`cods`)
    REFERENCES `Dentista2`.`Seguro` (`cods`) 
    ON DELETE CASCADE
  ON UPDATE CASCADE);
    
    
CREATE TABLE IF NOT EXISTS `Dentista2`.`Visitas` (
  `nvisita` INT auto_increment,
  `paciente` INT,
  `fecha` DATE,
  `Tratamiento` VARCHAR(45) NOT NULL,
  `Observaciones` BLOB(512),
  PRIMARY KEY ( `paciente`, `nvisita`),
  INDEX `Paciente_fk_idx` (`paciente`) ,
  INDEX `Tratamiento_fk_idx` (`nvisita`),
  CONSTRAINT `Paciente_fk_visit`
    FOREIGN KEY (`paciente`)
    REFERENCES `Dentista2`.`Paciente` (`codpac`)
      ON DELETE CASCADE
  ON UPDATE CASCADE,
  CONSTRAINT `Tratamiento_fk`
    FOREIGN KEY (`nvisita`)
    REFERENCES `Dentista2`.`Tratamiento` (`num`)
      ON DELETE CASCADE
  ON UPDATE CASCADE);
    
   
CREATE TABLE IF NOT EXISTS `Dentista2`.`HOMBRES` (
  `codpac` INT NOT NULL,
  `nom` VARCHAR(45) ,
  `ape_1` VARCHAR(45) ,
  `ape_2` VARCHAR(45) ,
  `edad` smallint,
  `Télefono` CHAR(9) ,
PRIMARY KEY (`codpac`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Dentista2`.`MUJERES` (
  `codpac` INT NOT NULL,
  `nom` VARCHAR(45) ,
  `ape_1` VARCHAR(45) ,
  `ape_2` VARCHAR(45) ,
  `edad` smallint,
  `Télefono` CHAR(9) ,
PRIMARY KEY (`codpac`))
ENGINE = InnoDB;


USE Dentista2;

INSERT IGNORE INTO Paciente VALUES (0, 'JOSÉ','MARTÍNEZ','GÓMEZ',NULL,'V','1980/02/12','961223344');
INSERT IGNORE INTO Paciente VALUES (1, 'Carmen','García','Solís',NULL,'M','1995/01/01','987456321');
INSERT IGNORE INTO Paciente VALUES (2, 'Fernando','Ruíz','Muñoz',NULL,'V','1990/04/05','969852314');
INSERT IGNORE INTO Paciente VALUES (3, 'Nelly','Pérez','Campos',NULL,'M','1993/02/12','945876321');
INSERT IGNORE INTO Paciente VALUES (4, 'PACO','Santillana','Meniz',NULL,'V','2000/02/12','956987412');

INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES ('ENDU', 'Endodoncia Uniradicular',1200);
INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES ('EXOQ', 'Endodoncia Quirúrgica',500);
INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES ('ORTO', 'Ortodoncia',2000);
INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES ('RX', 'Radiografia',2000);
INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES (null,null,null);
INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES (null,null,null);
INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES (null,null,null);
INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES (null,null,null);
INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES (null,null,null);
INSERT IGNORE INTO Tratamiento(Nombre_Tratamiento,coment, precio) VALUES (null,null,null);

INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (1,'RX', '2010/05/10');
INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (1,'EXOQ', '2010/05/10');
INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (1,'RX', '2010/05/10');
INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (2,'ENDU', '2010/05/10');
INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (3,'EXOQ', '2010/05/10');
INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (4,'ORTO', '1995/05/10');
INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (4,'RX', '2014/05/10');
INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (3,'RX', '2020/05/10');
INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (3,'RX', '2019/05/10');
INSERT IGNORE INTO Visitas(paciente, Tratamiento, fecha) VALUES (3,'ORTO', '2011/05/10');