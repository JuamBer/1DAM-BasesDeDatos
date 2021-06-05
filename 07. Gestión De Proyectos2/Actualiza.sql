USE GestionProyectos2;

/*Obtener toda la información sobre los Proveedores que se encuentren en estado de
Espera o en estado Inactivo*/
SELECT * FROM proveedor WHERE estado LIKE "Espera" OR "Inactivo";

/*Obtener toda la información sobre los proyectos de “Londres*/
SELECT * FROM proyectos WHERE ciudad LIKE "Londres";

/*Obtener los códigos de proveedores que suministren al proyecto “Py01”*/
SELECT cod_pro FROM proveedor WHERE cod_pro LIKE "Py01";

/*Obtener toda la información sobre pedidos cuya cantidad esté entre 300 y 750
unidades*/
SELECT * FROM pedidos WHERE cantidad > 300 AND cantidad < 750;

/*Obtener los códigos de proyectos a los que sólo suministre el proveedor con código
“Prov01”*/
SELECT cod_pry FROM pedidos WHERE cod_pro LIKE "Prov01";


/*Obtener todos los atributos de las piezas que se hayan pedido a un proveedor en
estado Activo*/
SELECT pieza.cod_pie, pieza.nom, pieza.color, pieza.peso, pieza.ciudad FROM pieza 
INNER JOIN pedidos ON pieza.cod_pie = pedidos.pieza
INNER JOIN proveedor ON proveedor.cod_pro = pedidos.proveedor
WHERE proveedor.estado LIKE "Activo";


/*Obtener en una única lista todas las ciudades que se utilizan en el sistema, tales
que pertenezcan bien a un proveedor, a una pieza o a un proyecto*/
SELECT DISTINCT pieza.ciudad AS "CIUDAD" FROM pieza UNION
SELECT DISTINCT proveedor.ciudad FROM proveedor UNION
SELECT DISTINCT proyecto.ciudad FROM proyecto;


/*Obtener los códigos de las piezas pedidas a los proveedores de “Londres”*/
SELECT pieza.cod_pie FROM pieza
INNER JOIN pedidos ON pieza.cod_pie = pedidos.pieza
INNER JOIN proveedor ON proveedor.cod_pro = pedidos.proveedor
WHERE proveedor.ciudad LIKE "Londres";

/*Obtener los códigos de pieza pedidas por los proyectos de “Berlin”*/
SELECT pieza.cod_pie FROM pieza
INNER JOIN pedidos ON pieza.cod_pie = pedidos.pieza
INNER JOIN proyecto ON proyecto.cod_pry = pedidos.proyecto
WHERE proyecto.ciudad LIKE "Berlin";

/*Obtener los códigos de pieza suministradas por un proveedor de “Madrid” a un
proyecto de “Madrid”*/
SELECT pieza.cod_pie FROM pieza
INNER JOIN pedidos ON pieza.cod_pie = pedidos.pieza
INNER JOIN proyecto ON proyecto.cod_pry = pedidos.proyecto
WHERE proyecto.ciudad LIKE "Berlin";

/*Obtener todos los pares de ciudades, tales que un proveedor de la primera
suministra piezas a un proyecto de la segunda*/
SELECT proveedor.cod_pro AS COD_PROVEEDOR, proveedor.ciudad AS CIUDAD_PROVEEDOR, proyecto.ciudad AS CIUDAD_PROYECTO FROM proveedor
INNER JOIN pedidos ON proveedor.cod_pro = pedidos.proveedor
INNER JOIN proyecto ON proyecto.cod_pry = pedidos.proyecto
WHERE proyecto.ciudad LIKE proveedor.ciudad;

/*Obtener los códigos de pieza suministradas a cualquier proyecto por un proveedor
de la misma ciudad que el proyecto*/
SELECT pieza.cod_pie FROM pieza
INNER JOIN pedidos ON pieza.cod_pie = pedidos.pieza
INNER JOIN proveedor ON proveedor.cod_pro = pedidos.proveedor
INNER JOIN proyecto ON proyecto.cod_pry = pedidos.proyecto
WHERE proyecto.ciudad LIKE proveedor.ciudad;

/*Obtener todos los códigos de proyecto a los cuales suministre al menos un
proveedor de una ciudad distinta a la del proyecto*/
SELECT proyecto.cod_pry FROM proyecto
INNER JOIN pedidos ON proyecto.cod_pry = pedidos.proyecto
INNER JOIN proveedor ON proveedor.cod_pro = pedidos.proveedor
WHERE proyecto.ciudad NOT LIKE proveedor.ciudad;

/*Obtener los códigos de proyectos cuya ciudad empieza por “A”*/
SELECT proyecto.cod_pry FROM proyecto
WHERE proyecto.ciudad LIKE "A%";

/*Obtener los códigos de proyectos a los que no suministra ninguna pieza de color
“rojo” un proveedor de “Londres”*/
SELECT proyecto.cod_pry FROM proyecto
INNER JOIN pedidos ON proyecto.cod_pry = pedidos.proyecto
INNER JOIN proveedor ON proveedor.cod_pro = pedidos.proveedor
INNER JOIN pieza ON pieza.cod_pie = pedidos.pieza
WHERE proveedor.ciudad NOT LIKE "Londres" AND pieza.color NOT LIKE "rojo";

/*Obtener los códigos de proveedor, pieza y proyecto que no se ubiquen en la misma
ciudad. (al menos una de las ciudades sea distinta)*/
SELECT proveedor.cod_pro, proyecto.cod_pry, pieza.cod_pie FROM proveedor
INNER JOIN pedidos ON proveedor.cod_pro = pedidos.proveedor
INNER JOIN proyecto ON proyecto.cod_pry = pedidos.proyecto
INNER JOIN pieza ON pieza.cod_pie = pedidos.pieza
WHERE proveedor.ciudad NOT LIKE pieza.ciudad 
OR proyecto.ciudad NOT LIKE pieza.ciudad 
OR proveedor.ciudad NOT LIKE proveedor.ciudad;

/*Obtener los códigos de proveedor, pieza y proyecto que se ubiquen en la misma
ciudad.*/
SELECT proveedor.cod_pro, proyecto.cod_pry, pieza.cod_pie FROM proveedor
INNER JOIN pedidos ON proveedor.cod_pro = pedidos.proveedor
INNER JOIN proyecto ON proyecto.cod_pry = pedidos.proyecto
INNER JOIN pieza ON pieza.cod_pie = pedidos.pieza
WHERE proveedor.ciudad LIKE pieza.ciudad AND proveedor.ciudad LIKE proyecto.ciudad;