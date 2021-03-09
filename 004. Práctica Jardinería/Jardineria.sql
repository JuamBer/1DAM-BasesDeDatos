CREATE DATABASE jardineria;

USE jardineria;

CREATE TABLE Oficinas (
  CodigoOficina varchar(10) NOT NULL,
  Ciudad varchar(30) NOT NULL,
  Pais varchar(50) NOT NULL,
  Region varchar(50) DEFAULT NULL,
  CodigoPostal varchar(10) NOT NULL,
  Telefono varchar(20) NOT NULL,
  LineaDireccion1 varchar(50) NOT NULL,
  LineaDireccion2 varchar(50) DEFAULT NULL,
  PRIMARY KEY (CodigoOficina)
) engine=innodb;

CREATE TABLE Empleados (
    CodigoEmpleado INTEGER NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido1 VARCHAR(50) NOT NULL,
    Apellido2 VARCHAR(50) DEFAULT NULL,
    Extension VARCHAR(10) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CodigoOficina VARCHAR(10) NOT NULL,
    CodigoJefe INTEGER DEFAULT NULL,
    Puesto VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (CodigoEmpleado),
    CONSTRAINT Empleados_OficinasFK FOREIGN KEY (CodigoOficina)
        REFERENCES Oficinas (CodigoOficina)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Empleados_EmpleadosFK FOREIGN KEY (CodigoJefe)
        REFERENCES Empleados (CodigoEmpleado)
        ON UPDATE CASCADE ON DELETE CASCADE
)  ENGINE=INNODB;

CREATE TABLE Clientes (
  CodigoCliente integer NOT NULL,
  NombreCliente varchar(50) NOT NULL,
  NombreContacto varchar(30) DEFAULT NULL,
  ApellidoContacto varchar(30) DEFAULT NULL,
  Telefono varchar(15) NOT NULL,
  Fax varchar(15) NOT NULL,
  LineaDireccion1 varchar(50) NOT NULL,
  LineaDireccion2 varchar(50) DEFAULT NULL,
  Ciudad varchar(50) NOT NULL,
  Region varchar(50) DEFAULT NULL,
  Pais varchar(50) DEFAULT NULL,
  CodigoPostal varchar(10) DEFAULT NULL,
  CodigoEmpleadoRepVentas integer DEFAULT NULL,
  LimiteCredito numeric(15,2) DEFAULT NULL,
  PRIMARY KEY (CodigoCliente),
  CONSTRAINT Clientes_EmpleadosFK FOREIGN KEY (CodigoEmpleadoRepVentas) REFERENCES Empleados (CodigoEmpleado) ON UPDATE CASCADE ON DELETE CASCADE
) engine=innodb;

CREATE TABLE GamasProductos (
  Gama VARCHAR(50) PRIMARY KEY,
  DescripcionTexto TEXT,
  DescripcionHTML TEXT,
  Dimensiones VARCHAR(25) NULL,
  Imagen BLOB
) engine=innodb;

CREATE TABLE Productos (
  CodigoProducto varchar(15) NOT NULL,
  Nombre varchar(70) NOT NULL,
  Gama varchar(50) NOT NULL,
  Dimensiones varchar(25) NULL,
  Proveedor varchar(50) DEFAULT NULL,
  Descripcion text NULL,
  CantidadEnStock smallint NOT NULL,
  PrecioVenta numeric(15,2) NOT NULL,
  PrecioProveedor numeric(15,2) DEFAULT NULL,
  PRIMARY KEY (CodigoProducto),
  CONSTRAINT GamasProductos FOREIGN KEY (Gama) REFERENCES GamasProductos (Gama) ON UPDATE CASCADE ON DELETE CASCADE
) engine=innodb;

CREATE TABLE Pedidos (
  CodigoPedido INT PRIMARY KEY,
  FechaPedido DATE NOT NULL,
  FechaEsperada DATE NOT NULL,
  FechaEntrega DATE,
  Estado VARCHAR(15) NOT NULL,
  Comentarios TEXT,
  CodigoCliente INT,
  CONSTRAINT CodigoCliente FOREIGN KEY (CodigoCliente) REFERENCES Clientes (CodigoCliente) ON UPDATE CASCADE ON DELETE CASCADE
) engine=innodb;

CREATE TABLE DetallesPedidos (
  CodigoPedido INT,
  CodigoProducto VARCHAR(15),
  Cantidad INT NOT NULL,
  PrecioUnidad DECIMAL(15,2) NOT NULL,
  NumeroLinea SMALLINT NOT NULL,
  PRIMARY KEY(CodigoPedido,CodigoProducto),
  CONSTRAINT CodigoPedido FOREIGN KEY (CodigoPedido) REFERENCES jardineria.Pedidos (CodigoPedido) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT CodigoProducto FOREIGN KEY (CodigoProducto) REFERENCES jardineria.Productos (CodigoProducto) ON UPDATE CASCADE ON DELETE CASCADE
) engine=innodb;



CREATE TABLE Pagos (
  CodigoCliente INT REFERENCES jardineria.Pedidos (CodigoPedido) ON UPDATE CASCADE ON DELETE CASCADE,
  FormaPago VARCHAR(40) NOT NULL,
  IDTransaccion VARCHAR(50) PRIMARY KEY,
  FechaPago DATE NOT NULL,
  Cantidad DECIMAL(15,2) NOT NULL
) engine=innodb;