CREATE DATABASE GestionProyectos COLLATE utf8mb4_spanish2_ci CHARSET utf8mb4;

USE GestionProyectos;

CREATE TABLE Sede (
  cod_sede VARCHAR(9),
  nom VARCHAR(45),
  responsable VARCHAR(45),
  ciudad VARCHAR(30),
  pais VARCHAR(45),
  
  PRIMARY KEY (cod_sede)
) ENGINE=innodb;


CREATE TABLE Proyecto (
  cod_pry VARCHAR(4),
  nom VARCHAR(20),
  fe_ini DATE NOT NULL,
  presup DECIMAL(8,2),
  fase ENUM("Planificación","Inicial","Desarrollo","Propotipo","Implantación") NOT NULL,
  ciudad VARCHAR(30),
  sede VARCHAR(9),
  
  PRIMARY KEY (cod_pry),
  CONSTRAINT cod_sedeFK FOREIGN KEY (sede)
        REFERENCES Sede (cod_sede)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=innodb;

CREATE TABLE Proveedor (
  cod_pro INT AUTO_INCREMENT,
  CIF VARCHAR(9) NOT NULL UNIQUE,
  nom VARCHAR(50),
  estado ENUM("Activo","Deuda","Espera","Inactivo"),
  ciudad VARCHAR(30),
  codPostal VARCHAR(5),
  tel VARCHAR(9) NOT NULL,
  
  PRIMARY KEY (cod_pro)
  /* NO SE DECLARAR UNA CLAVE ALTERNATIVA */
) ENGINE=innodb;


CREATE TABLE Pieza (
  cod_pie VARCHAR(4),
  nom VARCHAR(25),
  color ENUM("Rojo","Verde","Azul","Amarillo","Negro","Blanco"),
  peso DECIMAL(6,2),
  ciudad VARCHAR(30),
  
  PRIMARY KEY (cod_pie)
) ENGINE=innodb;


CREATE TABLE Pedidos (
  proveedor INT,
  pieza VARCHAR(4),
  proyecto VARCHAR(4),
  fecha DATE,
  cantidad INT,
  peso DECIMAL(10,2),
  estado ENUM("Preparación","Enviado","Devuelto","Recibido","OK") NOT NULL
) ENGINE=innodb;

