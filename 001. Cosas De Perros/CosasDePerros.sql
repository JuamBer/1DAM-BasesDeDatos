CREATE SCHEMA IF NOT EXISTS `CosasDePerros` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci ;


CREATE TABLE IF NOT EXISTS `CosasDePerros`.`Asociacion` (
  `cif` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(30) ,
  `ambito` VARCHAR(40)  ,
  PRIMARY KEY (`cif`));


CREATE TABLE IF NOT EXISTS `CosasDePerros`.`Propietario` (
  `dni` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(30) ,
  `teléfono` VARCHAR(9),
  `direccion` VARCHAR(40) ,
  `ciudad` VARCHAR(15) ,
  PRIMARY KEY (`dni`));
  
  
CREATE TABLE IF NOT EXISTS `CosasDePerros`.`Perro` (
  `n_placa` VARCHAR(9) NOT NULL,
  `dni_prop` VARCHAR(10) NOT NULL REFERENCES `CosasDePerros`.`Propietario` (`dni`),
  `nombre` VARCHAR(30),
  `raza` VARCHAR(30) ,
  PRIMARY KEY (`n_placa`));
  
  
CREATE TABLE IF NOT EXISTS `CosasDePerros`.`Escuela` (
  `cif` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(30),
  `telefono` VARCHAR(9) ,
  `direccion` VARCHAR(40),
  `ciudad` VARCHAR(15),
  `categoria` VARCHAR(30),
  PRIMARY KEY (`cif`));


CREATE TABLE IF NOT EXISTS `CosasDePerros`.`Pertenecer` (
  `cif_asoc` VARCHAR(10) NOT NULL REFERENCES `CosasDePerros`.`Asociacion` (`cif`),
  `dni_drop` VARCHAR(10) NOT NULL REFERENCES `CosasDePerros`.`Propietario` (`dni`),
  PRIMARY KEY (`cif_asoc`,`dni_drop`));
  
  
CREATE TABLE IF NOT EXISTS `CosasDePerros`.`Adiestrar` (
  `n_placa` VARCHAR(9) NOT NULL REFERENCES `CosasDePerros`.`Perro` (`n_placa`),
  `cif_esc` VARCHAR(10) NOT NULL REFERENCES `CosasDePerros`.`Escuela` (`cif`),
  PRIMARY KEY (`n_placa`,`cif_esc`));
