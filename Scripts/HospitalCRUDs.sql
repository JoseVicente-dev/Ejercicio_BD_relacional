/*
INSTRUCCIONES

Ejecutar cada sentencia por separado. 
Las consultas intermedias le permitirán ver el antes y el  después de las tablas para cada accion
*/

/* ----------------------------------------CRUDs---------------------------------------- */
/* ----------------------------------------CRUDs flujo principal ingreso paciente---------------------------------------- */

insert into paciente values('D001-','Edgar','','Murillo','','2015-08-11','155454552','camino','5','87','165'); #Creacion del paciente (CREATE)
select * from paciente where numHistoriaClinica = 'D001-';#Una consulta (READ)al paciente creado

insert into ingreso(numHistoriaClinica,fecha,diagnostico,idServicio) values('D001-','2016-06-24','Fiebre','01');#Ingreso del paciente al servicio Pediatria
call aumentarIngreso('D001-');#Aumento del contador de ingresos
select * from ingreso where (numHistoriaClinica, numIngreso) = ('D001-',1);#Una consulta (READ) al paciente ingresado

insert into revision(informe,hora,fecha,numHistoriaClinica,numIngreso,numDeColegiado) VALUES ('Se detecta infeccion intestinal','02:00','2016-06-24','D001-',1,'M003');#Se realiza la  revision por parte del médico
select * from revision;

insert into receta(unidosisConsumidas,fecha,numHistoriaClinica,numIngreso,numDeColegiado,numDeRegistro) values(1,'2016-06-24','D001-',1,'M003','F-005');#Se receta el medicamento por parte del medico trantante
select * from farmaco where numDeRegistro = 'F-005';
call restarFarmaco(1,'F-005');#Se hace el descuento de las unidosis disponibles del medicamento recetado
select * from farmaco where numDeRegistro = 'F-005';
select * from receta;

insert into revision(informe,hora,fecha,numHistoriaClinica,numIngreso,numDeColegiado) VALUES ('El paciente presenta mejoría y se da de alta','10:00','2016-06-26','D001-',1,'M003');#Se realiza una nueva revision por parte del médico
select * from revision;

update ingreso set fechaDeAlta='2016-06-26' where (numHistoriaClinica, numIngreso) = ('D001-',1);#Se actualiza(UPDATE) la fecha de alta del ingreso
select * from ingreso where (numHistoriaClinica, numIngreso) = ('D001-',1);#Una consulta (READ) al paciente ingresado

delete from revision where idRevision=5;#Una elimininacion(DELETE) de la revision
select * from revision;

/* ----------------------------------------CRUDs flujo principal ingreso paciente - fin---------------------------------------- */

/* ----------------------------------------CRUD tablas maestras ---------------------------------------- */
/* ---------------------------------------- CRUD a tabla Medico ---------------------------------------- */
select * from receta;#Consulta a la tabla relacionada Receta para mostrar el estado del CRUD en cada accion

update medico set numDeColegiado='M033' where numDeColegiado ='M003'; #UPDATE fila en tabla Medico
select * from receta;
select * from medico;#Consulta READ a la tabla para mostrar el estado del CRUD en cada accion

set FOREIGN_KEY_CHECKS=0;
delete from medico where numDeColegiado ='M033'; #DELETE fila en tabla Medico
select * from medico;
set FOREIGN_KEY_CHECKS=1;
select * from receta;

insert into medico values('M033','Daniel','','Londoño','Ramirez','35471236','carrera','5','22','11','01');#CREATE fila en tabla Medico
select * from receta;
/* ---------------------------------------- CRUD a tabla Medico - fin ---------------------------------------- */

/* ---------------------------------------- CRUD a tabla Servicio ---------------------------------------- */
select * from consumoFarmaco;

update servicio set idServicio='99' where idServicio='01';
select * from servicio;
Select * from consumoFarmaco;

set FOREIGN_KEY_CHECKS=0;
delete from servicio where idServicio = '99';
set FOREIGN_KEY_CHECKS=1;
Select * from consumoFarmaco;
select * from servicio;

insert into servicio values ('01','Pediatria');
select * from servicio;
/* ---------------------------------------- CRUD a tabla Servicio - fin ---------------------------------------- */