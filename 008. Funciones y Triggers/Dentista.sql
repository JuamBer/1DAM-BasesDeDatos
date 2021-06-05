CREATE SCHEMA IF NOT EXISTS Dentista DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;

USE Dentista;

CREATE TABLE IF NOT EXISTS Seguro (
  id_seguro INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100),
  tipo ENUM('N','I','P'),
  
  PRIMARY KEY (id_seguro))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Paciente (
  id_paciente INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45),
  apellido_1 VARCHAR(45),
  apellido_2 VARCHAR(45),
  edad SMALLINT,
  sexo ENUM('V','M'),
  fecha_nac DATE,
  telefono CHAR(9),
  
  PRIMARY KEY (id_paciente))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Tratamiento (
  id_tratamiento INT NOT NULL AUTO_INCREMENT,
  siglas VARCHAR(4),
  nombre VARCHAR(45),
  comentario VARCHAR(256),
  etapas INT,
  precio DECIMAL(9,3),
  
  PRIMARY KEY (id_tratamiento))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Asegurado (
  id_asegurado INT NOT NULL AUTO_INCREMENT,
  id_paciente INT,
  id_seguro INT,
  poliza FLOAT(6,2) ,
  pac_fnac DATE,
  
  PRIMARY KEY (id_asegurado),
  FOREIGN KEY (id_paciente) REFERENCES Paciente (id_paciente) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_seguro) REFERENCES Seguro (id_seguro) ON DELETE CASCADE ON UPDATE CASCADE)
ENGINE = InnoDB;
    
CREATE TABLE IF NOT EXISTS Visitas (
  id_tratamiento INT NOT NULL AUTO_INCREMENT,
  id_paciente INT,
  fecha DATE,
  tratamiento VARCHAR(45) NOT NULL,
  observaciones BLOB(512),
  
  PRIMARY KEY (id_paciente, id_tratamiento),
  FOREIGN KEY (id_paciente) REFERENCES Paciente (id_paciente) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_tratamiento) REFERENCES Tratamiento (id_tratamiento) ON DELETE CASCADE ON UPDATE CASCADE)
ENGINE = InnoDB;
