CREATE DATABASE GestionProyectos2 COLLATE utf8mb4_spanish2_ci CHARSET utf8mb4;

USE GestionProyectos2;

CREATE TABLE Proyecto (
  cod_pry VARCHAR(4),
  nom VARCHAR(20),
  ciudad VARCHAR(30),
  
  PRIMARY KEY (cod_pry)
) ENGINE=innodb;

CREATE TABLE Proveedor (
  cod_pro INT AUTO_INCREMENT,
  nom VARCHAR(50),
  estado ENUM("Activo","Deuda","Espera","Inactivo"),
  ciudad VARCHAR(30),
  tel VARCHAR(9) NOT NULL,
  
  PRIMARY KEY (cod_pro)
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
  cantidad INT,
  
  FOREIGN KEY (proveedor) REFERENCES Proveedor (cod_pro) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (pieza) REFERENCES Pieza (cod_pie) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (proyecto) REFERENCES Proyecto (cod_pry) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=innodb;