/*HACEMOS REFERENCIA A LA BASE DE DATOS DENTISTA*/
USE Dentista;

/*TIPOS DE INSERTS INSERTS*/

	/*SEÑALANDO CAMPOS*/
	INSERT INTO Seguro(id_seguro, nom_seg, tipo) VALUES ("1","ADESLAS","I"); 
    
	/* SIN SEÑALAR CAMPOS */
	INSERT INTO Seguro VALUES(2,'ASISA','I'); 
	INSERT INTO Seguro VALUES(3,'SANITAS','N');
    
	/* ID AUTOINCREMENTABLE */
	INSERT INTO Seguro(nom_seg, tipo) VALUES('CIGNA','N');
	INSERT INTO Seguro(nom_seg, tipo) VALUES('DKV','N');
    
	/* IGNORE */
	INSERT IGNORE INTO Seguro VALUES('6','MAPFRE','I'); 
	INSERT IGNORE INTO Seguro VALUES('3','CASER','N');
    
	/*AÑADIR MUCHOS REGISTROS*/
	INSERT INTO Seguro(nom_seg, tipo) VALUES 
	("CASER","N"),
	("GRUPAMA","P"),
	("AGRUPACIO MUTUA","P"),
	("ALLIANZ","N");
    
	/*CON CONDICIÓN*/
	INSERT INTO Seguro VALUES (10,'un seguro','P') ON DUPLICATE KEY UPDATE tipo=NULL;

INSERT INTO Paciente(nom, ape_1, ape_2, sexo, f_nac, tel) VALUES 
("José", "Martínez", "Gómez", "V", "1980/02/12", "961223344"),
("Carmen", "Garía", "Solís", "M", "1995/01/01", "962334455"),
("Fernando", "Ruíz", "Muñoz", "V", "1990/04/05", "963445566"),
("Nelly", "Pérez", "Campos", "M", "1994/10/18", "964556677"),
("Paco", "Santillana", "Meniz", "V", "1998/09/25", "965667788"),
("Juan", "Sáez", "García", "V", "2002/08/08", "665020636"),
("Ivanzon", "Soriano", "ElPanzon", "V", "2001/01/19", "633157402"),
("Javi", "Lopez", "Martinez", "V", "1999/02/13", "661142265");

/*SENTENCIA DELETE CON CONDICIÓN*/
DELETE FROM Paciente WHERE id_paciente = 6;

INSERT INTO Tratamiento(cod_trat, descripcion, precio) VALUES 
("ENDU", "Endodoncia Uniradicular", 1200),
("EXOQ", "Endodoncia Quirúrgica", 500),
("ORTO", "Ortodoncia", 2000),
("RX", "Radiografía", 2000),
("OPER", "Operación", 4000),
("RADT", "Radioterápia", 3000);

DELETE FROM Tratamiento WHERE id_tratamiento = 5;

INSERT INTO Visitas(id_paciente, cod_trat, fecha_visita) VALUES 
(1, "RX", "2010/05/10"),
(1, "EXOQ", "2011/07/04"),
(1, "RX", "2012/08/01"),
(2, "ENDU", "2012/02/11"),
(2, "EXOQ", "2012/03/06"),
(2, "ORTO", "2012/05/20"),
(2, "RX", "2013/07/18"),
(3, "RX", "2012/08/01"),
(3, "RX", "2013/09/10"),
(3, "ORTO", "2013/10/15"),
(7, "RX", "2013/03/08"),
(7, "ORTO", "2014/08/04"),
(7, "RADT", "2020/01/10"),
(8, "ENDU", "2011/07/25"),
(8, "RADT", "2020/01/23"),
(8, "EXOQ", "2021/01/10");

/*SENTENCIA UPDATE CON CONDICIÓN*/
UPDATE Paciente SET edad = year(now())-EXTRACT(YEAR FROM f_nac) WHERE id_paciente = 1;
UPDATE Paciente SET edad = year(now())-EXTRACT(YEAR FROM f_nac) WHERE id_paciente = 2;
UPDATE Paciente SET edad = year(now())-EXTRACT(YEAR FROM f_nac) WHERE id_paciente = 3;
UPDATE Paciente SET edad = year(now())-EXTRACT(YEAR FROM f_nac) WHERE id_paciente = 4;
UPDATE Paciente SET edad = year(now())-EXTRACT(YEAR FROM f_nac) WHERE id_paciente = 5;
UPDATE Paciente SET edad = year(now())-EXTRACT(YEAR FROM f_nac) WHERE id_paciente = 7;
UPDATE Paciente SET edad = year(now())-EXTRACT(YEAR FROM f_nac) WHERE id_paciente = 8;

/*INSERT CON UN SELECT*/
INSERT IGNORE INTO Mujeres SELECT id_paciente, nom, ape_1, ape_2, edad, tel FROM dentista.paciente WHERE sexo='M';
INSERT IGNORE INTO Hombres SELECT id_paciente, nom, ape_1, ape_2, edad, tel FROM dentista.paciente WHERE sexo='V';