USE cosasdeperros2;

/*Todos los datos de las Asociaciones cuyo ámbito es “Madrid”*/
SELECT * FROM asociacion WHERE ambito LIKE "Madrid";

/*Todos los datos de los Propietarios de “Valencia”*/
SELECT * FROM propietario WHERE ciudad LIKE "Valencia";

/*Todos los datos de los Perros de raza “Labrador"*/
SELECT * FROM perro WHERE raza LIKE "Labrador";

/*Todos los datos de las Escuelas de categoría “Internacional”*/
SELECT * FROM escuela WHERE categoria LIKE "Internacional";

/*Obtener una lista con la placa y nombre de todos los perros*/
SELECT n_placa,nombre FROM perro;

/*Obtener una lista con el CIF y ámbito de todas las asociaciones*/
SELECT cif,ambito FROM asociacion;

/*Obtener una lista con el DNI, nombre y ciudad de todos los propietarios.*/
SELECT dni,nombre,ciudad FROM propietario;

/*Obtener una lista con el nombre, teléfono y categoría de todas las escuelas.*/
SELECT nombre,telefono,categoria FROM escuela;

/*Obtener la placa y nombre de todos los perros que sean de raza chihuahua*/
SELECT n_placa,nombre FROM perro WHERE raza LIKE "Chihuahua";

/*Obtener el CIF y nombre de todas las asociaciones de ámbito “Barcelona”*/
SELECT cif,nombre FROM asociacion WHERE ambito LIKE "Barcelona";

/*Obtener el DNI y nombre de todos los propietarios que residan en Cuenca*/
SELECT cif,nombre FROM asociacion WHERE ambito LIKE "Cuenca";

/*Obtener el DNI de los propietarios que pertenecen a alguna asociación de ámbito nacional*/
SELECT dni_drop,nombre FROM pertenecer INNER JOIN asociacion ON pertenecer.cif_asoc = asociacion.cif
WHERE asociacion.ambito LIKE "Nacional";

/*Obtener la placa de los perros que han sido adiestrados en alguna escuela de Valencia*/
SELECT n_placa FROM adiestrar INNER JOIN escuela ON adiestrar.cif_esc = escuela.cif WHERE escuela.ciudad LIKE "Valencia";

/*Obtener todos los datos de los perros cuyo propietario sea de Sevilla*/
SELECT * FROM perro INNER JOIN propietario ON propietario.dni = perro.dni_prop WHERE propietario.ciudad LIKE "Sevilla";

/*Obtener todos los datos de los propietarios que han adiestrado a sus perros en escuelas de Barcelona*/
SELECT * FROM perro INNER JOIN propietario ON propietario.dni = perro.dni_prop WHERE propietario.ciudad LIKE "Sevilla";

/*Obtener la categoría y dirección de las escuelas en las que hayan adiestrado perros los propietarios 
que son de la ciudad de Toledo*/
SELECT categoria,escuela.direccion FROM escuela 
INNER JOIN adiestrar ON escuela.cif = adiestrar.cif_esc 
INNER JOIN perro USING(n_placa)
INNER JOIN propietario ON propietario.dni = perro.dni_prop
WHERE propietario.ciudad LIKE "Toledo";

/*Obtener todos los datos de los perros adiestrados en la escuela “Guau”*/
SELECT * FROM perro INNER JOIN adiestrar USING(n_placa)
INNER JOIN escuela ON adiestrar.cif_esc = escuela.cif;

/*Obtener el DNI y nombre de los propietarios que adiestran a sus perros en la escuela “Muerde y se Feliz”*/
SELECT propietario.dni,propietario.nombre FROM propietario 
INNER JOIN perro ON propietario.dni = perro.dni_prop
INNER JOIN adiestrar USING(n_placa)
INNER JOIN escuela ON escuela.cif = adiestrar.cif_esc
WHERE escuela.nombre = "Muerte y se Feliz";

/*Obtener el DNI y nombre de los propietarios que pertenecen a la asociación “Amos realizados”*/
SELECT propietario.dni,propietario.nombre FROM propietario 
INNER JOIN pertenecer ON propietario.dni = pertenecer.dni_drop
INNER JOIN asociacion ON asociacion.cif = pertenecer.cif_asoc
WHERE asociacion.nombre = "Amos realizados";

/*Obtener el DNI y nombre de los propietarios que aparecen en las dos consultas anteriores, no vale 
que aparezcan solo en una*/
SELECT propietario.dni,propietario.nombre FROM propietario 
INNER JOIN perro ON propietario.dni = perro.dni_prop
INNER JOIN adiestrar USING(n_placa)
INNER JOIN escuela ON escuela.cif = adiestrar.cif_esc
INNER JOIN pertenecer ON propietario.dni = pertenecer.dni_drop
INNER JOIN asociacion ON asociacion.cif = pertenecer.cif_asoc
WHERE escuela.nombre = "Muerte y se Feliz" AND asociacion.nombre = "Amos realizados";