USE Dentista;
SET GLOBAL log_bin_trust_function_creators = 1;

-- DESCUENTO EN TODOS LOS TRATAMIENTOS DEL 30%
delimiter //
CREATE TRIGGER DescuentoTratamiento BEFORE INSERT ON Tratamiento
FOR EACH ROW
BEGIN
	SET NEW.precio = NEW.precio*0.7;
END
//
-- PRECIO MÁXIMO POR TRATAMIENTO 99EUROS
delimiter //
CREATE TRIGGER TratamientoCaro BEFORE INSERT ON Tratamiento
FOR EACH ROW
BEGIN
	IF (NEW.precio) > 999.000 THEN 
		SET NEW.precio = 999;
	END IF;
END
//

INSERT INTO Tratamiento(siglas, nombre, comentario, etapas, precio) VALUES ('ENDU', 'Endodoncia Uniradicular',".",6,700);
INSERT INTO Tratamiento(siglas, nombre, comentario, etapas, precio) VALUES ('CAR', 'Cardiaca',".",5,900);
INSERT INTO Tratamiento(siglas, nombre, comentario, etapas, precio) VALUES ('RES', 'Respiratoria',".",3,1100);
INSERT INTO Tratamiento(siglas, nombre, comentario, etapas, precio) VALUES ('MSE', 'Músculo Esquelética',".",1,2100);
INSERT INTO Tratamiento(siglas, nombre, comentario, etapas, precio) VALUES ('MSE', 'Músculo Esquelética',".",1,4100);

-- FUNCIÓN QUE DEVUELVE UN BOOLEANO DEPENDIENDO DE LA EDAD
delimiter //
CREATE FUNCTION esMenor (edad INT) RETURNS BOOLEAN
BEGIN
	IF (edad < 18) THEN 
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END
//
-- SI ES MENOR DE EDAD SALTA UN ERROR
delimiter //
CREATE TRIGGER MenorDeEdad AFTER INSERT ON Paciente
FOR EACH ROW
BEGIN
	IF (SELECT esMenor(NEW.edad)) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ES MENOR DE EDAD';
	END IF;
END
//

INSERT IGNORE INTO Paciente (nombre,apellido_1,apellido_2,edad,sexo,fecha_nac,telefono) VALUES ('Alex','Roca','Cruz',40,'M','1955/01/05','087456322');
INSERT IGNORE INTO Paciente (nombre,apellido_1,apellido_2,edad,sexo,fecha_nac,telefono) VALUES ('Carmen',' Lopez','Solís',18,'V','1995/01/01','187456325');
INSERT IGNORE INTO Paciente (nombre,apellido_1,apellido_2,edad,sexo,fecha_nac,telefono) VALUES ('Juan','Sáez','García',15,'M','1995/01/01','987456321');


