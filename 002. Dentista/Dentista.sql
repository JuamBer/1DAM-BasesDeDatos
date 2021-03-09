CREATE SCHEMA IF NOT EXISTS `Dentista` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci ;

CREATE TABLE IF NOT EXISTS `Dentista`.`Seguro` (
  `id_seguro` INT NOT NULL AUTO_INCREMENT,
  `nom_seg` VARCHAR(100) ,
  `tipo` ENUM('N','I','P') ,
  PRIMARY KEY (`id_seguro`));


CREATE TABLE IF NOT EXISTS `Dentista`.`Paciente` (
  `id_paciente` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) ,
  `ape_1` VARCHAR(45) ,
  `ape_2` VARCHAR(45) ,
  `edad` smallint,
  `sexo` enum('V','M'),
  `f_nac` DATE ,
  `tel` CHAR(9) ,
PRIMARY KEY (`id_paciente`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Dentista`.`Tratamiento` (
  `id_tratamiento` INT NOT NULL AUTO_INCREMENT,
  `cod_trat` VARCHAR(4) ,
  `descripcion` VARCHAR(256) ,
  `Precio` DECIMAL(9,3) ,
  `etapas` INT ,
  PRIMARY KEY (`id_tratamiento`));


CREATE TABLE IF NOT EXISTS `Dentista`.`Asegurado` (
  `id_asegurado` INT(6),
  `id_paciente` INT REFERENCES `Dentista`.`Paciente` (`id_paciente`),
  `id_seguro` INT REFERENCES `Dentista`.`Seguro` (`id_seguro`),
  `poliza` float(6,2) ,
  `pac_fnac` date,
  PRIMARY KEY (`id_asegurado`));
    
    
CREATE TABLE IF NOT EXISTS `Dentista`.`Visitas` (
  `id_visita` INT NOT NULL AUTO_INCREMENT,
  `id_paciente` INT NOT NULL REFERENCES `Dentista`.`Paciente` (`id_paciente`),
  `cod_trat` VARCHAR(4) NOT NULL REFERENCES `Dentista`.`Tratamiento` (`cod_trat`),
  `fecha_visita` DATE,
  `observaciones` BLOB(512),
  PRIMARY KEY (`id_visita`, `id_paciente`, `cod_trat`));
    
    
CREATE TABLE IF NOT EXISTS `Dentista`.`Hombres` (
  `id_paciente` INT NOT NULL,
  `nom` VARCHAR(45) ,
  `ape_1` VARCHAR(45) ,
  `ape_2` VARCHAR(45) ,
  `edad` smallint,
  `tel` CHAR(9) ,
PRIMARY KEY (`id_paciente`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Dentista`.`Mujeres` (
  `id_paciente` INT NOT NULL,
  `nom` VARCHAR(45) ,
  `ape_1` VARCHAR(45) ,
  `ape_2` VARCHAR(45) ,
  `edad` smallint,
  `tel` CHAR(9) ,
PRIMARY KEY (`id_paciente`))
ENGINE = InnoDB;

