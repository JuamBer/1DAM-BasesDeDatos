USE jardineria;
SET SQL_SAFE_UPDATES = 0;

/* 1. Inserta una oficina en Fuenlabrada */
INSERT IGNORE INTO Oficinas VALUES ("FUE-ES","Fuenlabrada","España","España","28940","+34665020636","C/ de Móstoles, 25 28943 Fuenlabrada",NULL);

/* 2. Inserta un empleado para la oficina de Fuenlabrada que se representante de ventas */
INSERT IGNORE INTO Empleados VALUES (32,"Juan","Sáez","García","3211","contacto@juamber.com","FUE-ES",NULL,"Representante de Ventas");

/* 3. Inserta un cliente del representante de ventas insertado en el punto anterior */
INSERT IGNORE INTO Clientes VALUES (39,"Giorgio Tara","Pepe","Lopez","+36665020646","FaxGiorgioTara","Plaza Músico Ibars, 5,6",NULL,"Fuenlabrada","Madrid","España","46920",32,8000);

/* 4. Inserta un pedido del cliente anterior (con su detalle) de al menos dos productos */
INSERT IGNORE INTO Pedidos VALUES (129,"2021-02-17","2021-02-20","2021-02-21","Pendiente","Todo según lo previsto",39);
INSERT IGNORE INTO DetallesPedidos VALUES (129,"11679",2,14.00,1);
INSERT IGNORE INTO DetallesPedidos VALUES (129,"AR-001",1,1.00,1);
INSERT IGNORE INTO DetallesPedidos VALUES (129,"FR-106",5,11.00,2);

/* 5. Actualiza el código del cliente insertado y averigua si hubo cambios en las tablas relacionadas */
/* He tenido que poner "ON UPDATE CASCADE" y "ON DELETE CASCADE" en la clave ajena para que actualice el cambio en todas las tablas relacionadas */
UPDATE IGNORE Clientes SET CodigoCliente = 40 WHERE CodigoCliente = 39;

/* 6. Borra el cliente y verifica si hubo cambios */
DELETE FROM Clientes WHERE CodigoCliente = 40;

/* 1. Borrar los clientes que no tienen pedidos */
DELETE IGNORE FROM Clientes WHERE CodigoCliente NOT IN (SELECT CodigoCliente FROM Pedidos);

/* 2. Incrementa en un 20% el precio de los productos que no tengan pedidos */
UPDATE IGNORE Productos SET PrecioVenta = PrecioVenta*1.2 WHERE CodigoProducto NOT IN (SELECT CodigoProducto FROM DetallesPedidos);

/* 3. Borra los pagos del cliente con menor límite de crédito */
DELETE IGNORE FROM Pagos WHERE CodigoCliente LIKE 
(SELECT CodigoCLiente FROM Clientes WHERE LimiteCredito LIKE 
(SELECT MIN(LimiteCredito) FROM Clientes));

/* 4. Establecer a 0 el límite de crédito del cliente que menos unidades pedidas tenga del producto `OR-179' */
UPDATE IGNORE Clientes SET LimiteCredito = 0 WHERE CodigoCliente LIKE 
(SELECT CodigoCliente FROM Pedidos WHERE CodigoPedido LIKE
(SELECT CodigoPedido FROM DetallesPedidos WHERE CodigoProducto = 'OR-179' AND Cantidad LIKE 
(SELECT MIN(Cantidad) FROM DetallesPedidos)));
 
/* 1. Modifica la tabla DetallePedidos para insertar un campo numérico llamado
IVA. Mediante una transacción, establece el valor de ese campo a 18 para
aquellos registros cuyo pedido tenga fecha a partir de Julio de 2010. A
continuación actualiza el resto de Pedidos estableciendo al 16 el IVA.*/ 
ALTER TABLE DetallesPedidos ADD IVA INT;
UPDATE IGNORE DetallesPedidos SET IVA = 16 WHERE CodigoPedido IN (SELECT CodigoPedido FROM Pedidos WHERE FechaPedido < CAST('2010-07-01' AS DATE));
UPDATE IGNORE DetallesPedidos SET IVA = 18 WHERE CodigoPedido IN (SELECT CodigoPedido FROM Pedidos WHERE FechaPedido > CAST('2010-07-01' AS DATE));

/* 2. Modifica la tabla DetallePedidos para incorporar un campo numérico llamado
TotalLinea y actualiza todos sus registros para calcular su valor con la
fórmula TotalLinea=PrecioUnidad*Cantidad*IVA/100 */
ALTER TABLE DetallesPedidos ADD TotalLinea INT;
UPDATE IGNORE DetallesPedidos SET TotalLinea = PrecioUnidad*Cantidad*IVA/100;

/* 3. Borra el cliente que menor limite de crédito tenga. ¿ Es posible borrarlo sólo con una consulta? */
DELETE IGNORE FROM Clientes WHERE LimiteCredito IN(
SELECT * FROM (SELECT Min(Alias.LimiteCredito) FROM Clientes Alias) TEMPDATA);
