
/*Obtener todos los datos del todos los pacientes*/
SELECT * FROM dentista2.paciente;

/*Obtener todos los datos del todos los tratamientos*/
SELECT * FROM dentista2.tratamiento;

/*Obtener todos los datos del todas las visitas*/
SELECT * FROM dentista2.visitas;

/*Obtener el nombre, dos apellidos y edad de todos los pacientes*/
SELECT nom,ape_1,ape_2,edad FROM dentista2.paciente;

/*Obtener la descripción y el precio de todos los tratamientos*/
SELECT coment, precio FROM dentista2.tratamiento;

/*Obtener el número de visita y el código del tratamiento realizado para todas las visitas*/
SELECT nvisita, Tratamiento FROM dentista2.visitas;

/*Obtener el nombre, dos apellidos y edad de todos los pacientes menores de 60 años*/
SELECT nom,ape_1,ape_2,edad FROM dentista2.paciente WHERE edad < 60;

/*Obtener la descripción y el precio de todos los tratamientos cuyo precio sea mayor de 5000€*/
SELECT coment,precio FROM dentista2.tratamiento WHERE precio > 5000;

/*Obtener el número de visita y el código del tratamiento realizado para 
todas las visitas, siempre y cuando el código del tratamiento empiece por 'E'*/
SELECT nvisita,Tratamiento FROM dentista2.visitas WHERE Tratamiento LIKE "E%";

/*Obtener el nombre, dos apellidos y edad de todos los pacientes menores de 
60 años, ordenados alfabéticamente por el primer apellido*/
SELECT nom,ape_1,ape_2,edad FROM dentista2.paciente WHERE edad < 60 ORDER BY ape_1 ASC;

/*Obtener la descripción y el precio de todos los tratamientos cuyo precio 
sea mayor de 5000€, ordenados descendentemente por el precio*/
SELECT coment,precio FROM dentista2.tratamiento WHERE precio > 5000 ORDER BY precio DESC;

/*Obtener el número de visita y el código del tratamiento realizado para todas 
las visitas, si el código del tratamiento empieza por ' E ', y ordenados ascendente 
por el codtrat y descendentemente por el numvisita.*/
SELECT nvisita,Tratamiento FROM dentista2.visitas WHERE Tratamiento LIKE "E%" ORDER BY Tratamiento ASC, nvisita DESC;

/*Obtener listado con el nombre y dos apellidos (como nombre) y edad de todos los pacientes 
menores de 60 años, ordenados alfabéticamente por el primer apellido*/
SELECT CONCAT(nom," ",ape_1," ",ape_2) AS nombre, edad FROM dentista2.paciente WHERE edad < 60  ORDER BY ape_1 ASC;
/*Obtener la suma de los precios de todos los tratamientos con el nombre de Tratamiento completo*/
SELECT SUM(precio) AS Tratamiento_Completo FROM dentista2.tratamiento;

/*Obtener el código del paciente y total de visitas hechas*/
SELECT paciente, COUNT(*) AS Total_Visitas FROM dentista2.visitas GROUP BY paciente;

/*Obtener listado con el código, nombre y 1º apellido de cada paciente junto con el 
número total de visitas realizadas*/
	/* Si la clave ajena y la primaria se llaman igual */ 
	SELECT paciente,nom,ape_1, COUNT(nvisita) AS Visitas FROM dentista2.visitas INNER JOIN dentista2.visitas USING(paciente) GROUP BY(paciente);
	/* Si la clave ajena y la primaria no se llaman igual */ 
	SELECT paciente,nom,ape_1, COUNT(nvisita) AS Visitas FROM dentista2.visitas  INNER JOIN dentista2.visitas ON paciente.codpac = visitas.paciente GROUP BY(paciente);

/*Obtener la suma total de cada tratamiento que se ha obtenido en las visitas */
SELECT tratamiento.Tratamiento,tratamiento.coment, SUM(tratamiento.precio) AS Total FROM dentista2.tratamiento JOIN dentista2.visitas USING(codtrat) GROUP BY visitas.codtrat;

/*Obtener el código del paciente su nombre, primer apellido, junto con el número total de 
visitas hechas a la clínica y el total de dinero que se ha gastado en los tratamientos.*/
SELECT codpac, nom, ape_1, COUNT(nvisita) AS "Total Visitas", SUM(precio) AS "Total Pecio" 
FROM (dentista2.paciente INNER JOIN dentista2.visitas ON paciente.codpac = visitas.paciente)
INNER JOIN dentista2.tratamiento ON visitas.Tratamiento = tratamiento.Nombre_Tratamiento GROUP BY codpac;
