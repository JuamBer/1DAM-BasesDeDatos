USE GestionProyectos;
SET SQL_SAFE_UPDATES = 0;

/* 3. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escribe la
Sentencia de SQL que nos permite agregar a la tabla Pedidos un nuevo atributo
llamado comentario que permitirá escribir observaciones sobre el pedido de hasta
255 caracteres */
ALTER TABLE Pedidos ADD comentario VARCHAR(255);

/* 4. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escribe la
Sentencia de SQL que nos permite ampliar el tamaño del campo nom de la tabla
PIEZA a 40 caracteres */
ALTER TABLE Pieza MODIFY COLUMN nom VARCHAR(40);

/* 5. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escribe la
sentencia que nos permite añadir los siguientes datos en la tabla PROYECTO,
teniendo en cuenta que puede ocurrir que algún código ya esté en la tabla, en tal
caso no queremos que sobrescriba la fila, lo desechamos */
INSERT IGNORE INTO Proyecto(cod_pry,nom,ciudad,fase) VALUES("Py21","Proyecto 21","Madrid","Inicial");
INSERT IGNORE INTO Proyecto(cod_pry,nom,ciudad,fase) VALUES("Py42","Proyecto 42","Londres","Prototipo");
INSERT IGNORE INTO Proyecto(cod_pry,nom,ciudad,fase) VALUES("Py38","Proyecto 38","Jakarta","Desarrollo");

/* 6. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escribe la
sentencia que nos permite modificar todos los códigos de proyecto de ‘Py??’ es
decir, Py con dos cifras a ‘PR??’ Es decir, PR con las mismas dos cifras que habia */
UPDATE Proyecto SET cod_pry = CONCAT('PR', SUBSTRING(cod_pry,3,LENGTH(cod_pry)-2) ) WHERE cod_pry LIKE 'Py%';
		/* ESTOS UPDATES LOS HE USADO PARA HACER PRUEBAS */
		/*UPDATE Proyecto SET cod_pry = "Py21" WHERE cod_pry LIKE 'PR21';
		UPDATE Proyecto SET cod_pry = "Py38" WHERE cod_pry LIKE 'PR38';
		UPDATE Proyecto SET cod_pry = "Py42" WHERE cod_pry LIKE 'PR42';*/

/* 7. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escribe la
sentencia que nos permita borrar TODA la información relativa a los los 5
proveedores en estado Inactivo que tengan el código más bajo​ */
DELETE FROM Proveedor WHERE estado LIKE "Inactivo";

/* 8. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escribe la
sentencia que nos permita cambiar el estado de los pedidos de la siguiente forma:.
a. Si el pedido esta en ‘Preparación’ marcarlo como ‘enviado’
b. Si esta en ‘Recibido’ marcarlo como ‘OK’.
c. En cualquier otro caso marcarlo como ‘Devuelto’ */
UPDATE Pedidos SET estado = CASE 
     WHEN estado = "Enviado" THEN "Preparacion"   
     WHEN estado = "Recibido" THEN "Preparacion"
     ELSE "Devuelto" END;
     
/* 9. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escirbe la
sentencia que nos permita actualizar la tabla PROVEEDOR de tal forma que el
campo ciudad pase a llamarse licencia que sea de 20 caracteres y aparezca entre el
nombre y el cif */
ALTER TABLE Proveedor RENAME COLUMN ciudad TO licencia;
ALTER TABLE Proveedor MODIFY COLUMN licencia VARCHAR(20);
ALTER TABLE Proveedor MODIFY licencia VARCHAR(20) AFTER CIF;

/* 10. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escirbe la
sentencia​ que nos permita actualizar la tabla SEDE de tal forma que:*/

	/* a. Añadimos un campo llamado licencia de 15 caracteres y lo establecemos
	como clave alternativa, debe estar situado entre cod_sede y nom */
	ALTER TABLE Sede ADD licencia VARCHAR(15) AFTER cod_sede;

	/* b. Eliminamos los campos responsable y ciudad */
	ALTER TABLE Sede DROP COLUMN responsable; 
	ALTER TABLE Sede DROP COLUMN ciudad;

	/* c. Necesitamos un campo para guardar el email, de 40 caracteres */
	ALTER TABLE Sede ADD email VARCHAR(40);
    
    /* d. Queremos que el campo país sea obligatorio */
    ALTER TABLE Sede MODIFY pais VARCHAR(45) NOT NULL;

/* 11. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escribe la
sentencia que nos permita crear la clave principal en la tabla PEDIDOS​ */
ALTER TABLE Pedidos ADD PRIMARY KEY (proveedor,pieza,proyecto);

/* 12. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escribe la
sentencia que nos permita crear las claves ajenas en la tabla PEDIDOS​ */
ALTER TABLE Pedidos ADD FOREIGN KEY (proveedor) REFERENCES Proveedor (cod_pro) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Pedidos ADD FOREIGN KEY (pieza) REFERENCES Pieza (cod_pie) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Pedidos ADD FOREIGN KEY (proyecto) REFERENCES Proyecto (cod_pry) ON UPDATE CASCADE ON DELETE CASCADE;

/* 13. Sabiendo que ya estamos trabajando en la BD GestionProyectos, escribe la
sentencia que nos permita añadir los siguientes proveedores​ */
INSERT INTO Proveedor(nom,estado,CIF,tel,codPostal) VALUES ("Prov001","Inactivo","00229933A","963332244","55522");
INSERT INTO Proveedor(nom,estado,CIF,tel,codPostal) VALUES ("Prov120","Espera","12556688D","965553366","66633");

/* 14. Escribe la sentencia que nos permita borrar todos los proyectos con sede en Italia.​ */
DELETE FROM Proyecto WHERE sede LIKE (SELECT cod_sede FROM Sede WHERE pais LIKE "Italia");